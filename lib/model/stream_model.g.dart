// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StreamModel _$StreamModelFromJson(Map<String, dynamic> json) {
  return StreamModel(
    id: json['id'] as int,
    createAt: json['createdAt'] as String,
    updateAt: json['updatedAt'] as String,
    streamKey: json['streamKey'] as String,
    dvrFile: json['dvrFile'] as String?,
    content: json['content'] as String?,
    comments: (json['comments'] as List<dynamic>?)
        ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    reactions: (json['reactions'] as List<dynamic>?)
        ?.map((e) => ReactionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    status: json['status'] as String?,
  );
}

Map<String, dynamic> _$StreamModelToJson(StreamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createAt,
      'updatedAt': instance.updateAt,
      'streamKey': instance.streamKey,
      'dvrFile': instance.dvrFile,
      'content': instance.content,
      'comments': instance.comments,
      'reactions': instance.reactions,
      'user': instance.user,
      'status': instance.status,
    };
