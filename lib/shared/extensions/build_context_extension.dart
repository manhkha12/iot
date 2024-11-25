import 'package:iot/shared/theme/color_provider.dart';
import 'package:iot/shared/theme/colors.dart';
import 'package:iot/shared/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  ColorTheme get colors => ColorThemeProvider.of(this).colors;

  void showLoadingDialog() => LoadingDialogManager.instance.showLoading(this);

  void hideLoadingDialog() => LoadingDialogManager.instance.hideLoading(this);
}
