import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/features/login/login_screen.dart';
import 'package:iot/features/homepage/splash_screen.dart';
import 'package:iot/features/main_screen.dart';
import 'package:iot/features/menu/menu_screen.dart';
import 'package:iot/shared/cubits/divides_cubit/divide_cubit.dart';
import 'package:iot/shared/cubits/login_cubit/login_cubit.dart';

class RouteName{
  static const String splash ='/';
  static const String login = '/login';
  static const String main='/main';
  static const String menu='/menu';
}

RouteFactory onGenerateRoutes(){
  return (RouteSettings settings) {

    if (settings.name == RouteName.main) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const MainScreen(),
      );
    }
    if (settings.name == RouteName.menu) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const MenuScreen(),
      );
    }


    if (settings.name == RouteName.splash) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => BlocProvider(create: (_)=>DeviceCubit(FirebaseDatabase.instance.ref()),
        child:   SplashScreen(),)
      );
    }

    if (settings.name == RouteName.login) {
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
                create: (context) => LoginCubit(isSignup: false,firebaseAuth:FirebaseAuth.instance ),
                child: const LoginScreen(),
              ));
    }

  return MaterialPageRoute(
      builder: (_) => Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Text('No route found: ${settings.name}'),
        ),
      ),
    );

};}