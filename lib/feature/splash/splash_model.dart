import 'dart:async';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:products_app/main/app_viewmodel.dart';

import '../../base/base_page_view_model.dart';
import '../../generated/l10n.dart';
import '../../main/navigation/route_paths.dart';

class SplashViewModel extends BasePageViewModel {
  late S delegate;

  startTimer() async {
    // var duration = Duration(seconds: Platform.isIOS ? 1 : 5);
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() async {
    appLevelKey.currentState
        ?.pushNamedAndRemoveUntil(RoutePaths.home, (route) => false);
  }

  bool backButtonHandler(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  SplashViewModel() {
    // back button interceptor
    BackButtonInterceptor.add(backButtonHandler);
  }
  @override
  void dispose() {
    super.dispose();
  }
}
