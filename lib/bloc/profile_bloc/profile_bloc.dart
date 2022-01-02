import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/profile_bloc/profile_state.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/key_constants.dart';
import 'package:live_tv/services/live_stream_services.dart';
import 'package:live_tv/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Cubit<ProfileState> {
  final UserServices _userServices;
  final StreamServices _streamServices;
  ProfileBloc(this._userServices, this._streamServices)
      : super(ProfileState.initila());

  Future<void> initial() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final sharePref = await SharedPreferences.getInstance();
    final String accessToken = sharePref.getString(KeyConstnants.accessToken)!;
    final user =
        await _userServices.getUser(Configuration.getBearerAuth(accessToken));
    final streams = await _streamServices.getLiveStreamOwned(
      Configuration.getBearerAuth(accessToken),
    );
    emit(state.copyWith(
        status: ProfileStatus.success, user: user, streams: streams));
  }

  Future<void> getStreaming() async {
    emit(
      state.copyWith(status: ProfileStatus.loading),
    );
    final sharePref = await SharedPreferences.getInstance();
    final accessToken = sharePref.getString(KeyConstnants.accessToken);
    final streams = await _streamServices.getLiveStreamOwned(
      Configuration.getBearerAuth(accessToken ?? ''),
    );
    emit(
      state.copyWith(status: ProfileStatus.success, streams: streams),
    );
  }

  Future<void> logOut() async {
    final sharePref = await SharedPreferences.getInstance();
    sharePref.clear();
    emit(
      state.copyWith(status: ProfileStatus.logout),
    );
  }
}
