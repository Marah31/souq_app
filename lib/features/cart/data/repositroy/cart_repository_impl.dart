
import 'package:souq_app/features/cart/data/datasource/cart_local_datasource.dart';
import 'package:souq_app/features/cart/domain/entity/cart_item_entity.dart';
import 'package:souq_app/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource _localDataSource;

  CartRepositoryImpl(this._localDataSource);

  @override
  List<CartItemEntity> getSavedCart() {
    return _localDataSource.getSavedCart();
  }

  @override
  Future<bool> saveCart(List<CartItemEntity> items) {
    return _localDataSource.saveCart(items);
  }

  @override
  Future<bool> clearCart() {
    return _localDataSource.clearCart();
  }
}