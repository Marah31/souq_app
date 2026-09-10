import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:souq_app/features/favorite/data/repository/favorite_repository_impl.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';

class FavoriteNotifier extends Notifier<List<ProductEntity>> {
  @override
  List<ProductEntity> build() {
    _loadFavorites();
    return const [];
  }

  Future<void> _loadFavorites() async {
    final repository = ref.read(favoriteRepositoryProvider);
    state = await repository.getFavorites();
  }

  Future<void> _saveFavorites(List<ProductEntity> updatedList) async {
    final repository = ref.read(favoriteRepositoryProvider);
    await repository.saveFavorites(updatedList);
  }

  void toggleFavorite(ProductEntity product) {
    final exists = state.any((p) => p.id == product.id);
    final newState = exists
        ? state.where((p) => p.id != product.id).toList()
        : [...state, product];

    state = newState;
    _saveFavorites(newState);
  }

  bool isFavorite(int productId) => state.any((p) => p.id == productId);

  void clearFavorites() {
    state = const [];
    _saveFavorites(const []);
  }
}

final favoriteProductsProvider =
    NotifierProvider<FavoriteNotifier, List<ProductEntity>>(
  FavoriteNotifier.new,
);