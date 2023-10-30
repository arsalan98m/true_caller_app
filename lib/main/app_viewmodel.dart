import 'dart:async';

import 'package:flutter/material.dart';
import 'package:products_app/utils/font_size.dart';

import '../base/base_view_model.dart';
import '../utils/color_utils.dart';

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

  AppViewModel() {}

  @override
  void dispose() {
    super.dispose();
  }
}

enum AppTheme {
  dark,
  light,
}
