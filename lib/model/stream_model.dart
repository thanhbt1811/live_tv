import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:live_tv/model/comment_model.dart';
import 'package:live_tv/model/reaction_model.dart';
import 'package:live_tv/model/user_model.dart';

part 'stream_model.g.dart';

@JsonSerializable()
class StreamModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'createdAt')
  final String createAt;
  @JsonKey(name: 'updatedAt')
  final String updateAt;
  @JsonKey(name: 'dvrFile')
  final String? dvrFile;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'comments')
  final List<CommentModel>? comments;
  @JsonKey(name: 'reactions')
  final List<ReactionModel>? reactions;
  @JsonKey(name: 'user')
  final UserModel user;
  @JsonKey(name: 'status')
  final String? status;
  StreamModel(
      {required this.id,
      required this.createAt,
      required this.updateAt,
      required this.dvrFile,
      required this.content,
      required this.comments,
      required this.reactions,
      required this.user,
      required this.status});
  factory StreamModel.fromJson(Map<String, dynamic> json) =>
      _$StreamModelFromJson(json);
  Map<String, dynamic> toJson() => _$StreamModelToJson(this);

  @override
  List<Object?> get props =>
      [id, createAt, updateAt, dvrFile, content, comments, reactions, user];
}
