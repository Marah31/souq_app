// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RatingDto {

 double get rate; int get count;
/// Create a copy of RatingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingDtoCopyWith<RatingDto> get copyWith => _$RatingDtoCopyWithImpl<RatingDto>(this as RatingDto, _$identity);

  /// Serializes this RatingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingDto&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rate,count);

@override
String toString() {
  return 'RatingDto(rate: $rate, count: $count)';
}


}

/// @nodoc
abstract mixin class $RatingDtoCopyWith<$Res>  {
  factory $RatingDtoCopyWith(RatingDto value, $Res Function(RatingDto) _then) = _$RatingDtoCopyWithImpl;
@useResult
$Res call({
 double rate, int count
});




}
/// @nodoc
class _$RatingDtoCopyWithImpl<$Res>
    implements $RatingDtoCopyWith<$Res> {
  _$RatingDtoCopyWithImpl(this._self, this._then);

  final RatingDto _self;
  final $Res Function(RatingDto) _then;

/// Create a copy of RatingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rate = null,Object? count = null,}) {
  return _then(_self.copyWith(
rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RatingDto].
extension RatingDtoPatterns on RatingDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatingDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatingDto value)  $default,){
final _that = this;
switch (_that) {
case _RatingDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatingDto value)?  $default,){
final _that = this;
switch (_that) {
case _RatingDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double rate,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatingDto() when $default != null:
return $default(_that.rate,_that.count);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double rate,  int count)  $default,) {final _that = this;
switch (_that) {
case _RatingDto():
return $default(_that.rate,_that.count);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double rate,  int count)?  $default,) {final _that = this;
switch (_that) {
case _RatingDto() when $default != null:
return $default(_that.rate,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RatingDto extends RatingDto {
  const _RatingDto({required this.rate, required this.count}): super._();
  factory _RatingDto.fromJson(Map<String, dynamic> json) => _$RatingDtoFromJson(json);

@override final  double rate;
@override final  int count;

/// Create a copy of RatingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatingDtoCopyWith<_RatingDto> get copyWith => __$RatingDtoCopyWithImpl<_RatingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatingDto&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rate,count);

@override
String toString() {
  return 'RatingDto(rate: $rate, count: $count)';
}


}

/// @nodoc
abstract mixin class _$RatingDtoCopyWith<$Res> implements $RatingDtoCopyWith<$Res> {
  factory _$RatingDtoCopyWith(_RatingDto value, $Res Function(_RatingDto) _then) = __$RatingDtoCopyWithImpl;
@override @useResult
$Res call({
 double rate, int count
});




}
/// @nodoc
class __$RatingDtoCopyWithImpl<$Res>
    implements _$RatingDtoCopyWith<$Res> {
  __$RatingDtoCopyWithImpl(this._self, this._then);

  final _RatingDto _self;
  final $Res Function(_RatingDto) _then;

/// Create a copy of RatingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rate = null,Object? count = null,}) {
  return _then(_RatingDto(
rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
