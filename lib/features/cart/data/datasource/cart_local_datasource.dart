import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souq_app/features/cart/domain/entity/cart_item_entity.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize SharedPreferences in main.dart first!');
});

class CartLocalDataSource {
  static const String _cartKey = 'user_cart_items';
  final SharedPreferences _prefs;

  CartLocalDataSource(this._prefs);

  List<CartItemEntity> getSavedCart() {
    final rawList = _prefs.getStringList(_cartKey) ?? [];
    return rawList
        .map((item) => CartItemEntity.fromRawJson(item))
        .toList();
  }

  Future<bool> saveCart(List<CartItemEntity> items) async {
    final rawList = items.map((item) => item.toRawJson()).toList();
    return await _prefs.setStringList(_cartKey, rawList);
  }

  Future<bool> clearCart() async {
    return await _prefs.remove(_cartKey);
  }
}

final cartLocalDataSourceProvider = Provider<CartLocalDataSource>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return CartLocalDataSource(prefs);
});