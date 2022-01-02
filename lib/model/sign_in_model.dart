import 'package:json_annotation/json_annotation.dart';

part 'sign_in_model.g.dart';

@JsonSerializable()
class SignInModel {
  @JsonKey(name: 'username')
  final String userName;
  @JsonKey(name: 'password')
  final String password;

  SignInModel({required this.userName, required this.password});
  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignInModelToJson(this);
}
