import 'package:equatable/equatable.dart';
import 'package:live_tv/model/stream_model.dart';

enum StreamStatus {
  initial,
  initiating,
  initiated,
  loading,
  success,
  failed,
  streaming
}

class StreamState extends Equatable {
  final StreamStatus status;
  final StreamModel? streamModel;
  final bool isValid;
  final int viewCount;
  final DateTime updateAt;

  StreamState(
      {required this.status,
      required this.isValid,
      this.streamModel,
      required this.viewCount,
      required this.updateAt});

  factory StreamState.initial() => StreamState(
      status: StreamStatus.initial,
      isValid: false,
      viewCount: 0,
      updateAt: DateTime.now());

  StreamState copyWith(
          {StreamStatus? status,
          bool? isValid,
          StreamModel? streamModel,
          int? viewCount}) =>
      StreamState(
          status: status ?? this.status,
          isValid: isValid ?? this.isValid,
          streamModel: streamModel ?? this.streamModel,
          viewCount: viewCount ?? this.viewCount,
          updateAt: DateTime.now());

  @override
  List<Object?> get props =>
      [status, isValid, streamModel, viewCount, updateAt];
}
