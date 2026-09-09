import 'dart:convert';
import 'package:souq_app/features/cart/domain/entity/cart_item_entity.dart';
import 'package:souq_app/features/products/data/models/product_dto.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';

class CartItemModel {
  final ProductEntity product;
  final int quantity;

  const CartItemModel({
    required this.product,
    required this.quantity,
  });

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      product: entity.product,
      quantity: entity.quantity,
    );
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      product: product,
      quantity: quantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final prodJson = json['product'] as Map<String, dynamic>;
    return CartItemModel(
      quantity: json['quantity'] as int? ?? 1,
      product: ProductDto.fromJson(prodJson).toEntity(), // Uses ProductModel mapping if available
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'product': {
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': product.category,
        'image': product.image,
        'rating': {
          'rate': product.rating.rate,
          'count': product.rating.count,
        },
      },
    };
  }

  String toRawJson() => json.encode(toJson());

  factory CartItemModel.fromRawJson(String source) =>
      CartItemModel.fromJson(json.decode(source) as Map<String, dynamic>);
}