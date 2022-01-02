import 'package:flutter_bloc/flutter_bloc.dart';

import 'loader_state.dart';

class LoaderBloc extends Cubit<LoaderState>{
  LoaderBloc() : super(LoadedState());

  Future<void> startLoading() async {
    emit(LoadingState());
  }
  Future<void> finishLoading() async {
    emit(LoadedState());
  }
}