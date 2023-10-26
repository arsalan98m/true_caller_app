import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNotifier extends ChangeNotifier {
  List _callLogsList = [];
  List get callLogsList => _callLogsList;
  set callLogsList(List value) {
    _callLogsList = value;
    notifyListeners(); // This notifies listeners and triggers a rebuild.
  }

  void addCaller(Map<String, dynamic> caller) {
    _callLogsList.add(caller);
    notifyListeners(); // This notifies listeners and triggers a rebuild.
  }
}

final appNotifierProvider =
    ChangeNotifierProvider<AppNotifier>((ref) => AppNotifier());
