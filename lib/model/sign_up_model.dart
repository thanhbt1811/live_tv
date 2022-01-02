import 'package:json_annotation/json_annotation.dart';

part 'sign_up_model.g.dart';

@JsonSerializable()
class SignUpModel {
  @JsonKey(name: 'displayName')
  final String displayName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'username')
  final String userName;
  @JsonKey(name: 'password')
  final String password;

  SignUpModel(
      {required this.displayName,
      required this.email,
      required this.userName,
      required this.password});
  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}
