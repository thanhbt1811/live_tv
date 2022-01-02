import 'package:equatable/equatable.dart';
import 'package:live_tv/model/stream_model.dart';

import 'package:live_tv/model/user_model.dart';

enum ProfileStatus { initial, loading, success, failed, logout }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserModel? user;
  final List<StreamModel> streams;

  ProfileState({required this.status, this.user, required this.streams});

  factory ProfileState.initila() =>
      ProfileState(status: ProfileStatus.initial, streams: []);

  @override
  List<Object?> get props => [status, user, streams];

  ProfileState copyWith(
      {ProfileStatus? status, UserModel? user, List<StreamModel>? streams}) {
    return ProfileState(
        status: status ?? this.status,
        user: user ?? this.user,
        streams: streams ?? this.streams);
  }
}
