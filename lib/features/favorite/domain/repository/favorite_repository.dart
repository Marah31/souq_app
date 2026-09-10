import 'package:souq_app/features/products/domain/entity/product_entity.dart';

abstract class FavoriteRepository {
  Future<List<ProductEntity>> getFavorites();
  Future<void> saveFavorites(List<ProductEntity> products);
}