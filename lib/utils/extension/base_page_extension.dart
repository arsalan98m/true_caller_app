import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../base/base_page.dart';
import '../../ui/molecules/toasts/app_toast.dart';
// import 'package:top_snackbar_flutter/top_snack_bar.dart';

extension PageExtensions on BaseStatefulPage {
  showShortToast(String message) {
    AppToast.showToast(message, duration: Toast.LENGTH_SHORT);
  }

  showLongToast(String message) {
    AppToast.showToast(message, duration: Toast.LENGTH_LONG);
  }

  showTopError(String message) {
    AppToast.showToast(message, duration: Toast.LENGTH_SHORT);
  }
}
