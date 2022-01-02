// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as int,
    createAt: json['createdAt'] as String,
    updateAt: json['updatedAt'] as String,
    displayName: json['displayName'] as String,
    userName: json['username'] as String,
    balance: json['balance'] as int,
    email: json['email'] as String,
    followed: json['followed'] as bool,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createAt,
      'updatedAt': instance.updateAt,
      'displayName': instance.displayName,
      'username': instance.userName,
      'balance': instance.balance,
      'email': instance.email,
      'followed': instance.followed,
    };
