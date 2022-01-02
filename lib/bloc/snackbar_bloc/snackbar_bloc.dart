import 'package:bloc/bloc.dart';
import 'package:live_tv/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:live_tv/bloc/snackbar_bloc/snackbar_state.dart';

class SnackbarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  SnackbarBloc() : super(InitialSnackbarState());

  SnackbarState get initialState => InitialSnackbarState();

  @override
  Stream<SnackbarState> mapEventToState(SnackbarEvent event) async* {
    if (event is ShowSnackbar) {
      yield ShowSnackBarState(
        translationKey: event.translationKey,
        type: event.type,
        params: event.params ?? [],
        key: event.key,
      );
    }
  }
}
