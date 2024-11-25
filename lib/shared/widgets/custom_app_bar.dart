import 'package:iot/gen/assets.gen.dart';
import 'package:iot/shared/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color titleColor;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final List<Widget>? actions;
  final double elevation;
  final Color backgroundColor;

  const CustomAppBar({
    Key? key,
    this.title,
    this.titleColor = const Color(0xff333333),
    this.titleFontSize = 16,
    this.titleFontWeight = FontWeight.w500,
    this.actions,
    this.elevation = 0,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: true,
      leading: Navigator.of(context).canPop()
          ? IconButton(
              onPressed: () => Navigator.of(context).pop(),
              splashRadius: 24,
              icon: Center(
                child: Assets.icons.back.svg(colorFilter: titleColor.colorFilter, width: 18),
              ),
            )
          : null,
      title: title != null
          ? AppText(
              title!,
              color: titleColor,
              fontSize: titleFontSize,
              fontWeight: titleFontWeight,
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
