import 'dart:convert';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';
import 'package:souq_app/features/products/domain/entity/rating_entity.dart';

class CartItemEntity {
  final ProductEntity product;
  final int quantity;

  const CartItemEntity({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;

  CartItemEntity copyWith({
    ProductEntity? product,
    int? quantity,
  }) {
    return CartItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
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

  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    final prodJson = json['product'] as Map<String, dynamic>;
    return CartItemEntity(
      quantity: json['quantity'] as int? ?? 1,
      product: ProductEntity(
        id: prodJson['id'] as int,
        title: prodJson['title'] as String,
        price: (prodJson['price'] as num).toDouble(),
        description: prodJson['description'] as String,
        category: prodJson['category'] as String,
        image: prodJson['image'] as String,
        rating: RatingEntity(
          rate: (prodJson['rating']['rate'] as num).toDouble(),
          count: prodJson['rating']['count'] as int,
        ),
      ),
    );
  }

  String toRawJson() => json.encode(toJson());
  factory CartItemEntity.fromRawJson(String source) =>
      CartItemEntity.fromJson(json.decode(source) as Map<String, dynamic>);
}