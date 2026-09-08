import 'dart:convert';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souq_app/features/products/data/models/product_dto.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';

const String _favoritesStorageKey = 'favorite_products_key';

class FavoriteNotifier extends StateNotifier<List<ProductEntity>> {
  FavoriteNotifier() : super([]) {
    _loadFavoritesFromStorage();
  }

  Future<void> _loadFavoritesFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedJson = prefs.getString(_favoritesStorageKey);

    if (savedJson != null) {
      try {
        final List<dynamic> decodedList = jsonDecode(savedJson);
        final List<ProductEntity> loadedProducts = decodedList
            .map((item) => ProductDto.fromJson(item as Map<String, dynamic>).toEntity())
            .toList();

        state = loadedProducts;
      } catch (e) {
        state = [];
      }
    }
  }

  Future<void> _saveFavoritesToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      state.map((product) => ProductDto.fromEntity(product).toJson()).toList(),
    );
    await prefs.setString(_favoritesStorageKey, encodedData);
  }

  void toggleFavorite(ProductEntity product) {
    if (isFavorite(product.id)) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
    _saveFavoritesToStorage();
  }

  bool isFavorite(int productId) {
    return state.any((p) => p.id == productId);
  }

  void clearFavorites() {
    state = [];
    _saveFavoritesToStorage();
  }
}

final favoriteProductsProvider =
    StateNotifierProvider<FavoriteNotifier, List<ProductEntity>>((ref) {
  return FavoriteNotifier();
});