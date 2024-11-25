import 'dart:async';

import 'package:flutter/material.dart';

class TouchEventObserver {
  factory TouchEventObserver() => _instance;
  static final TouchEventObserver _instance = TouchEventObserver._internal();
  TouchEventObserver._internal();

  final StreamController<Offset> _controller = StreamController.broadcast();

  StreamSubscription addListener(ValueChanged<Offset> touched) {
    return _controller.stream.listen((event) {
      touched(event);
    });
  }

  void touch(Offset offset) {
    _controller.add(offset);
  }
}
