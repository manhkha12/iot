import 'package:iot/data/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

Future<void> registerRepositoryModules(GetIt getIt) async {
  getIt..registerLazySingleton<UserRepository>(() => UserRepository(getIt()));
}
