import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel {
  @JsonKey(name: 'statusCode')
  final int statusCode;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'details')
  final String details;

  ErrorModel(
      {required this.statusCode, required this.message, required this.details});

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}
