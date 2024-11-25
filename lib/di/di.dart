import 'package:iot/app_config.dart';
import 'package:iot/shared/cubits/app_cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'cubit_modules.dart';
import 'local_modules.dart';
import 'remote_modules.dart';
import 'repository_modules.dart';

Future<void> setupDI(AppConfig config) async {
  final getIt = GetIt.I;
  getIt.registerLazySingleton<AppConfig>(() => config);
  await registerLocalModules(getIt);
  await registerRemoteModules(getIt);
  await registerRepositoryModules(getIt);
  await registerCubitModules(getIt);
}

dynamic get globalProviders => [
      BlocProvider(create: (_) => GetIt.I<AppCubit>()),
    ]; // Define all global provider
