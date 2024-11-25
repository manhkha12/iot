import 'package:iot/shared/cubits/app_cubit/app_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> registerCubitModules(GetIt getIt) async {
  // register cubit modules
  getIt.registerLazySingleton(() => AppCubit());
}
