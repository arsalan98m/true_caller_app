import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:products_app/main/app_viewmodel.dart';
import 'package:products_app/ui/molecules/modals/main_modal.dart';
import 'package:products_app/ui/molecules/modals/overlay_modal.dart';

import '../../base/base_page_view_model.dart';
import '../../generated/l10n.dart';
import '../../utils/helpers/shared_pref_helpers.dart';

class HomeViewModel extends BasePageViewModel {
  late S delegate;

  bool isModalShown = false;

  List<Map<String, dynamic>> _callLogsList = [];
  List<Map<String, dynamic>> get callLogsList => _callLogsList;
  set callLogsList(List<Map<String, dynamic>> value) {
    _callLogsList = value;
    notifyListeners(); // This notifies listeners and triggers a rebuild.
  }

  void addSingleLog(Map<String, dynamic> caller) {
    _callLogsList.add(caller);
    notifyListeners(); // This notifies listeners and triggers a rebuild.
  }

  final ScrollController scrollController = ScrollController();

  String _text = "Stop Service";
  String get text => _text;
  set text(String value) {
    _text = value;
    notify();
  }

  HomeViewModel() {
    getCallLogs();

    Timer.periodic(const Duration(seconds: 9), (timer) async {
      final isRunning = await FlutterBackgroundService().isRunning();
      if (isRunning && !isModalShown) {
        // The background service is running
        ShowFullScreenModal(appLevelKey.currentState!.context, overlayModal());
        isModalShown = true;
      }

      addSingleLog({
        "title": "Test User ${callLogsList.length + 1}",
        "subTitle": timer.tick % 2 == 0 ? "Incoming Call" : "Missed Call",
        "isIncomingCall": timer.tick % 2 == 0 ? true : false,
      });

      setCallLogs(callLogs: callLogsList);

      SchedulerBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      });
    });
  }

  // Getting CallLogs from app local storage
  void getCallLogs() async {
    final json = await SharedPrefsHelpers.getStringValuesSF("callLogs");

    List<Map<String, dynamic>> data = json.isNotEmpty
        ? List<Map<String, dynamic>>.from(jsonDecode(json))
        : [];

    _callLogsList = data;
  }

  // Inserting Updated CallLogs inside app local storage
  void setCallLogs({required List<Map<String, dynamic>> callLogs}) {
    SharedPrefsHelpers.setStringValuesSF("callLogs", jsonEncode(callLogs));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
