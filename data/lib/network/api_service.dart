import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import '../entity/remote/user/login/login_request_entity.dart';
import '../entity/remote/user/login/login_response_entity.dart';
part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @POST("/auth/login")
  Future<HttpResponse<LoginResponseEntity>> login(
      @Body() LoginRequestEntity loginUserRequestEntity);
}
