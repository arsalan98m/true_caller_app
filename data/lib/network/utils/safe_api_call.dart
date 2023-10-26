import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:data/network/utils/get_error.dart';
import 'package:dio/dio.dart';
import 'package:domain/error/network_error.dart';
import 'package:retrofit/retrofit.dart';

Future<Either<NetworkError, T>?> safeApiCall<T>(Future<T> apiCall) async {
  try {
    final originalResponse = await apiCall;
    final eitherResponse = originalResponse as HttpResponse<dynamic>;
    if (!eitherResponse.isSuccessful()) {
      return Left(getError(apiResponse: eitherResponse.response));
    } else {
      return Right(originalResponse);
    }
  } on Exception catch (throwable) {
    switch (throwable.runtimeType) {
      case DioError:
        switch ((throwable as DioError).type) {
          case DioErrorType.connectTimeout:
            //"Connection timeout with API server";
            return Left(
              NetworkError(
                  message: "Connection timeout with API server",
                  httpError: 504,
                  cause: throwable),
            );
          case DioErrorType.sendTimeout:
            //"Receive timeout exception";
            return Left(
              NetworkError(
                  message: "Send timeout error in connection",
                  httpError: 504,
                  cause: throwable),
            );
          case DioErrorType.receiveTimeout:
            //"Receive timeout in connection with API server";
            return Left(
              NetworkError(
                  message: "Receive timeout. Please try again later.",
                  httpError: 504,
                  cause: throwable),
            );
          case DioErrorType.response:
            if (throwable is DioError) {
              return Left(getError(apiResponse: throwable.response));
            }
            break;
          //"Received invalid status code: ${error.response.statusCode}";
          case DioErrorType.cancel:
            //"Request to API server was cancelled"
            return Left(
              NetworkError(
                  message: "Request to API server was cancelled",
                  httpError: 505,
                  cause: throwable),
            );
          case DioErrorType.other:
            String msg = (throwable as DioError).message.toString();
            if (msg.contains("Network is unreachable") ||
                msg.contains("Software caused connection abort") ||
                msg.contains("Connection closed while receiving data")) {
              return Left(
                NetworkError(message: msg, httpError: 503, cause: throwable),
              );
            } else {
              return Left(
                NetworkError(
                    message: "Connection failed. Please try again later.",
                    httpError: 503,
                    cause: throwable),
              );
            }
        }

        break;

      case IOException:
        return Left(NetworkError(
            message: throwable.toString(), httpError: 502, cause: throwable));

      default:
        return Left(NetworkError(
            message: throwable.toString(), httpError: 502, cause: throwable));
    }
  }
}

extension RetrofitResponse on HttpResponse {
  ///
  /// Returns true if the code is in [200..300), which means the request was successfully received,
  /// understood, and accepted.
  ///
  bool isSuccessful() {
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }
}
