import 'package:dartz/dartz.dart';
import '../base/base_usecase.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import '../../model/user/login_model.dart';
import '../base/params.dart';
import '../../repository/user/user_repository.dart';

class LoginUseCase extends BaseUseCase<BaseError, LoginUseCaseParams, Login> {
  final UserRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<BaseError, Login>> execute({
    required LoginUseCaseParams params,
  }) async {
    return Future.value(
      (await _repository.login(
        userName: params.userName,
        password: params.password,
      )),
    );
  }
}

class LoginUseCaseParams extends Params {
  final String userName;
  final String password;

  LoginUseCaseParams({
    required this.userName,
    required this.password,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
