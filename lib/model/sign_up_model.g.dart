// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) {
  return SignUpModel(
    displayName: json['displayName'] as String,
    email: json['email'] as String,
    userName: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'username': instance.userName,
      'password': instance.password,
    };
