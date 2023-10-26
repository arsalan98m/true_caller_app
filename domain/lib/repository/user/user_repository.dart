// *** Packages *** //
import 'package:dartz/dartz.dart';

// *** Error *** //
import 'package:domain/error/network_error.dart';

// *** Models *** //
import 'package:domain/model/user/login_model.dart';

abstract class UserRepository {
  /// login
  Future<Either<NetworkError, Login>> login({
    required String userName,
    required String password,
  });
}
