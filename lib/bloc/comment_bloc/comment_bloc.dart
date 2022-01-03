import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/comment_bloc/comment_state.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/key_constants.dart';
import 'package:live_tv/services/live_stream_services.dart';
import 'package:live_tv/services/stromp_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentBloc extends Cubit<CommentState> {
  final StompServices services = StompServices.instance;
  final StreamServices streamServices;

  int? _streamId;
  CommentBloc({required this.streamServices}) : super(CommentState.initial());
  Future<void> getComment(int id) async {
    _streamId = id;
    emit(
      state.copyWith(status: CommentStatus.loading),
    );
    final sharePref = await SharedPreferences.getInstance();
    final accessToken = sharePref.getString(KeyConstnants.accessToken);
    final stream = await streamServices.getLiveStream(
        Configuration.getBearerAuth(accessToken ?? ''), id);
    emit(
      state.copyWith(comments: stream.comments),
    );
    services.subscribeComment(
      id,
      (comment) {
        final comments = state.comments..add(comment);
        emit(
          state.copyWith(comments: comments, status: CommentStatus.success),
        );
      },
    );
  }

  Future<void> comment(String comment) async {
    if (_streamId != null) {
      final sharePref = await SharedPreferences.getInstance();
      final accessToken = sharePref.getString(KeyConstnants.accessToken);
      await streamServices.comment(
          Configuration.getBearerAuth(accessToken ?? ''),
          _streamId!,
          {'content': comment});
    }
  }
}
