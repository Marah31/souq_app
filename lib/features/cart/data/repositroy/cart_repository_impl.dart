import 'package:souq_app/features/cart/data/datasource/cart_local_datasource.dart';
import 'package:souq_app/features/cart/data/models/cart_model.dart';
import 'package:souq_app/features/cart/domain/entity/cart_item_entity.dart';
import 'package:souq_app/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl(this.localDataSource);

  @override
  List<CartItemEntity> getSavedCart() {
    final models = localDataSource.getSavedCart();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<bool> saveCart(List<CartItemEntity> items) async {
    final models = items.map((entity) => CartItemModel.fromEntity(entity)).toList();
    return await localDataSource.saveCart(models);
  }

  @override
  Future<bool> clearCart() async {
    return await localDataSource.clearCart();
  }
}