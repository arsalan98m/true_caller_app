import 'package:data/di/local_module.dart';
import 'package:data/di/network_module.dart';
import 'package:riverpod/riverpod.dart';

import '../repository/user/user_repository_impl.dart';

/// inject [UserRepository] provider
var userRepoProvider = Provider<UserRepositoryImpl>(
  (ref) => UserRepositoryImpl(
    ref.read(userRemoteDSProvider),
    ref.read(userLocalDSProvider),
    ref.read(dioProvider),
    ref.read(deviceInfoHelperProvider),
  ),
);
