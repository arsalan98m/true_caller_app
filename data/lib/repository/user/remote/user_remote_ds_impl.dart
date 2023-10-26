import 'package:retrofit/dio.dart';

import '../../../entity/local/base/device_helper.dart';
import '../../../entity/remote/user/login/login_request_entity.dart';
import '../../../entity/remote/user/login/login_response_entity.dart';
import '../../../network/api_service.dart';
import '../../../source/user_data_source.dart';
import '../user_repository_impl.dart';

class UserRemoteDSImpl extends UserRemoteDS {
  final ApiService _apiService;
  final DeviceInfoHelper _deviceInfoHelper;
  final UserLocalDS _userLocalDS;

  UserRemoteDSImpl(
    this._apiService,
    this._deviceInfoHelper,
    this._userLocalDS,
  );

  @override
  Future<HttpResponse<LoginResponseEntity>> login({
    required String userName,
    required String password,
  }) async {
    return _apiService.login(LoginRequestEntity(
      password: password,
      userName: userName,
    ));
  }
}
