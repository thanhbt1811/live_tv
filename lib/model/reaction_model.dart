import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:live_tv/model/user_model.dart';

part 'reaction_model.g.dart';

@JsonSerializable()
class ReactionModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'createdAt')
  final String createAt;
  @JsonKey(name: 'updatedAt')
  final String updateAt;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'user')
  final UserModel user;

  ReactionModel(
      {required this.id,
      required this.createAt,
      required this.updateAt,
      required this.type,
      required this.user});

  factory ReactionModel.fromJson(Map<String, dynamic> json) =>
      _$ReactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionModelToJson(this);

  @override
  List<Object?> get props => [id, createAt, updateAt, type, user];
}
