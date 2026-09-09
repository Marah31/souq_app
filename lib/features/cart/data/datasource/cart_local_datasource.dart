import 'package:flutter/foundation.dart';
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
    try {
      final rawList = _prefs.getStringList(_cartKey) ?? [];
      
      return rawList.map((item) {
        try {
          return CartItemEntity.fromRawJson(item);
        } catch (e) {
          debugPrint('Failed to parse cart item: $e');
          return null; 
        }
      }).whereType<CartItemEntity>().toList();
      
    } catch (e) {
      debugPrint('Failed to fetch cart from storage: $e');
      return [];
    }
  }

  Future<bool> saveCart(List<CartItemEntity> items) async {
    try {
      final rawList = items.map((item) => item.toRawJson()).toList();
      return await _prefs.setStringList(_cartKey, rawList);
    } catch (e) {
      debugPrint('Failed to save cart: $e');
      return false;
    }
  }

  Future<bool> clearCart() async {
    try {
      return await _prefs.remove(_cartKey);
    } catch (e) {
      debugPrint('Failed to clear cart: $e');
      return false;
    }
  }
}

final cartLocalDataSourceProvider = Provider<CartLocalDataSource>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return CartLocalDataSource(prefs);
});