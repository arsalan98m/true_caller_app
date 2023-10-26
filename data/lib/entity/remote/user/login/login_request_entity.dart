import 'package:json_annotation/json_annotation.dart';

part "login_request_entity.g.dart";

@JsonSerializable()
class LoginRequestEntity {
  @JsonKey(name: "username")
  final String userName;
  @JsonKey(name: "password")
  final String password;

  LoginRequestEntity({
    required this.userName,
    required this.password,
  });

  factory LoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestEntityToJson(this);
}
