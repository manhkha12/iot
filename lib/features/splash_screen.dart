import 'package:flutter/material.dart';

import 'package:iot/shared/widgets/app_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: 
      AppText("hello")
    );
  }
}