import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_entity.freezed.dart';

@freezed
abstract class RatingEntity with _$RatingEntity {
  const factory RatingEntity({
    required double rate,
    required int count,
  }) = _RatingEntity;

  const RatingEntity._();
}