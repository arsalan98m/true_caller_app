import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void ShowFullScreenModal(context, modalContainer) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false, // should dialog be dismissed when tapped outside
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,

    transitionDuration: Duration(
        milliseconds:
            100), // how long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      // your widget implementation
      return modalContainer;
    },
  );
}
