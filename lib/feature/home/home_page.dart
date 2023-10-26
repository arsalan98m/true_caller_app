import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/base_page.dart';
// #important - create modalprovider in di folder
import '../../di/app/app_modules.dart';
import 'home_model.dart';
import 'home_view.dart';

class HomePage extends BasePage<HomeViewModel> {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends BaseStatefulPage<HomeViewModel, HomePage> {
  @override
  ProviderBase provideBase() {
    return homeModelProvider;
  }

  @override
  Widget buildView(BuildContext context, HomeViewModel model) {
    return HomeView(provideBase());
  }
}
