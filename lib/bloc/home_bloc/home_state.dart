import 'package:equatable/equatable.dart';
import 'package:live_tv/model/stream_model.dart';

enum HomeStatus { initial, loading, success }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<StreamModel> streams;
  final DateTime updateAt;

  HomeState(
      {required this.status, required this.streams, required this.updateAt});

  factory HomeState.initial() => HomeState(
        status: HomeStatus.initial,
        streams: [],
        updateAt: DateTime.now(),
      );

  HomeState copyWith({HomeStatus? status, List<StreamModel>? streams}) {
    return HomeState(
      status: status ?? this.status,
      streams: streams ?? this.streams,
      updateAt: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [status, updateAt];
}
