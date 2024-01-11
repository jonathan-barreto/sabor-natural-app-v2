import 'package:shared_preferences/shared_preferences.dart';

class MainRepository {
  final SharedPreferences prefs;

  MainRepository({
    required this.prefs,
  });

  Future<int> getTotalProductsInCart() async {
    final List<String>? items = prefs.getStringList('products');

    print(items);

    final int quantity = items?.length ?? 0;

    return quantity;
  }
}
