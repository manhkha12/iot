import 'package:flutter/material.dart';
import 'package:iot/features/homepage/splash_screen.dart';
import 'package:iot/features/menu/menu_screen.dart';
import 'package:iot/gen/assets.gen.dart';
import 'package:iot/shared/extensions/build_context_extension.dart';
import 'package:iot/shared/widgets/bottom_navigation/custom_bottom_navigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bottomNavKey = GlobalKey<BottomNavigationState>();
  @override
  Widget build(BuildContext context) {
    return BottomNavigation(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ]),
      items: [
        BottomNavigationItem(
            icon: Assets.icons.home.path, page: const SplashScreen()),
     
        BottomNavigationItem(
            icon: Assets.icons.menu.path, page: const MenuScreen()),
      ],
      activeColor: context.colors.primaryColor,
    );
  }
}
