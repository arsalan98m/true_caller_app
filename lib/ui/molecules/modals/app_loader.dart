import 'package:flutter/material.dart';

class AppLoader {
  AppLoader(BuildContext context) {
    showDialog<bool>(
        context: context,
        barrierDismissible: false,
        barrierColor: Color.fromRGBO(46, 46, 46, 0.8),
        useSafeArea: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
