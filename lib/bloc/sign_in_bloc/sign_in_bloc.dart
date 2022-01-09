import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/loader_bloc/loader_bloc.dart';
import 'package:live_tv/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:live_tv/common/constants/key_constants.dart';
import 'package:live_tv/model/sign_in_model.dart';
import 'package:live_tv/services/authentication_services.dart';
import 'package:live_tv/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBloc extends Cubit<SignInState> {
  final AuthenticationServices authenticationServices;
  final UserServices userServices;
  final LoaderBloc loaderBloc;

  SignInBloc(
      {required this.authenticationServices,
      required this.userServices,
      required this.loaderBloc})
      : super(SignInState.initial());

  Future<void> login(SignInModel model) async {
    loaderBloc.startLoading();
    emit(state.update(status: SignInStatus.loading));
    final response = await authenticationServices.signIn(model.toJson());
    final accessTokenMap = json.decode(response);
    log('signIn response: ${accessTokenMap['accessToken']}');
    final sharePref = await SharedPreferences.getInstance();
    sharePref.setString(
        KeyConstnants.accessToken, accessTokenMap['accessToken']);
    loaderBloc.finishLoading();
    emit(state.update(status: SignInStatus.success));
  }
}
