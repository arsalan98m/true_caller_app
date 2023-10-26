import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/base_page.dart';
// #important - create modalprovider in di folder
import '../../di/app/app_modules.dart';
import 'overlay_model.dart';
import 'overlay_view.dart';

class OverlayPage extends BasePage<OverlayViewModel> {
  @override
  State<StatefulWidget> createState() => OverlayPageState();
}

class OverlayPageState extends BaseStatefulPage<OverlayViewModel, OverlayPage> {
  @override
  ProviderBase provideBase() {
    return overlayModelProvider;
  }

  @override
  Widget buildView(BuildContext context, OverlayViewModel model) {
    return OverlayView(provideBase());
  }
}
