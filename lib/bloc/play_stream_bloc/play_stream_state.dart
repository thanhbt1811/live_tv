import 'package:equatable/equatable.dart';

enum PlayStreamStatus { initial, loading, success, failed,end }

class PlayStreamState extends Equatable {
  final PlayStreamStatus status;
  final int viewCount;

  PlayStreamState({
    required this.status,
    required this.viewCount,
  });

  factory PlayStreamState.initial() => PlayStreamState(
        status: PlayStreamStatus.initial,
        viewCount: 0,
      );

  PlayStreamState copyWith({
    PlayStreamStatus? status,
    int? viewCount,
  }) {
    return PlayStreamState(
      status: status ?? this.status,
      viewCount: viewCount ?? this.viewCount,
    );
  }

  @override
  List<Object?> get props => [
        status,
        viewCount,
      ];
}
