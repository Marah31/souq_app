import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:souq_app/features/favorite/data/favorite_local_data_source.dart';
import 'package:souq_app/features/products/data/models/product_dto.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';

final favoritesLocalDataSourceProvider = Provider<FavoritesLocalDataSource>((ref) {
  return FavoritesLocalDataSourceImpl();
});

class FavoriteNotifier extends Notifier<List<ProductEntity>> {
  @override
  List<ProductEntity> build() {
    _loadFavorites();
    return const [];
  }

  Future<void> _loadFavorites() async {
    final dataSource = ref.read(favoritesLocalDataSourceProvider);
    final dtos = await dataSource.getFavorites();
    state = dtos.map((dto) => dto.toEntity()).toList();
  }

  Future<void> _saveFavorites(List<ProductEntity> updatedList) async {
    final dataSource = ref.read(favoritesLocalDataSourceProvider);
    final dtos = updatedList.map((e) => ProductDto.fromEntity(e)).toList();
    await dataSource.saveFavorites(dtos);
  }

  void toggleFavorite(ProductEntity product) {
    final exists = state.any((p) => p.id == product.id);
    List<ProductEntity> newState;

    if (exists) {
      newState = state.where((p) => p.id != product.id).toList();
    } else {
      newState = [...state, product];
    }

    state = newState;
    _saveFavorites(newState);
  }

  bool isFavorite(int productId) {
    return state.any((p) => p.id == productId);
  }

  void clearFavorites() {
    state = const [];
    _saveFavorites(const []);
  }
}

final favoriteProductsProvider =
    NotifierProvider<FavoriteNotifier, List<ProductEntity>>(
  FavoriteNotifier.new,
);