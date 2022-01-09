import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:live_tv/model/user_model.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'createdAt')
  final String createAt;
  @JsonKey(name: 'updatedAt')
  final String updateAt;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'user')
  final UserModel user;
  @JsonKey(name: 'stars')
  final int? stars;

  CommentModel(
      {required this.id,
      required this.createAt,
      required this.updateAt,
      required this.content,
      required this.user,
      required this.stars});
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  @override
  List<Object?> get props => [id, createAt, updateAt, content, user];
}
