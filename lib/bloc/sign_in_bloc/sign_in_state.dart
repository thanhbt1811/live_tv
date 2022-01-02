import 'package:equatable/equatable.dart';

enum SignInStatus { inital, loading, success }

class SignInState extends Equatable {
  final SignInStatus status;

  SignInState({required this.status});

  factory SignInState.initial() => SignInState(status: SignInStatus.inital);

  SignInState update({SignInStatus? status}) {
    return SignInState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
