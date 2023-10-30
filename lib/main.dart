import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products_app/main/app_viewmodel.dart';
import 'package:products_app/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String initScreen = prefs.getString('token') ?? "";

  await initializeService();

  await Future.delayed(const Duration(milliseconds: 300));
  runApp(ProviderScope(child: MyApp(initScreen: initScreen)));
}

class MyApp extends StatelessWidget {
  String initScreen;
  MyApp({Key? key, this.initScreen = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Paint.enableDithering = true;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.cFEFEFE,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return App(initScreen: initScreen);
  }
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
    ),
  );

  await service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // Timer.periodic(Duration(seconds: 1), (timer) async {
  //   if (service is AndroidServiceInstance) {
  //     if (await service.isForegroundService()) {
  //       // if you don't using custom notification, uncomment this
  //       service.setForegroundNotificationInfo(
  //         title: "PURSHTTTAM WOOW",
  //         content: "Updated at ${DateTime.now()}",
  //       );
  //     }
  //   }
  // });
}
