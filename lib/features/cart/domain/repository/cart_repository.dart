import 'package:souq_app/features/cart/domain/entity/cart_item_entity.dart';

abstract class CartRepository {
  List<CartItemEntity> getSavedCart();
  Future<bool> saveCart(List<CartItemEntity> items);
  Future<bool> clearCart();
}