import 'package:flutter/material.dart';

class AppCircleLoading extends StatelessWidget {
  final double strokeWidth;
  const AppCircleLoading({
    Key? key,
    this.strokeWidth = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: strokeWidth,
    );
  }
}
