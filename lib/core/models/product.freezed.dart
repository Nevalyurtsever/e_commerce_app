// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  int? get productCode => throw _privateConstructorUsedError;
  set productCode(int? value) => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  set name(String value) => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  set description(String value) => throw _privateConstructorUsedError;
  String get barkod => throw _privateConstructorUsedError;
  set barkod(String value) => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  set price(double value) => throw _privateConstructorUsedError;
  double? get discountedPrice => throw _privateConstructorUsedError;
  set discountedPrice(double? value) => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  set imageUrl(String value) => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  set status(String value) => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  set tax(double value) => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  set category(String? value) => throw _privateConstructorUsedError;
  int get quantityInBox => throw _privateConstructorUsedError;
  set quantityInBox(int value) => throw _privateConstructorUsedError;
  double get boxPrice => throw _privateConstructorUsedError;
  set boxPrice(double value) => throw _privateConstructorUsedError;
  int? get numberOfRows => throw _privateConstructorUsedError;
  set numberOfRows(int? value) => throw _privateConstructorUsedError;
  int? get quantityInOnePallet => throw _privateConstructorUsedError;
  set quantityInOnePallet(int? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {String? id,
      int? productCode,
      String name,
      String description,
      String barkod,
      double price,
      double? discountedPrice,
      String imageUrl,
      String status,
      double tax,
      String? category,
      int quantityInBox,
      double boxPrice,
      int? numberOfRows,
      int? quantityInOnePallet});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? productCode = freezed,
    Object? name = null,
    Object? description = null,
    Object? barkod = null,
    Object? price = null,
    Object? discountedPrice = freezed,
    Object? imageUrl = null,
    Object? status = null,
    Object? tax = null,
    Object? category = freezed,
    Object? quantityInBox = null,
    Object? boxPrice = null,
    Object? numberOfRows = freezed,
    Object? quantityInOnePallet = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      barkod: null == barkod
          ? _value.barkod
          : barkod // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      discountedPrice: freezed == discountedPrice
          ? _value.discountedPrice
          : discountedPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      quantityInBox: null == quantityInBox
          ? _value.quantityInBox
          : quantityInBox // ignore: cast_nullable_to_non_nullable
              as int,
      boxPrice: null == boxPrice
          ? _value.boxPrice
          : boxPrice // ignore: cast_nullable_to_non_nullable
              as double,
      numberOfRows: freezed == numberOfRows
          ? _value.numberOfRows
          : numberOfRows // ignore: cast_nullable_to_non_nullable
              as int?,
      quantityInOnePallet: freezed == quantityInOnePallet
          ? _value.quantityInOnePallet
          : quantityInOnePallet // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      int? productCode,
      String name,
      String description,
      String barkod,
      double price,
      double? discountedPrice,
      String imageUrl,
      String status,
      double tax,
      String? category,
      int quantityInBox,
      double boxPrice,
      int? numberOfRows,
      int? quantityInOnePallet});
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? productCode = freezed,
    Object? name = null,
    Object? description = null,
    Object? barkod = null,
    Object? price = null,
    Object? discountedPrice = freezed,
    Object? imageUrl = null,
    Object? status = null,
    Object? tax = null,
    Object? category = freezed,
    Object? quantityInBox = null,
    Object? boxPrice = null,
    Object? numberOfRows = freezed,
    Object? quantityInOnePallet = freezed,
  }) {
    return _then(_$ProductImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      barkod: null == barkod
          ? _value.barkod
          : barkod // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      discountedPrice: freezed == discountedPrice
          ? _value.discountedPrice
          : discountedPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      quantityInBox: null == quantityInBox
          ? _value.quantityInBox
          : quantityInBox // ignore: cast_nullable_to_non_nullable
              as int,
      boxPrice: null == boxPrice
          ? _value.boxPrice
          : boxPrice // ignore: cast_nullable_to_non_nullable
              as double,
      numberOfRows: freezed == numberOfRows
          ? _value.numberOfRows
          : numberOfRows // ignore: cast_nullable_to_non_nullable
              as int?,
      quantityInOnePallet: freezed == quantityInOnePallet
          ? _value.quantityInOnePallet
          : quantityInOnePallet // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl extends _Product with DiagnosticableTreeMixin {
  _$ProductImpl(
      {required this.id,
      required this.productCode,
      required this.name,
      required this.description,
      required this.barkod,
      required this.price,
      required this.discountedPrice,
      required this.imageUrl,
      required this.status,
      required this.tax,
      required this.category,
      required this.quantityInBox,
      required this.boxPrice,
      required this.numberOfRows,
      required this.quantityInOnePallet})
      : super._();

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  String? id;
  @override
  int? productCode;
  @override
  String name;
  @override
  String description;
  @override
  String barkod;
  @override
  double price;
  @override
  double? discountedPrice;
  @override
  String imageUrl;
  @override
  String status;
  @override
  double tax;
  @override
  String? category;
  @override
  int quantityInBox;
  @override
  double boxPrice;
  @override
  int? numberOfRows;
  @override
  int? quantityInOnePallet;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Product(id: $id, productCode: $productCode, name: $name, description: $description, barkod: $barkod, price: $price, discountedPrice: $discountedPrice, imageUrl: $imageUrl, status: $status, tax: $tax, category: $category, quantityInBox: $quantityInBox, boxPrice: $boxPrice, numberOfRows: $numberOfRows, quantityInOnePallet: $quantityInOnePallet)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Product'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('productCode', productCode))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('barkod', barkod))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('discountedPrice', discountedPrice))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('tax', tax))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('quantityInBox', quantityInBox))
      ..add(DiagnosticsProperty('boxPrice', boxPrice))
      ..add(DiagnosticsProperty('numberOfRows', numberOfRows))
      ..add(DiagnosticsProperty('quantityInOnePallet', quantityInOnePallet));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product extends Product {
  factory _Product(
      {required String? id,
      required int? productCode,
      required String name,
      required String description,
      required String barkod,
      required double price,
      required double? discountedPrice,
      required String imageUrl,
      required String status,
      required double tax,
      required String? category,
      required int quantityInBox,
      required double boxPrice,
      required int? numberOfRows,
      required int? quantityInOnePallet}) = _$ProductImpl;
  _Product._() : super._();

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  int? get productCode;
  set productCode(int? value);
  @override
  String get name;
  set name(String value);
  @override
  String get description;
  set description(String value);
  @override
  String get barkod;
  set barkod(String value);
  @override
  double get price;
  set price(double value);
  @override
  double? get discountedPrice;
  set discountedPrice(double? value);
  @override
  String get imageUrl;
  set imageUrl(String value);
  @override
  String get status;
  set status(String value);
  @override
  double get tax;
  set tax(double value);
  @override
  String? get category;
  set category(String? value);
  @override
  int get quantityInBox;
  set quantityInBox(int value);
  @override
  double get boxPrice;
  set boxPrice(double value);
  @override
  int? get numberOfRows;
  set numberOfRows(int? value);
  @override
  int? get quantityInOnePallet;
  set quantityInOnePallet(int? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
