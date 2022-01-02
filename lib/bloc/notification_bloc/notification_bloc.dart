import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/notification_bloc/notification_state.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/key_constants.dart';
import 'package:live_tv/services/notification_services.dart';
import 'package:live_tv/services/stromp_services.dart';
import 'package:live_tv/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationBloc extends Cubit<NotificationState> {
  final NotificationServices notificationServices;
  final UserServices userServices;
  final StompServices _stompServices = StompServices.instance;

  NotificationBloc(
      {required this.notificationServices, required this.userServices})
      : super(NotificationState.initial());

  Future<void> getNotification() async {
    emit(
      state.copyWith(status: NotificationStatus.loading),
    );
    final sharePref = await SharedPreferences.getInstance();
    final accessToken = sharePref.getString(KeyConstnants.accessToken);
    final user = await userServices
        .getUser(Configuration.getBearerAuth(accessToken ?? ''));
    final notifications = await notificationServices.getNotification(
      Configuration.getBearerAuth(accessToken ?? ''),
    );
    emit(
      state.copyWith(
          status: NotificationStatus.success,
          notifications: notifications,
          user: user),
    );
  }

  Future<void> subscribeNotification() async {
    _stompServices.subscribeNotification(state.user!.id, (notification) async {
      emit(
        state.copyWith(status: NotificationStatus.loading),
      );
      final sharePref = await SharedPreferences.getInstance();
      final accessToken = sharePref.getString(KeyConstnants.accessToken);
      final notifications = await notificationServices
          .getNotification(Configuration.getBearerAuth(accessToken ?? ''));
      emit(
        state.copyWith(
          status: NotificationStatus.success,
          notifications: notifications,
        ),
      );
    });
  }
}
