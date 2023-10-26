import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/base_page.dart';
// #important - create modalprovider in di folder
import '../../di/app/app_modules.dart';
import 'splash_model.dart';
import 'splash_view.dart';

class SplashPage extends BasePage<SplashViewModel> {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends BaseStatefulPage<SplashViewModel, SplashPage> {
  @override
  ProviderBase provideBase() {
    return splashModelProvider;
  }

  @override
  void onModelReady(SplashViewModel model) {
    model.startTimer();
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, SplashViewModel model) {
    return SplashPageView(provideBase());
  }
}
