import 'package:dartz/dartz.dart';
import 'package:data/entity/local/base/device_helper.dart';
import 'package:dio/dio.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/user/login_model.dart';
import 'package:domain/repository/user/user_repository.dart';

import '../../network/api_interceptor.dart';
import '../../network/utils/safe_api_call.dart';
import '../../source/user_data_source.dart';

/// user repository management class
class UserRepositoryImpl extends UserRepository {
  final UserRemoteDS _remoteDS;
  final UserLocalDS _localDS;
  final Dio _dio;
  final DeviceInfoHelper _deviceInfoHelper;

  UserRepositoryImpl(
    this._remoteDS,
    this._localDS,
    this._dio,
    this._deviceInfoHelper,
  ) {
    _dio.interceptors.add(ApiInterceptor(this, _dio, this._deviceInfoHelper));
  }

  @override
  Future<Either<NetworkError, Login>> login(
      {required String userName, required String password}) async {
    final result = await safeApiCall(
      _remoteDS.login(userName: userName, password: password),
    );
    return result!.fold(
      (l) => Left(l),
      (r) => Right(r.data.transform()),
    );
  }
}

abstract class UserLocalDS {}
