import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products_app/utils/font_size.dart';
import 'package:sizer/sizer.dart';

import '../../../base/base_page.dart';
import '../../generated/l10n.dart';
import 'splash_model.dart';

class SplashPageView extends BasePageViewWidget<SplashViewModel> {
  SplashPageView(ProviderBase providerBase) : super(providerBase);

  @override
  Widget build(BuildContext context, SplashViewModel model) {
    model.delegate = S.of(context);

    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SPLASH SCREEN",
            style: TextStyle(fontSize: AppFontSize.f32),
          )
        ],
      ),
    );
  }
}
