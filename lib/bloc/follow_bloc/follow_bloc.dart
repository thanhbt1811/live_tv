import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/follow_bloc/follow_state.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/key_constants.dart';
import 'package:live_tv/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowBloc extends Cubit<FollowState> {
  final UserServices userServices;

  FollowBloc({required this.userServices}) : super(FollowState.initial());

  Future<void> getUser() async {
    emit(
      state.copyWith(status: FollowStatus.loading),
    );
    final sharePref = await SharedPreferences.getInstance();
    final accessToken = sharePref.getString(KeyConstnants.accessToken);
    final users = await userServices.getUsers(
      Configuration.getBearerAuth(accessToken ?? ''),
    );
    emit(
      state.copyWith(status: FollowStatus.success, users: users),
    );
  }

  Future<void> follow(int userId) async {
    emit(
      state.copyWith(status: FollowStatus.loading),
    );
    final sharePref = await SharedPreferences.getInstance();
    final accessToken = sharePref.getString(KeyConstnants.accessToken);
    await userServices.follow(
        Configuration.getBearerAuth(accessToken ?? ''), userId);
    getUser();
  }

  Future<void> unFollow(int userId) async {
    emit(
      state.copyWith(status: FollowStatus.loading),
    );
    final sharePref = await SharedPreferences.getInstance();
    final accessToken = sharePref.getString(KeyConstnants.accessToken);
    await userServices.unForllow(
        Configuration.getBearerAuth(accessToken ?? ''), userId);
    getUser();
  }
}
