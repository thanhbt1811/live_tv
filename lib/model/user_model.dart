import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'createdAt')
  final String createAt;
  @JsonKey(name: 'updatedAt')
  final String updateAt;
  @JsonKey(name: 'displayName')
  final String displayName;
  @JsonKey(name: 'username')
  final String userName;
  @JsonKey(name: 'balance')
  final int balance;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'followed')
  final bool followed;

  UserModel(
      {required this.id,
      required this.createAt,
      required this.updateAt,
      required this.displayName,
      required this.userName,
      required this.balance,
      required this.email,
      required this.followed});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props =>
      [id, createAt, updateAt, displayName, userName, balance, email];
}
