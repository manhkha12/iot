import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/features/login/login_screen.dart';
import 'package:iot/features/splash_screen.dart';
import 'package:iot/shared/cubits/login_cubit/login_cubit.dart';

class RouteName{
  static const String splash ='/';
  static const String login = '/login';
}

RouteFactory onGenerateRoutes(){
  return (RouteSettings settings) {
    if (settings.name == RouteName.splash) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const SplashScreen(),
      );
    }

    if (settings.name == RouteName.login) {
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
                create: (context) => LoginCubit(isSignup: false),
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