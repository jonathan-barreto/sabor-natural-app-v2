import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:natural_app/src/features/cart/data/repository/cart_repository.dart';
import 'package:natural_app/src/features/cart/store/cart_store.dart';
import 'package:natural_app/src/features/home/data/repository/home_repository.dart';
import 'package:natural_app/src/features/home/store/home_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  getIt.registerFactory(() => Dio());

  getIt.registerFactory(
    () => HomeRespository(
      dio: getIt<Dio>(),
      prefs: getIt<SharedPreferences>(),
    ),
  );

  getIt.registerFactory(
    () => HomeStore(
      homeRespository: getIt<HomeRespository>(),
    ),
  );

  getIt.registerFactory(
    () => CartRepository(dio: getIt<Dio>(), prefs: getIt<SharedPreferences>()),
  );

  getIt.registerFactory(
    () => CartStore(cartRepository: getIt<CartRepository>()),
  );
}
