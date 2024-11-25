import 'package:iot/application.dart';
import 'package:flutter/material.dart';

class RestartWidget extends StatefulWidget {
  const RestartWidget({Key? key}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findRootAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: const Application(),
    );
  }
}
