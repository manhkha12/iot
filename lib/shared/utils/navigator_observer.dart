import 'package:flutter/material.dart';

class AppNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>?> _history = <Route<dynamic>?>[];
  List<Route<dynamic>> get history => List.from(_history);

  Route<dynamic>? get top => _history.isNotEmpty ? _history.last : null;

  factory AppNavigatorObserver() => _singleton;
  static final AppNavigatorObserver _singleton = AppNavigatorObserver._internal();
  AppNavigatorObserver._internal();

  @override
  void didPop(Route route, Route? previousRoute) {
    _history.removeLast();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _history.add(route);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _history.remove(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final oldRouteIndex = _history.indexOf(oldRoute);
    _history.replaceRange(oldRouteIndex, oldRouteIndex + 1, [newRoute]);
  }
}
