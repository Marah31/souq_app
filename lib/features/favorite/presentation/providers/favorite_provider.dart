import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import 'package:souq_app/features/products/presentation/providers/product_provider.dart';

class FavoritesNotifier extends Notifier<Set<int>> {
  @override
  Set<int> build() => {};

  void toggleFavorite(int productId) {
    if (state.contains(productId)) {
      state = {...state}..remove(productId);
    } else {
      state = {...state, productId};
    }
  }

  bool isFavorite(int productId) => state.contains(productId);
}

final favoritesNotifierProvider =
    NotifierProvider<FavoritesNotifier, Set<int>>(FavoritesNotifier.new);

final favoriteProductsProvider = Provider<List<ProductEntity>>((ref) {
  final productsAsync = ref.watch(fetchProductsProvider);
  final favoriteIds = ref.watch(favoritesNotifierProvider);

  return productsAsync.maybeWhen(
    data: (products) =>
        products.where((p) => favoriteIds.contains(p.id)).toList(),
    orElse: () => [],
  );
});