import 'dart:async';

import 'package:flutter/foundation.dart';

void runZonedApp(Function() runApp) {
  runZonedGuarded(runApp, (e, st) {
    if (kDebugMode) {
      print(e);
      print(st);
    }
  });
}
