import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products_app/utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String initScreen = prefs.getString('token') ?? "";

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
