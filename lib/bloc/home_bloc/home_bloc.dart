import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/home_bloc/home_state.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/key_constants.dart';
import 'package:live_tv/services/live_stream_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBloc extends Cubit<HomeState> {
  final StreamServices streamServices;

  HomeBloc({required this.streamServices}) : super(HomeState.initial());

  Future<void> getStreaming() async {
    emit(
      state.copyWith(status: HomeStatus.loading),
    );
    final sharePref = await SharedPreferences.getInstance();
    final accessToken = sharePref.getString(KeyConstnants.accessToken);
    final streams = await streamServices.getStreaming(
      Configuration.getBearerAuth(accessToken ?? ''),
    );
    emit(
      state.copyWith(status: HomeStatus.success, streams: streams),
    );
  }
}
