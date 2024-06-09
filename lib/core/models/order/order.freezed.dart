// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
mixin _$OrderModel {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  int? get orderId => throw _privateConstructorUsedError;
  set orderId(int? value) => throw _privateConstructorUsedError;
  String get orderedBy => throw _privateConstructorUsedError;
  set orderedBy(String value) => throw _privateConstructorUsedError;
  AppUser? get orderer => throw _privateConstructorUsedError;
  set orderer(AppUser? value) => throw _privateConstructorUsedError;
  List<OrderItem>? get items => throw _privateConstructorUsedError;
  set items(List<OrderItem>? value) => throw _privateConstructorUsedError;
  double? get orderPrice => throw _privateConstructorUsedError;
  set orderPrice(double? value) => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  set status(OrderStatus value) => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  set note(String value) => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  set videoUrl(String? value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'date', fromJson: _dateFromJson)
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'date', fromJson: _dateFromJson)
  set date(DateTime? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
          OrderModel value, $Res Function(OrderModel) then) =
      _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call(
      {String? id,
      int? orderId,
      String orderedBy,
      AppUser? orderer,
      List<OrderItem>? items,
      double? orderPrice,
      OrderStatus status,
      String note,
      String? videoUrl,
      @JsonKey(name: 'date', fromJson: _dateFromJson) DateTime? date});

  $AppUserCopyWith<$Res>? get orderer;
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? orderId = freezed,
    Object? orderedBy = null,
    Object? orderer = freezed,
    Object? items = freezed,
    Object? orderPrice = freezed,
    Object? status = null,
    Object? note = null,
    Object? videoUrl = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      orderedBy: null == orderedBy
          ? _value.orderedBy
          : orderedBy // ignore: cast_nullable_to_non_nullable
              as String,
      orderer: freezed == orderer
          ? _value.orderer
          : orderer // ignore: cast_nullable_to_non_nullable
              as AppUser?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>?,
      orderPrice: freezed == orderPrice
          ? _value.orderPrice
          : orderPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res>? get orderer {
    if (_value.orderer == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_value.orderer!, (value) {
      return _then(_value.copyWith(orderer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderModelImplCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$OrderModelImplCopyWith(
          _$OrderModelImpl value, $Res Function(_$OrderModelImpl) then) =
      __$$OrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      int? orderId,
      String orderedBy,
      AppUser? orderer,
      List<OrderItem>? items,
      double? orderPrice,
      OrderStatus status,
      String note,
      String? videoUrl,
      @JsonKey(name: 'date', fromJson: _dateFromJson) DateTime? date});

  @override
  $AppUserCopyWith<$Res>? get orderer;
}

/// @nodoc
class __$$OrderModelImplCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$OrderModelImpl>
    implements _$$OrderModelImplCopyWith<$Res> {
  __$$OrderModelImplCopyWithImpl(
      _$OrderModelImpl _value, $Res Function(_$OrderModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? orderId = freezed,
    Object? orderedBy = null,
    Object? orderer = freezed,
    Object? items = freezed,
    Object? orderPrice = freezed,
    Object? status = null,
    Object? note = null,
    Object? videoUrl = freezed,
    Object? date = freezed,
  }) {
    return _then(_$OrderModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      orderedBy: null == orderedBy
          ? _value.orderedBy
          : orderedBy // ignore: cast_nullable_to_non_nullable
              as String,
      orderer: freezed == orderer
          ? _value.orderer
          : orderer // ignore: cast_nullable_to_non_nullable
              as AppUser?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>?,
      orderPrice: freezed == orderPrice
          ? _value.orderPrice
          : orderPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderModelImpl extends _OrderModel {
  _$OrderModelImpl(
      {required this.id,
      required this.orderId,
      required this.orderedBy,
      required this.orderer,
      required this.items,
      required this.orderPrice,
      required this.status,
      required this.note,
      required this.videoUrl,
      @JsonKey(name: 'date', fromJson: _dateFromJson) this.date})
      : super._();

  factory _$OrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderModelImplFromJson(json);

  @override
  String? id;
  @override
  int? orderId;
  @override
  String orderedBy;
  @override
  AppUser? orderer;
  @override
  List<OrderItem>? items;
  @override
  double? orderPrice;
  @override
  OrderStatus status;
  @override
  String note;
  @override
  String? videoUrl;
  @override
  @JsonKey(name: 'date', fromJson: _dateFromJson)
  DateTime? date;

  @override
  String toString() {
    return 'OrderModel(id: $id, orderId: $orderId, orderedBy: $orderedBy, orderer: $orderer, items: $items, orderPrice: $orderPrice, status: $status, note: $note, videoUrl: $videoUrl, date: $date)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      __$$OrderModelImplCopyWithImpl<_$OrderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderModelImplToJson(
      this,
    );
  }
}

abstract class _OrderModel extends OrderModel {
  factory _OrderModel(
          {required String? id,
          required int? orderId,
          required String orderedBy,
          required AppUser? orderer,
          required List<OrderItem>? items,
          required double? orderPrice,
          required OrderStatus status,
          required String note,
          required String? videoUrl,
          @JsonKey(name: 'date', fromJson: _dateFromJson) DateTime? date}) =
      _$OrderModelImpl;
  _OrderModel._() : super._();

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$OrderModelImpl.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  int? get orderId;
  set orderId(int? value);
  @override
  String get orderedBy;
  set orderedBy(String value);
  @override
  AppUser? get orderer;
  set orderer(AppUser? value);
  @override
  List<OrderItem>? get items;
  set items(List<OrderItem>? value);
  @override
  double? get orderPrice;
  set orderPrice(double? value);
  @override
  OrderStatus get status;
  set status(OrderStatus value);
  @override
  String get note;
  set note(String value);
  @override
  String? get videoUrl;
  set videoUrl(String? value);
  @override
  @JsonKey(name: 'date', fromJson: _dateFromJson)
  DateTime? get date;
  @JsonKey(name: 'date', fromJson: _dateFromJson)
  set date(DateTime? value);
  @override
  @JsonKey(ignore: true)
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
