import 'package:equatable/equatable.dart';

abstract class LoaderState extends Equatable {
}

class LoadingState extends LoaderState {
  @override
  List<Object?> get props => [];
}
class LoadedState extends LoaderState {
  @override
  List<Object?> get props => [];

}