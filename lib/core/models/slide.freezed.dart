// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slide.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Slide _$SlideFromJson(Map<String, dynamic> json) {
  return _Slide.fromJson(json);
}

/// @nodoc
mixin _$Slide {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  Product? get product => throw _privateConstructorUsedError;
  set product(Product? value) => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  set productId(String value) => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  set imageUrl(String value) => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  set status(String value) => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  set order(int value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SlideCopyWith<Slide> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlideCopyWith<$Res> {
  factory $SlideCopyWith(Slide value, $Res Function(Slide) then) =
      _$SlideCopyWithImpl<$Res, Slide>;
  @useResult
  $Res call(
      {String id,
      Product? product,
      String productId,
      String imageUrl,
      String status,
      int order});

  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class _$SlideCopyWithImpl<$Res, $Val extends Slide>
    implements $SlideCopyWith<$Res> {
  _$SlideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? product = freezed,
    Object? productId = null,
    Object? imageUrl = null,
    Object? status = null,
    Object? order = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SlideImplCopyWith<$Res> implements $SlideCopyWith<$Res> {
  factory _$$SlideImplCopyWith(
          _$SlideImpl value, $Res Function(_$SlideImpl) then) =
      __$$SlideImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Product? product,
      String productId,
      String imageUrl,
      String status,
      int order});

  @override
  $ProductCopyWith<$Res>? get product;
}

/// @nodoc
class __$$SlideImplCopyWithImpl<$Res>
    extends _$SlideCopyWithImpl<$Res, _$SlideImpl>
    implements _$$SlideImplCopyWith<$Res> {
  __$$SlideImplCopyWithImpl(
      _$SlideImpl _value, $Res Function(_$SlideImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? product = freezed,
    Object? productId = null,
    Object? imageUrl = null,
    Object? status = null,
    Object? order = null,
  }) {
    return _then(_$SlideImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SlideImpl implements _Slide {
  _$SlideImpl(
      {required this.id,
      required this.product,
      required this.productId,
      required this.imageUrl,
      required this.status,
      required this.order});

  factory _$SlideImpl.fromJson(Map<String, dynamic> json) =>
      _$$SlideImplFromJson(json);

  @override
  String id;
  @override
  Product? product;
  @override
  String productId;
  @override
  String imageUrl;
  @override
  String status;
  @override
  int order;

  @override
  String toString() {
    return 'Slide(id: $id, product: $product, productId: $productId, imageUrl: $imageUrl, status: $status, order: $order)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideImplCopyWith<_$SlideImpl> get copyWith =>
      __$$SlideImplCopyWithImpl<_$SlideImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SlideImplToJson(
      this,
    );
  }
}

abstract class _Slide implements Slide {
  factory _Slide(
      {required String id,
      required Product? product,
      required String productId,
      required String imageUrl,
      required String status,
      required int order}) = _$SlideImpl;

  factory _Slide.fromJson(Map<String, dynamic> json) = _$SlideImpl.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  Product? get product;
  set product(Product? value);
  @override
  String get productId;
  set productId(String value);
  @override
  String get imageUrl;
  set imageUrl(String value);
  @override
  String get status;
  set status(String value);
  @override
  int get order;
  set order(int value);
  @override
  @JsonKey(ignore: true)
  _$$SlideImplCopyWith<_$SlideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
