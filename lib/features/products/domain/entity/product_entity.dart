import 'package:freezed_annotation/freezed_annotation.dart';
import 'rating_entity.dart';

part 'product_entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    required int id,
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
    required RatingEntity rating,
  }) = _ProductEntity;

  const ProductEntity._();
}