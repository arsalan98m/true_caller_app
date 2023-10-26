import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../base/base_widget.dart';
import '../di/app/app_modules.dart';
import '../generated/l10n.dart';
import 'app_viewmodel.dart';
import 'navigation/app_router.dart';
import 'navigation/route_paths.dart';

class App extends ConsumerWidget {
  late AppViewModel _appViewModel;
  String initScreen;

  App({Key? key, this.initScreen = ''}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseWidget<AppViewModel>(
      providerBase: appViewModel,
      onModelReady: (model) {
        _appViewModel = ref.watch(appViewModel);

        // splash screen remove
        // FlutterNativeSplash.remove();
      },
      builder: (context, model, child) {
        return Sizer(
          builder: (context, orientation, deviceType) {
            return MaterialApp(
              theme: _appViewModel.themeData,
              // Navigation Key
              navigatorKey: appLevelKey,
              // Responsiveness
              // builder: (context, widget) => ResponsiveWrapper.builder(
              //   ClampingScrollWrapper.builder(context, widget!),
              //   maxWidth: 1200,
              //   minWidth: 360,
              //   defaultScale: true,
              //   breakpoints: [
              //     ResponsiveBreakpoint.resize(360, name: MOBILE),
              //     ResponsiveBreakpoint.autoScale(800, name: TABLET),
              //     ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              //     ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              //     ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              //   ],
              // ),
              // Route Settings
              initialRoute: RoutePaths.splash,
              // initialRoute: Platform.isAndroid
              //     ? RoutePaths.splash
              //     : (initScreen.isNotEmpty
              //         ? RoutePaths.authMain
              //         : RoutePaths.walkthrough),
              onGenerateRoute: AppRouter.generateRoute,
              // Localization settings
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: Locale(model!.appLocale),
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ar', 'SA'),
              ],
              onGenerateTitle: (context) => S.of(context).appName,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },
            );
          },
        );
      },
    );
  }
}
