import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:souq_app/features/products/domain/entity/rating_entity.dart';

part 'rating_dto.freezed.dart';
part 'rating_dto.g.dart';

@freezed
abstract class RatingDto with _$RatingDto {
  const factory RatingDto({
    required double rate,
    required int count,
  }) = _RatingDto;

  const RatingDto._();

  factory RatingDto.fromJson(Map<String, dynamic> json) =>
      _$RatingDtoFromJson(json);

  RatingEntity toEntity() => RatingEntity(
        rate: rate,
        count: count,
      );
}