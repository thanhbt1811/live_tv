import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/reaction_bloc/reaction_state.dart';
import 'package:live_tv/common/config/configuration.dart';
import 'package:live_tv/common/constants/key_constants.dart';
import 'package:live_tv/model/reaction_model.dart';
import 'package:live_tv/services/live_stream_services.dart';
import 'package:live_tv/services/stromp_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReactionBloc extends Cubit<ReactionState> {
  final StreamServices _streamServices;
  final StompServices _stompServices = StompServices.instance;

  ReactionBloc(this._streamServices) : super(ReactionState.initial());

  int? _streamId;
  Future<void> reaction(String react) async {
    final sharePref = await SharedPreferences.getInstance();
    final accessToken = sharePref.getString(KeyConstnants.accessToken);
    _streamServices.reaction(Configuration.getBearerAuth(accessToken ?? ''),
        _streamId!, {'type': react});
  }

  Future<void> getReaction(int id) async {
    _streamId = id;
    emit(
      state.copyWith(status: ReactionStatus.loading),
    );
    _stompServices.subscribeReaction(
      id,
      (comment) {
        final reactions = state.reactions..add(comment);
        final Map<String, List<ReactionModel>> reactionMap = {};
        for (final reaction in reactions) {
          if (reactionMap[reaction.type] == null) {
            reactionMap[reaction.type] = [reaction];
          } else {
            reactionMap[reaction.type]!.add(reaction);
          }
        }

        emit(
          state.copyWith(
              reactions: reactions,
              reactionMap: reactionMap,
              status: ReactionStatus.success),
        );
      },
    );
  }
}
