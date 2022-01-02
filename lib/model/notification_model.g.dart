// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    id: json['id'] as int,
    createAt: json['createdAt'] as String,
    updateAt: json['updatedAt'] as String,
    content: json['content'] as String,
    liveStreamId: json['livestreamId'] as int?,
    triggeredUserId: json['triggeredUserId'] as int?,
  );
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createAt,
      'updatedAt': instance.updateAt,
      'content': instance.content,
      'livestreamId': instance.liveStreamId,
      'triggeredUserId': instance.triggeredUserId,
    };
