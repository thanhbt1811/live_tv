// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInModel _$SignInModelFromJson(Map<String, dynamic> json) {
  return SignInModel(
    userName: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$SignInModelToJson(SignInModel instance) =>
    <String, dynamic>{
      'username': instance.userName,
      'password': instance.password,
    };
