// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestEntity _$LoginRequestEntityFromJson(Map<String, dynamic> json) {
  return LoginRequestEntity(
    userName: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$LoginRequestEntityToJson(LoginRequestEntity instance) =>
    <String, dynamic>{
      'username': instance.userName,
      'password': instance.password,
    };
