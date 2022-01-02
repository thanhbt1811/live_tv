import 'package:equatable/equatable.dart';
import 'package:live_tv/model/notification_model.dart';
import 'package:live_tv/model/user_model.dart';

enum NotificationStatus { initial, loading, success, failed }

class NotificationState extends Equatable {
  final NotificationStatus status;
  final List<NotificationModel> notifications;
  final DateTime updateAt;
  final UserModel? user;

  NotificationState(
      {required this.status,
      required this.notifications,
      required this.updateAt,
      this.user});

  factory NotificationState.initial() => NotificationState(
        status: NotificationStatus.initial,
        notifications: [],
        updateAt: DateTime.now(),
      );

  NotificationState copyWith(
          {NotificationStatus? status,
          List<NotificationModel>? notifications,
          UserModel? user}) =>
      NotificationState(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications,
        user: user ?? this.user,
        updateAt: DateTime.now(),
      );
  @override
  List<Object?> get props => [
        status,
        notifications,
        updateAt,
        user,
      ];
}
