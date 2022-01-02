import 'package:equatable/equatable.dart';
import 'package:live_tv/model/user_model.dart';

enum FollowStatus { initial, loading, success, failed }

class FollowState extends Equatable {
  final FollowStatus status;
  final List<UserModel> users;
  final DateTime updateAt;

  FollowState(
      {required this.status, required this.users, required this.updateAt});

  factory FollowState.initial() => FollowState(
      status: FollowStatus.initial, users: [], updateAt: DateTime.now());

  FollowState copyWith({FollowStatus? status, List<UserModel>? users}) =>
      FollowState(
          status: status ?? this.status,
          users: users ?? this.users,
          updateAt: DateTime.now());

  @override
  List<Object?> get props => [status, users, updateAt];
}
