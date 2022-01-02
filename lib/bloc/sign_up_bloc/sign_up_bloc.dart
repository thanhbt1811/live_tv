import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/loader_bloc/loader_bloc.dart';
import 'package:live_tv/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:live_tv/bloc/snackbar_bloc/bloc.dart';
import 'package:live_tv/bloc/snackbar_bloc/snackbar_type.dart';
import 'package:live_tv/model/sign_up_model.dart';
import 'package:live_tv/services/authentication_services.dart';
import 'package:live_tv/view/register/reigster_screen_constants.dart';

class SignUpBloc extends Cubit<SignUpState> {
  final AuthenticationServices authenticationServices;
  final LoaderBloc loaderBloc;
  final SnackbarBloc snackbarBloc;

  SignUpBloc(
      {required this.authenticationServices,
      required this.loaderBloc,
      required this.snackbarBloc})
      : super(SignUpState.initial());

  Future<void> signUp(
      {required String username,
      required String password,
      required String email,
      required String displayName}) async {
    loaderBloc.startLoading();
    emit(state.update(status: SignUpStatus.loading));
    final model = SignUpModel(
        displayName: displayName,
        email: email,
        userName: username,
        password: password);
    await authenticationServices.signUp(model.toJson());
    loaderBloc.finishLoading();
    snackbarBloc.add(ShowSnackbar(
        type: SnackBarType.success,
        translationKey: RegisterScreenConstants.registerSuccess));
    emit(state.update(status: SignUpStatus.success));
  }
}
