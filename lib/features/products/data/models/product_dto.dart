
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:souq_app/features/products/domain/entity/product_entity.dart';

import 'rating_dto.dart';

part 'product_dto.freezed.dart';
part 'product_dto.g.dart';

@freezed
abstract class ProductDto with _$ProductDto {
  const factory ProductDto({
    required int id,
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
    required RatingDto rating,
  }) = _ProductDto;

  const ProductDto._();

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  ProductEntity toEntity() => ProductEntity(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rating: rating.toEntity(),
      );
  factory ProductDto.fromEntity(ProductEntity entity) => ProductDto(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.description,
      category: entity.category,
      image: entity.image,
      rating: RatingDto.fromEntity(entity.rating),
    );
}