import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products_app/utils/font_size.dart';
import 'package:sizer/sizer.dart';

import '../../../base/base_page.dart';
import '../../generated/l10n.dart';
import 'home_model.dart';

class HomeView extends BasePageViewWidget<HomeViewModel> {
  HomeView(ProviderBase providerBase) : super(providerBase);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    model.delegate = S.of(context);

    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "HOME SCREEN",
            style: TextStyle(
              fontFamily: "Gotham",
              fontSize: AppFontSize.f20,
              fontWeight: FontWeight.w700,
            ),
          ),
          ElevatedButton(
            child: const Text("Foreground Mode"),
            onPressed: () {
              FlutterBackgroundService().invoke("setAsForeground");
            },
          ),
          ElevatedButton(
            child: const Text("Background Mode"),
            onPressed: () {
              FlutterBackgroundService().invoke("setAsBackground");
            },
          ),
          ElevatedButton(
            child: Text(model.text),
            onPressed: () async {
              final service = FlutterBackgroundService();
              var isRunning = await service.isRunning();
              if (isRunning) {
                service.invoke("stopService");
              } else {
                service.startService();
              }

              if (!isRunning) {
                model.text = 'Stop Service';
              } else {
                model.text = 'Start Service';
              }
            },
          ),
        ],
      ),
    );
  }
}
