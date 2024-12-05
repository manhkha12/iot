import 'package:iot/gen/assets.gen.dart';
import 'package:iot/shared/extensions/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'bottom_navigation_controller.dart';

/// Bottom Navigation Item
class BottomNavigationItem {
  final String icon;
  final Widget page;
  final Widget? badge;

  /// [label] : bottom tab's label
  /// [icon] : bottom tab's icon
  /// [page] : displaying page when item is focused
  /// [badge] : displaying badge count above of icon
  BottomNavigationItem({
    required this.icon,
    required this.page,
    this.badge,
  });
}

/// Bottom Navigation with list of tab items and page for each
class BottomNavigation extends StatefulWidget {
  final List<BottomNavigationItem> items;
  final Color activeColor;
  final Color inActiveColor;
  final Color backgroundColor;
  final Color indicatorColor;
  final double indicatorHeight;
  final int initIndex;
  final BoxDecoration? decoration;
  final double iconSize;
  final EdgeInsets labelPadding;
  final EdgeInsets iconPadding;
  final Function(int index)? onTabChanged;

  /// [items] : pages and bottom tab for each
  /// [activeColor] : color of label and icon when tab is focused
  /// [inActiveColor] : color of label and icon when tab is unfocused
  /// [backgroundColor] : background color of bottom navigation
  /// [indicatorColor] : color of indicator that display in top of each tab.
  /// Pass transparent color and [indicatorHeight] = 0 if want to hide indicator
  /// [indicatorHeight] : height of indicator that display in top of each tab
  /// [initIndex] : initial index of tab, default is first tab
  /// [decoration] : BoxDecoration for bottom tab
  /// [iconSize] : size of tab's icon
  /// [iconPadding] : padding of tab's icon
  /// [labelPadding] : padding of tab's label
  /// [onTabChanged] : callback one tab changed, and return new focused tab [index]
  const BottomNavigation({
    Key? key,
    required this.items,
    required this.activeColor,
    this.inActiveColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.initIndex = 0,
    this.decoration,
    this.iconSize = 24,
    this.labelPadding = EdgeInsets.zero,
    this.iconPadding = EdgeInsets.zero,
    this.indicatorColor = Colors.transparent,
    this.indicatorHeight = 0,
    this.onTabChanged,
  }) : super(key: key);

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late final BottomNavigationController _controller;

  @override
  void initState() {
    _controller = BottomNavigationController(initialIndex: widget.initIndex);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeToTab(int index) {
    _controller.changeIndex(index);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    final items = widget.items;
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: BottomNavigationProvider(
        IndexedStack(
          index: selectedIndex,
          children: items.map((item) => item.page).toList(),
        ),
        controller: _controller,
      ),
      bottomNavigationBar: Container(
        height: 60 + bottom,
        padding: EdgeInsets.only(bottom: bottom),
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
        ),
        decoration: (widget.decoration ?? const BoxDecoration()),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                _TabIcon(
                  icon: items[0].icon,
                  activeColor: widget.activeColor,
                  inActiveColor: widget.inActiveColor,
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    changeToTab(0);
                  },
                ),
                const SizedBox(width: 60),
                _TabIcon(
                  icon: items[1].icon,
                  activeColor: widget.activeColor,
                  inActiveColor: widget.inActiveColor,
                  isSelected: selectedIndex == 1,
                  onTap: () {
                    changeToTab(1);
                  },
                ),
                
                
              ],
            ),
            Positioned(
              top: -16,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xffFBB700),
                        const Color(0xffDDA100).withOpacity(0.5),
                        const Color(0xffFBB700)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Assets.icons.plus.svg(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabIcon extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final Color activeColor;
  final Color inActiveColor;
  final VoidCallback onTap;

  const _TabIcon({
    Key? key,
    required this.icon,
    this.isSelected = false,
    required this.activeColor,
    required this.inActiveColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 30,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(4),
                ),
                color: isSelected ? activeColor : Colors.transparent,
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(
                    icon,
                    width: 20,
                    height: 20,
                    colorFilter: isSelected ? activeColor.colorFilter : inActiveColor.colorFilter,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

mixin BottomNavigationMixin<Page extends StatefulWidget> on State<Page> {
  BottomNavigationController? _controller;
  bool isFocused = false;

  @protected
  int get tabIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = BottomNavigationProvider.of(context)?.controller;
      _controller?.addListener(onChangedTab);
    });
  }

  @override
  void dispose() {
    _controller?.removeListener(onChangedTab);
    super.dispose();
  }

  void onChangedTab() {
    isFocused = tabIndex == _controller?.index;
  }
}
