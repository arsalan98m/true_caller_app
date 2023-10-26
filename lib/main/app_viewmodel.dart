import 'dart:async';
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products_app/providers/app_provider.dart';
import 'package:products_app/utils/font_size.dart';
import 'package:products_app/utils/helpers/shared_pref_helpers.dart';

import '../base/base_view_model.dart';
import '../utils/color_utils.dart';
import 'navigation/route_paths.dart';

GlobalKey<NavigatorState> appLevelKey = GlobalKey(debugLabel: 'app-key');

class AppViewModel extends BaseViewModel {
  // FIELDS
  AppTheme _appTheme = AppTheme.light;
  ThemeData _themeData = ThemeData();

  // GETTERS
  AppTheme get appTheme => _appTheme;

  ThemeData get themeData {
    if (_appTheme == AppTheme.dark) {}
    _themeData = _themeData.copyWith(
      primaryColor: AppColor.black,
      textTheme: _themeData.textTheme.apply(
        fontFamily: "Gotham",
        bodyColor: AppColor.c4E5357,
        displayColor: AppColor.black,
      ),
      primaryTextTheme: _themeData.textTheme.apply(
        fontFamily: "Gotham",
        bodyColor: AppColor.white,
        displayColor: AppColor.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isDense: true,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.c4E5357),
        ),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: 'Gotham',
        ),
        // errorStyle: TextStyle(
        //   fontFamily: "Gotham",
        // ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColor.c4E5357,
      ),
      scaffoldBackgroundColor: const Color(0xffF3F5F9),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: AppFontSize.f18,
          color: AppColor.c4E5357,
          fontFamily: "Gotham",
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: AppColor.transparent,
        elevation: 0,
      ),
    );

    return _themeData;
  }

  String? _appLocale;
  String get appLocale => _appLocale ?? "en";
  set appLocale(String value) {
    _appLocale = value;
    notifyListeners();
  }

  setLocale(locale) => appLocale = locale;

  AppViewModel() {
    // *** Initially when out app started then we are Getting preserved call logs *** //
    Future.delayed(const Duration(milliseconds: 100), () {
      getCallLogs();
    });
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      final appNotifier =
          ProviderScope.containerOf(appLevelKey.currentState!.context)
              .read(appNotifierProvider);

      final currentRouteName = RouteInfo()
          .currentRoute(appLevelKey.currentState!.context)!
          .settings
          .name;

      appNotifier.addCaller({
        "title": "Test User ${appNotifier.callLogsList.length + 1}",
        "subTitle": timer.tick % 2 == 0 ? "Incoming Call" : "Missed Call",
        "isIncomingCall": timer.tick % 2 == 0 ? true : false,
      });

      setCallLogs(callLogs: appNotifier.callLogsList);

      if (currentRouteName == "/home") {
        appLevelKey.currentState?.pushNamedAndRemoveUntil(
          RoutePaths.overlay,
          (route) => false,
        );
      }
    });
  }

  // Getting CallLogs from app local storage
  void getCallLogs() async {
    var _appNotifierProvider =
        ProviderScope.containerOf(appLevelKey.currentState!.context)
            .read(appNotifierProvider);

    final callLogs = await SharedPrefsHelpers.getStringValuesSF("callLogs");

    final data =
        callLogs.isNotEmpty ? List<dynamic>.from(json.decode(callLogs)) : [];

    _appNotifierProvider.callLogsList = data;

    startTimer();
  }

  // Inserting Updated CallLogs inside app local storage
  void setCallLogs({required List callLogs}) {
    SharedPrefsHelpers.setStringValuesSF("callLogs", json.encode(callLogs));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum AppTheme {
  dark,
  light,
}
