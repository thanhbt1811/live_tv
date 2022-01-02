import 'package:equatable/equatable.dart';

enum SignUpStatus { initial, loading, success }

class SignUpState extends Equatable {
  final SignUpStatus status;

  SignUpState({required this.status});

  factory SignUpState.initial() => SignUpState(status: SignUpStatus.initial);

  SignUpState update({SignUpStatus? status}) {
    return SignUpState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
