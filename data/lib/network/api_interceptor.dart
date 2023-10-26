import 'package:data/network/api_service.dart';
import 'package:data/network/network_properties.dart';
import 'package:dio/dio.dart';
import 'package:domain/repository/user/user_repository.dart';

import '../entity/local/base/device_helper.dart';
import '../entity/remote/base/base_class.dart';

class ApiInterceptor extends InterceptorsWrapper {
  final UserRepository _userRepository;
  final Dio _previousDio;
  late ApiService apiService;
  String authToken = "";
  final DeviceInfoHelper _deviceInfoHelper;

  late Set<String> verifiedURLs = {};
  Future<String>? secure = Future.value('');

  ApiInterceptor(
      this._userRepository, this._previousDio, this._deviceInfoHelper) {
    Dio newDio = Dio(_previousDio.options);

    newDio.interceptors.add(_previousDio.interceptors.first);
    apiService = ApiService(newDio, baseUrl: NetworkProperties.BASE_URL);
  }
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    BaseClassEntity _deviceData = await _deviceInfoHelper.getDeviceInfo();
    // options.headers.putIfAbsent("Authorization", () => "Bearer $authToken");
    // options.headers.putIfAbsent("CompanyId", () => "COGEABCD1234EFGH");
    // options.headers.putIfAbsent("IP", () => _deviceData.ip);
    // options.headers.putIfAbsent("deviceID", () => _deviceData.deviceID);
    // options.headers.putIfAbsent("latitude", () => _deviceData.latitude);
    // options.headers.putIfAbsent("longitude", () => _deviceData.longitude);
    // options.headers.putIfAbsent("Platform", () => _deviceData.deviceID);
    // options.headers.putIfAbsent("MobileModel", () => _deviceData.deviceID);
    // options.headers.putIfAbsent("AppVersion", () => _deviceData.appVersion);

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      if (response.data != null) {
        if (((response.data as Map<String, dynamic>)['response']?['token']
                    as String?)
                ?.isNotEmpty ??
            false) {
          authToken = (response.data as Map<String, dynamic>)['response']
                  ['token'] ??
              '';
          // print('response authToken -------------------->$authToken}');
        }
      }

      super.onResponse(response, handler);
    }
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) {
    if (error.response?.statusCode == 400) {
      if (error.response?.data != null) {
        if (((error.response?.data as Map<String, dynamic>)['response']['token']
                    as String?)
                ?.isNotEmpty ??
            false) {
          authToken = (error.response?.data as Map<String, dynamic>)['response']
                  ['token'] ??
              '';
          // print('Error response authToken -------------------->$authToken}');
        }

        // clearing token when account is locked
        if ((error.response?.data as Map<String, dynamic>)['response']
                ['content'] ==
            "err-accountlock") {
          authToken = "";
        }
      }

      super.onError(error, handler);
    } else {
      if (error.response?.statusCode == 401) {
        authToken = "";
      }

      throw error;
    }
  }
}
