// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RatingDto _$RatingDtoFromJson(Map<String, dynamic> json) => _RatingDto(
  rate: (json['rate'] as num).toDouble(),
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$RatingDtoToJson(_RatingDto instance) =>
    <String, dynamic>{'rate': instance.rate, 'count': instance.count};
