import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:iot/app_config.dart';
import 'package:iot/localization/localizations.dart';
import 'package:iot/routes.dart';
import 'package:iot/shared/theme/color_provider.dart';
import 'package:iot/shared/theme/colors.dart';
import 'package:iot/shared/theme/styles.dart';
import 'package:iot/shared/utils/navigator_observer.dart';


class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final navigatorKey = GlobalKey<NavigatorState>();
  late final StreamSubscription _appExceptionSubscription;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.setLocale(context.read<AuthenticationCubit>().state.locale);
    // });
    // _appExceptionSubscription = GetIt.I<ErrorInterceptor>().listenError((value) {
    //   if (value.state == AppExceptionState.sessionExpired) {
    //     _safeProceed((context) {
    //       context.read<AuthenticationCubit>().logout().then(
    //             (_) => Navigator.of(context).pushNamedAndRemoveUntil(
    //               RouteName.splash,
    //               (route) => false,
    //               arguments: 1,
    //             ),
    //           );
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    _appExceptionSubscription.cancel();
    super.dispose();
  }

  void _safeProceed(Function(BuildContext) f) {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        f(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _colors = LightColorTheme();
    final _theme = AppTheme(_colors);
    final botToastBuilder = BotToastInit();
    return ColorThemeProvider(
      colors: _colors,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: GetIt.I<AppConfig>().appName,
        theme: _theme.lightTheme,
        darkTheme: _theme.lightTheme,
        builder: (context, child) {
          Intl.defaultLocale = context.appLocale.toStringWithSeparator;
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1)),
            child: botToastBuilder(context, child),
          );
        },
        supportedLocales: context.supportedLocales,
        locale: context.appLocale.locale,
        localizationsDelegates: context.localizationDelegates,
        initialRoute: RouteName.login,
        onGenerateRoute: onGenerateRoutes(),
        navigatorObservers: [
          BotToastNavigatorObserver(),
          AppNavigatorObserver(),
        ],
      ),
    );
  }
}
