import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNotifier extends ChangeNotifier {}

final appNotifierProvider =
    ChangeNotifierProvider<AppNotifier>((ref) => AppNotifier());
