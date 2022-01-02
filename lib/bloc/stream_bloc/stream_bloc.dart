import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/stream_bloc/stream_state.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/key_constants.dart';
import 'package:live_tv/services/live_stream_services.dart';
import 'package:live_tv/services/stromp_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StreamBloc extends Cubit<StreamState> {
  final StreamServices streamServices;
  final StompServices stompServices = StompServices.instance;
  StreamBloc({required this.streamServices}) : super(StreamState.initial());

  Future<void> validateDecscription(String description) async {
    if (description.isNotEmpty &&
        description.length > 4 &&
        description.length < 16) {
      emit(
        state.copyWith(isValid: true),
      );
    } else {
      emit(
        state.copyWith(isValid: false),
      );
    }
  }

  Future<void> startStream(String decscription) async {
    emit(
      state.copyWith(status: StreamStatus.loading),
    );
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final accessToken = preferences.getString(KeyConstnants.accessToken);
    final streamModel = await streamServices.livesStream(
      Configuration.getBearerAuth(accessToken ?? ''),
      {'content': decscription},
    );
    emit(state.copyWith(
        status: StreamStatus.streaming, streamModel: streamModel));
    stompServices.subscribeViewCount(streamModel.id, (viewCount) {
      emit(state.copyWith(viewCount: viewCount));
    });
  }
}
