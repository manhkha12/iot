import 'package:iot/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'core.dart';
import 'di/di.dart' as di;
import 'localization/localizations.dart';
import 'shared/widgets/restart_widget.dart';

void main() {
  runZonedApp(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await FlutterConfig.loadEnvVariables();
      final configureApp = await getCurrentConfigs();
      await di.setupDI(configureApp);
      runApp(
        AppLocalization(
          initLocale: const AppLocale(locale: Locale('vi', 'VN')),
          supportedLocales: const [Locale('vi', 'VN'), Locale('en', 'US')],
          child: MultiBlocProvider(
            providers: di.globalProviders,
            child: const RestartWidget(),
          ),
        ),
      );
    },
  );
}
