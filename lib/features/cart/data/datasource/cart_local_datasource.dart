import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souq_app/features/cart/data/models/cart_model.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize sharedPreferencesProvider in main.dart via overrides');
});

final cartLocalDataSourceProvider = Provider<CartLocalDataSource>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return CartLocalDataSourceImpl(prefs);
});

abstract class CartLocalDataSource {
  List<CartItemModel> getSavedCart();
  Future<bool> saveCart(List<CartItemModel> items);
  Future<bool> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  static const _cartKey = 'saved_cart_items';
  final SharedPreferences prefs;

  CartLocalDataSourceImpl(this.prefs);

  @override
  List<CartItemModel> getSavedCart() {
    final jsonList = prefs.getStringList(_cartKey);
    if (jsonList == null || jsonList.isEmpty) return [];

    try {
      return jsonList
          .map((itemStr) => CartItemModel.fromRawJson(itemStr))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> saveCart(List<CartItemModel> items) async {
    final jsonList = items.map((item) => item.toRawJson()).toList();
    return await prefs.setStringList(_cartKey, jsonList);
  }

  @override
  Future<bool> clearCart() async {
    return await prefs.remove(_cartKey);
  }
}