import 'package:equatable/equatable.dart';
import 'package:live_tv/model/reaction_model.dart';

enum ReactionStatus { initial, loading, success, failed }

class ReactionState extends Equatable {
  final ReactionStatus status;
  final List<ReactionModel> reactions;
  final Map<String, List<ReactionModel>> reactionMap;
  final DateTime updateAt;

  ReactionState(
      {required this.status,
      required this.reactions,
      required this.updateAt,
      required this.reactionMap});

  factory ReactionState.initial() => ReactionState(
        status: ReactionStatus.initial,
        reactions: [],
        reactionMap: {},
        updateAt: DateTime.now(),
      );

  ReactionState copyWith({
    ReactionStatus? status,
    List<ReactionModel>? reactions,
    Map<String, List<ReactionModel>>? reactionMap,
  }) =>
      ReactionState(
        status: status ?? this.status,
        reactions: reactions ?? this.reactions,
        reactionMap: reactionMap ?? this.reactionMap,
        updateAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [
        status,
        reactions,
        reactionMap,
        updateAt,
      ];
}
