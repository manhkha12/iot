import 'package:flutter/material.dart';

abstract class ColorTheme {
  Color get primaryColor;

  Color textPrimary = const Color(0xff373737);

  Color textSecondary = const Color(0xff5B5B5B);

  Color textTerrary = const Color(0xff505050);

  MaterialColor get swatches;

  Color get primaryButton;

  Color textError = const Color(0xffEB5252);

  Color modelPurple = const Color(0xFF2608AB);

  Color inputBorder = const Color(0xffA6A6A6);

  Color focusedInputBorder = const Color(0xffFBB700);

  Color erroredInputBorder = const Color(0xffF64D4D);

  Color placeholderColor = const Color(0xffB2B0B0);

  Color placeholderColorDark = const Color(0xff8E8E8E);

  Color disabledInputBorder = const Color(0xffE0E0E0);

  Color cursor = const Color(0xffFBB700);

  Color disableIcon = const Color(0xff8D8D8D);

  Color easyColor = const Color(0xff46B150);

  Color mediumColor = const Color(0xffE4D01D);

  Color hardColor = const Color(0xffE4651D);

  Color ligthGrey = const Color(0xffF8F8F8);

  Color divider = const Color(0xffECECEC);

  Color dotIndicator = const Color(0xffE0DDDD);

  Color tagBorder = const Color(0xffECECEC);

  Color green400 = const Color(0xff00875A);

  Color onlineColor = const Color(0xff08BA26);

  Color textWhiteGrey = const Color(0xffD2D2D2);

  Color circleBarBackground = const Color(0xffE7E7E7);

  Color lightBorder = const Color(0xffEEEEEE);

  Color primaryBackground = const Color(0xffFEFEFE);

  Color activeSlider = const Color(0xffFBB700);

  Color inactiveSlider = const Color(0xffECECEC);

  Color neutralLight = const Color(0xffFAFBFC);

  Color lightPink = const Color(0xffFFE5F2);

  Color black = const Color(0xF0000000);

  Color dimGrey = const Color(0xffD9D9D9).withOpacity(0.2);
}

class LightColorTheme extends ColorTheme {
  @override
  Color get primaryColor => const Color(0xffFBB700);

  @override
  Color get primaryButton => const Color(0xffFBB700);

  @override
  MaterialColor get swatches => const MaterialColor(0xffFBB700, {
        50: Color(0xffFFF7DD),
        100: Color(0xffFFE9AA),
        200: Color(0xffFEDB71),
        300: Color(0xffFCCE33),
        400: Color(0xffFCC200),
        500: Color(0xffFBB700),
        600: Color(0xffFBA900),
        700: Color(0xffFC9500),
        800: Color(0xffFD8300),
        900: Color(0xffFE6000),
      });
}

class DarkColorTheme extends ColorTheme {
  @override
  Color get primaryColor => const Color(0xffFBB700);

  @override
  Color get primaryButton => const Color(0xffFBB700);

  @override
  MaterialColor get swatches => const MaterialColor(0xffFBB700, {
        50: Color(0xffFFF7DD),
        100: Color(0xffFFE9AA),
        200: Color(0xffFEDB71),
        300: Color(0xffFCCE33),
        400: Color(0xffFCC200),
        500: Color(0xffFBB700),
        600: Color(0xffFBA900),
        700: Color(0xffFC9500),
        800: Color(0xffFD8300),
        900: Color(0xffFE6000),
      });
}
