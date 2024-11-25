import 'package:iot/gen/fonts.gen.dart';
import 'package:iot/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppRadius {
  static const double inputRadius = 6;
}

class AppSize {
  static const double buttonHeight = 48;
  static const double inputHeight = 44;
  static const double tagItemHeight = 32;
}

class AppTheme {
  final ColorTheme colors;

  AppTheme(this.colors);

  InputDecorationTheme get lightInputDecorationTheme => InputDecorationTheme(
        contentPadding: const EdgeInsets.all(12),
        errorStyle: TextStyle(
          fontFamily: FontFamily.notoSans,
          color: colors.textError,
          fontSize: 12,
        ),
        hintStyle: TextStyle(
          fontFamily: FontFamily.notoSans,
          color: colors.placeholderColor,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.inputBorder,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.inputBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.focusedInputBorder,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.focusedInputBorder,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.erroredInputBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.inputBorder,
          ),
        ),
      );

  InputDecorationTheme get darkInputDecorationTheme => InputDecorationTheme(
        contentPadding: const EdgeInsets.all(12),
        errorStyle: TextStyle(
          color: colors.textError,
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.inputBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.inputBorder,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.inputBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.focusedInputBorder,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.focusedInputBorder,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.inputRadius),
          borderSide: BorderSide(
            color: colors.erroredInputBorder,
          ),
        ),
      );

  ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      primaryColor: colors.primaryColor,
      primarySwatch: colors.swatches,
      brightness: Brightness.light,
      fontFamily: FontFamily.notoSans,
      useMaterial3: false,
      inputDecorationTheme: lightInputDecorationTheme,
      sliderTheme: SliderThemeData(
        trackHeight: 2,
        activeTrackColor: colors.activeSlider,
        activeTickMarkColor: colors.activeSlider,
        inactiveTrackColor: colors.inactiveSlider,
        inactiveTickMarkColor: colors.inactiveSlider,
        thumbColor: colors.inactiveSlider,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 15),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      primaryColor: colors.primaryColor,
      primarySwatch: colors.swatches,
      useMaterial3: false,
      brightness: Brightness.light,
      fontFamily: FontFamily.notoSans,
      inputDecorationTheme: darkInputDecorationTheme,
      sliderTheme: SliderThemeData(
        trackHeight: 2,
        activeTrackColor: colors.activeSlider,
        activeTickMarkColor: colors.activeSlider,
        inactiveTrackColor: colors.inactiveSlider,
        inactiveTickMarkColor: colors.inactiveSlider,
        thumbColor: colors.inactiveSlider,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 15),
      ),
    );
  }
}
