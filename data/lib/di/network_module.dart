import 'package:data/di/local_module.dart';
import 'package:data/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

import '../network/network_properties.dart';
import '../repository/user/remote/user_remote_ds_impl.dart';
import '../source/user_data_source.dart';
import '../di/local_module.dart';

final baseOptions = Provider<BaseOptions>(
    (ref) => BaseOptions(baseUrl: NetworkProperties.BASE_URL));

final prettyDioLoggerProvider = Provider<PrettyDioLogger>(
  (ref) => PrettyDioLogger(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
    logPrint: (log) {
      return debugPrint(log as String);
    },
  ),
);

final dioProvider = Provider<Dio>(
  (ref) {
    Dio dio = Dio(ref.read(baseOptions));
    dio.interceptors.add(
      ref.read(prettyDioLoggerProvider),
    );
    return dio;
  },
);

final apiServiceProvider = Provider<ApiService>(
  (ref) =>
      ApiService(ref.read(dioProvider), baseUrl: NetworkProperties.BASE_URL),
);

/// User remoteDS provider
final userRemoteDSProvider = Provider<UserRemoteDS>((ref) => UserRemoteDSImpl(
      ref.read(apiServiceProvider),
      ref.read(deviceInfoHelperProvider),
      ref.read(userLocalDSProvider),
    ));
