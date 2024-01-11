import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:natural_app/app/data/repositories/cart_repository.dart';
import 'package:natural_app/app/data/repositories/main_repository.dart';
import 'package:natural_app/app/presenter/cart/store/cart_store.dart';
import 'package:natural_app/app/data/repositories/home_repository.dart';
import 'package:natural_app/app/presenter/home/store/home_store.dart';
import 'package:natural_app/app/presenter/main/store/main_store.dart';

import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerFactory(() => Dio());

  getIt.registerFactory(
    () => MainRepository(
      prefs: getIt<SharedPreferences>(),
    ),
  );

  getIt.registerFactory<MainStore>(
    () => MainStore(
      repository: getIt<MainRepository>(),
    ),
  );

  getIt.registerFactory(
    () => HomeRespository(
      dio: getIt<Dio>(),
      prefs: getIt<SharedPreferences>(),
    ),
  );

  getIt.registerFactory(
    () => HomeStore(
      respository: getIt<HomeRespository>(),
    ),
  );

  getIt.registerFactory(
    () => CartRepository(dio: getIt<Dio>(), prefs: getIt<SharedPreferences>()),
  );

  getIt.registerFactory(
    () => CartStore(repository: getIt<CartRepository>()),
  );
}
