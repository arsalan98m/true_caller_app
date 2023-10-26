import 'package:domain/model/user/login_model.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "login_content_entity.g.dart";

@JsonSerializable()
class LoginEntity implements BaseLayerDataTransformer<LoginEntity, Login> {
  @JsonKey(name: "token")
  final String? token;

  LoginEntity({
    this.token,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);

  @override
  LoginEntity restore(Login response) {
    return LoginEntity();
  }

  @override
  Login transform() {
    return Login(
      token: token ?? "",
    );
  }
}
