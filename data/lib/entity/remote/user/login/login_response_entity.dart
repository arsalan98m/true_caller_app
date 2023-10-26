import 'package:data/entity/remote/user/login/login_content_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:domain/model/user/login_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../response_entity.dart';

part 'login_response_entity.g.dart';

@JsonSerializable()
class LoginResponseEntity
    implements BaseLayerDataTransformer<LoginResponseEntity, Login> {
  @JsonKey(name: "response")
  final LoginEntity loginEntity;

  LoginResponseEntity(this.loginEntity);

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseEntityToJson(this);

  @override
  LoginResponseEntity restore(Login data) {
    // TODO: implement restore
    throw UnimplementedError();
  }

  @override
  Login transform() {
    return loginEntity.transform();
  }
}
