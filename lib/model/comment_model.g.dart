// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
    id: json['id'] as int,
    createAt: json['createdAt'] as String,
    updateAt: json['updatedAt'] as String,
    content: json['content'] as String,
    user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createAt,
      'updatedAt': instance.updateAt,
      'content': instance.content,
      'user': instance.user,
    };
