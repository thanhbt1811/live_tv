import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/play_stream_bloc/play_stream_state.dart';
import 'package:live_tv/model/stream_model.dart';
import 'package:live_tv/services/live_stream_services.dart';
import 'package:live_tv/services/stromp_services.dart';

class PlayStreamBloc extends Cubit<PlayStreamState> {
  final StreamServices streamServices;
  final StompServices stompServices = StompServices.instance;
  StreamModel? _streamModel;

  PlayStreamBloc({required this.streamServices})
      : super(PlayStreamState.initial());

  Future<void> initial(StreamModel stream) async {
    _streamModel = stream;
    stompServices.subscribeViewCount(stream.id, (viewCount) {
      emit(state.copyWith(viewCount: viewCount));
    });
  }

  Future<void> listenEndStream() async {
    stompServices.subscribeStreamEnd(_streamModel!.id, (status) {
      emit(
        state.copyWith(status: PlayStreamStatus.end),
      );
    });
  }
}
