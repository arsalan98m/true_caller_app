import 'package:data/entity/local/base/device_helper.dart';
import 'package:device_info/device_info.dart';
import 'package:riverpod/riverpod.dart';

import '../repository/user/local/user_local_ds_impl.dart';
import '../repository/user/user_repository_impl.dart';

var deviceInfoPluginProvider = Provider<DeviceInfoPlugin>(
  (ref) => DeviceInfoPlugin(),
);

var deviceInfoHelperProvider =
    Provider<DeviceInfoHelper>((ref) => DeviceInfoHelper());

var userLocalDSProvider = Provider<UserLocalDS>(
  (ref) => UserLocalDSImpl(),
);
