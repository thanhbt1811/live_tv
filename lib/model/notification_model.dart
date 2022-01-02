import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'createdAt')
  final String createAt;
  @JsonKey(name: 'updatedAt')
  final String updateAt;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'livestreamId')
  final int? liveStreamId;
  @JsonKey(name: 'triggeredUserId')
  final int? triggeredUserId;

  NotificationModel(
      {required this.id,
      required this.createAt,
      required this.updateAt,
      required this.content,
      required this.liveStreamId,
      required this.triggeredUserId});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props =>
      [id, createAt, updateAt, content, liveStreamId, triggeredUserId];
}
