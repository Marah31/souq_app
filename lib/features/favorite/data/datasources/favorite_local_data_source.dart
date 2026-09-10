import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souq_app/features/products/data/models/product_dto.dart';

abstract class FavoritesLocalDataSource {
  Future<List<ProductDto>> getFavorites();
  Future<void> saveFavorites(List<ProductDto> products);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const String _favoritesKey = 'favorite_products_key';

  @override
  Future<List<ProductDto>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedJson = prefs.getString(_favoritesKey);
    if (savedJson == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(savedJson);
      return decoded
          .map((item) => ProductDto.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveFavorites(List<ProductDto> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(
      products.map((dto) => dto.toJson()).toList(),
    );
    await prefs.setString(_favoritesKey, encoded);
  }
}

final favoritesLocalDataSourceProvider = Provider<FavoritesLocalDataSource>((ref) {
  return FavoritesLocalDataSourceImpl();
});