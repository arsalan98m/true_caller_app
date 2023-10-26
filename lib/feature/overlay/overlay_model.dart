import 'package:back_button_interceptor/back_button_interceptor.dart';

import '../../base/base_page_view_model.dart';
import '../../generated/l10n.dart';
import '../../main/app_viewmodel.dart';
import '../../main/navigation/route_paths.dart';

class OverlayViewModel extends BasePageViewModel {
  late S delegate;

  OverlayViewModel() {
    // device back button interceptor
    BackButtonInterceptor.add(deviceBackButtonHandler);
  }

  bool deviceBackButtonHandler(bool stopDefaultButtonEvent, RouteInfo info) {
    final context = appLevelKey.currentContext;

    if ([
      RoutePaths.overlay
    ].contains(BackButtonInterceptor.getCurrentNavigatorRouteName(context!))) {
      backPressHandler();
      return true;
    }
    return false;
  }

  void backPressHandler() {
    appLevelKey.currentState
        ?.pushNamedAndRemoveUntil(RoutePaths.home, (route) => false);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(deviceBackButtonHandler);

    super.dispose();
  }
}
