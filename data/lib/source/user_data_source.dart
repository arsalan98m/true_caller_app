import 'package:retrofit/dio.dart';

import '../entity/remote/user/login/login_response_entity.dart';

abstract class UserRemoteDS {
  Future<HttpResponse<LoginResponseEntity>> login({
    required String userName,
    required String password,
  });
}
