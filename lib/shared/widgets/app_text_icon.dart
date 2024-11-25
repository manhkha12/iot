import 'package:iot/gen/fonts.gen.dart';
import 'package:iot/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTextIcon extends StatelessWidget {
  final String text;
  final String icon;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDirection? textDirection;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? lineHeight;
  final FontStyle? fontStyle;
  final bool isReverse;
  final double iconSize;
  final Color? iconColor;
  final double spacing;

  const AppTextIcon(
    this.text, {
    super.key,
    required this.icon,
    this.style,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textDecoration,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.textDirection,
    this.lineHeight,
    this.fontStyle,
    this.isReverse = false,
    this.iconSize = 12,
    this.iconColor,
    this.spacing = 4,
  })  : assert(color == null || style == null, 'Can\'t provide both color and style\n'),
        assert(fontStyle == null || style == null, 'Can\'t provide both fontStyle and style\n'),
        assert(fontFamily == null || style == null, 'Can\'t provide both fontFamily and style\n'),
        assert(fontSize == null || style == null, 'Can\'t provide both fontSize and style\n'),
        assert(textDecoration == null || style == null,
            'Can\'t provide both textDecoration and style\n'),
        assert(fontWeight == null || style == null, 'Can\'t provide both fontWeight and style\n');

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(
      fontSize: 14,
      fontFamily: FontFamily.notoSans,
      color: context.colors.textPrimary,
      fontWeight: FontWeight.w400,
    );
    if (style != null) {
      _textStyle = _textStyle.merge(style);
    } else {
      _textStyle = _textStyle.copyWith(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        decoration: textDecoration,
        fontWeight: fontWeight,
        height: lineHeight,
        fontStyle: fontStyle,
      );
    }
    return Row(
      textDirection: isReverse ? TextDirection.rtl : TextDirection.ltr,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          width: iconSize,
          height: iconSize,
          colorFilter: iconColor?.colorFilter,
        ),
        SizedBox(width: spacing),
        Flexible(
          child: Text(
            text,
            style: _textStyle,
            maxLines: maxLines,
            textAlign: textAlign,
            overflow: overflow,
            textDirection: textDirection,
          ),
        ),
      ],
    );
  }
}
