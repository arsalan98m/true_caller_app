import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../feature/home/home_model.dart';
import '../../feature/overlay/overlay_model.dart';
import '../../feature/splash/splash_model.dart';
import '../../main/app_viewmodel.dart';

final appViewModel = ChangeNotifierProvider.autoDispose<AppViewModel>(
  (ref) => AppViewModel(),
);

final splashModelProvider = ChangeNotifierProvider.autoDispose<SplashViewModel>(
  (ref) => SplashViewModel(),
);

final homeModelProvider = ChangeNotifierProvider.autoDispose<HomeViewModel>(
  (ref) => HomeViewModel(),
);

final overlayModelProvider =
    ChangeNotifierProvider.autoDispose<OverlayViewModel>(
  (ref) => OverlayViewModel(),
);
