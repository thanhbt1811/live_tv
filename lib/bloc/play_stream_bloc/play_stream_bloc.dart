import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/play_stream_bloc/play_stream_state.dart';
import 'package:live_tv/services/live_stream_services.dart';
import 'package:live_tv/services/stromp_services.dart';

class PlayStreamBloc extends Cubit<PlayStreamState> {
  final StreamServices streamServices;
  final StompServices stompServices = StompServices.instance;
  int? _streamId;

  PlayStreamBloc({required this.streamServices})
      : super(PlayStreamState.initial());

  Future<void> initial(int id) async {
    _streamId = id;
    stompServices.subscribeViewCount(_streamId!, (viewCount) {
      emit(state.copyWith(viewCount: viewCount));
    });
  }

  Future<void> listenEndStream() async {
    stompServices.subscribeStreamEnd(_streamId!, (status) {
      emit(
        state.copyWith(status: PlayStreamStatus.end),
      );
    });
  }
}
