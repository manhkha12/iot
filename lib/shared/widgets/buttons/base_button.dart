// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:iot/gen/fonts.gen.dart';
import 'package:iot/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final Color? primaryColor;
  final AlignmentGeometry alignment;
  final BorderRadiusGeometry? radius;
  final BorderSide? borderSide;
  final bool isOutlined;
  final double disableOpacity;
  final bool isExpaned;
  final double elevation;
  final Color? backgroundColor;

  const BaseButton({
    Key? key,
    required this.child,
    this.width = double.infinity,
    required this.height,
    this.onPressed,
    this.textStyle,
    this.primaryColor,
    this.alignment = Alignment.center,
    this.radius,
    this.isOutlined = false,
    this.borderSide,
    this.disableOpacity = 0.6,
    this.isExpaned = true,
    this.elevation = 0,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _primaryColor = primaryColor ?? context.colors.primaryButton;
    final _disabledColor = _primaryColor.withOpacity(disableOpacity);
    final _size = Size(width, height);
    final _elevation = MaterialStateProperty.all(elevation);
    final _shape = MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: radius ?? BorderRadius.circular(25),
      ),
    );
    final _textStyle = MaterialStateProperty.all(const TextStyle(
      fontFamily: FontFamily.notoSans,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ).merge(textStyle));
    return isOutlined
        ? OutlinedButton(
            style: (isExpaned
                    ? OutlinedButton.styleFrom(minimumSize: _size)
                    : OutlinedButton.styleFrom(fixedSize: _size))
                .copyWith(
              alignment: alignment,
              elevation: _elevation,
              side: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return borderSide ?? BorderSide(width: 1, color: _disabledColor);
                }
                return borderSide ?? BorderSide(width: 1, color: _primaryColor);
              }),
              shape: _shape,
              textStyle: _textStyle,
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return _primaryColor.withOpacity(disableOpacity);
                }
                return _primaryColor;
              }),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                return backgroundColor;
              }),
              splashFactory: InkRipple.splashFactory,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: onPressed,
            child: child,
          )
        : ElevatedButton(
            style: (isExpaned
                    ? ElevatedButton.styleFrom(minimumSize: _size)
                    : ElevatedButton.styleFrom(fixedSize: _size))
                .copyWith(
              alignment: alignment,
              elevation: _elevation,
              shape: _shape,
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return (textStyle?.color ?? Colors.white).withOpacity(disableOpacity);
                }
                return textStyle?.color ?? Colors.white;
              }),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              textStyle: _textStyle,
              splashFactory: InkRipple.splashFactory,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return _disabledColor;
                }
                return _primaryColor;
              }),
            ),
            onPressed: onPressed,
            child: child,
          );
  }
}
