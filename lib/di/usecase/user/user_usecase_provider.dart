import 'package:data/di/repository_module.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///[LoginUseCase] provider
final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
  (ref) => LoginUseCase(
    ref.read(userRepoProvider),
  ),
);
