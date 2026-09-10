import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:souq_app/features/favorite/data/datasources/favorite_local_data_source.dart';
import 'package:souq_app/features/favorite/domain/repository/favorite_repository.dart';
import 'package:souq_app/features/products/data/models/product_dto.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoriteRepositoryImpl(this.localDataSource);

  @override
  Future<List<ProductEntity>> getFavorites() async {
    final dtos = await localDataSource.getFavorites();
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<void> saveFavorites(List<ProductEntity> products) async {
    final dtos = products.map((entity) => ProductDto.fromEntity(entity)).toList();
    await localDataSource.saveFavorites(dtos);
  }
}

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  final localDataSource = ref.watch(favoritesLocalDataSourceProvider);
  return FavoriteRepositoryImpl(localDataSource);
});