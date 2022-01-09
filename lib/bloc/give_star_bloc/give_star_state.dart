import 'package:equatable/equatable.dart';

enum GiveStarStatus { initial, getted, loading, success, failed }

class GiveStarState extends Equatable {
  final GiveStarStatus status;
  final String? clientSecret;
  final dynamic error;

  GiveStarState({required this.status, this.clientSecret, this.error});
  factory GiveStarState.initial() =>
      GiveStarState(status: GiveStarStatus.initial);

  @override
  List<Object?> get props => [status, clientSecret, error];

  GiveStarState copyWith({
    GiveStarStatus? status,
    String? clientSecret,
    dynamic error,
  }) {
    return GiveStarState(
      status: status ?? this.status,
      clientSecret: clientSecret ?? this.clientSecret,
      error: error ?? this.error,
    );
  }
}
