// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReactionModel _$ReactionModelFromJson(Map<String, dynamic> json) {
  return ReactionModel(
    id: json['id'] as int,
    createAt: json['createdAt'] as String,
    updateAt: json['updatedAt'] as String,
    type: json['type'] as String,
    user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReactionModelToJson(ReactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createAt,
      'updatedAt': instance.updateAt,
      'type': instance.type,
      'user': instance.user,
    };
