import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';

part 'cart_item_entity.freezed.dart';

@freezed
abstract class CartItemEntity with _$CartItemEntity {
  const factory CartItemEntity({
    required ProductEntity product,
    required int quantity,
  }) = _CartItemEntity;

  const CartItemEntity._();
  double get totalPrice => product.price * quantity;
}
