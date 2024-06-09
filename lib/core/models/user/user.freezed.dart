// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get marketName => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get customerRepresentative => throw _privateConstructorUsedError;
  Address? get address => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get taxNumber => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String? name,
      String? lastName,
      String? marketName,
      String? phoneNumber,
      String? customerRepresentative,
      Address? address,
      String? photoURL,
      String? website,
      String? taxNumber,
      String? role});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? name = freezed,
    Object? lastName = freezed,
    Object? marketName = freezed,
    Object? phoneNumber = freezed,
    Object? customerRepresentative = freezed,
    Object? address = freezed,
    Object? photoURL = freezed,
    Object? website = freezed,
    Object? taxNumber = freezed,
    Object? role = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      marketName: freezed == marketName
          ? _value.marketName
          : marketName // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      customerRepresentative: freezed == customerRepresentative
          ? _value.customerRepresentative
          : customerRepresentative // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      taxNumber: freezed == taxNumber
          ? _value.taxNumber
          : taxNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
          _$AppUserImpl value, $Res Function(_$AppUserImpl) then) =
      __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String? name,
      String? lastName,
      String? marketName,
      String? phoneNumber,
      String? customerRepresentative,
      Address? address,
      String? photoURL,
      String? website,
      String? taxNumber,
      String? role});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
      _$AppUserImpl _value, $Res Function(_$AppUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? name = freezed,
    Object? lastName = freezed,
    Object? marketName = freezed,
    Object? phoneNumber = freezed,
    Object? customerRepresentative = freezed,
    Object? address = freezed,
    Object? photoURL = freezed,
    Object? website = freezed,
    Object? taxNumber = freezed,
    Object? role = freezed,
  }) {
    return _then(_$AppUserImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      marketName: freezed == marketName
          ? _value.marketName
          : marketName // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      customerRepresentative: freezed == customerRepresentative
          ? _value.customerRepresentative
          : customerRepresentative // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      taxNumber: freezed == taxNumber
          ? _value.taxNumber
          : taxNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$AppUserImpl extends _AppUser {
  _$AppUserImpl(
      {required this.uid,
      required this.email,
      required this.name,
      required this.lastName,
      required this.marketName,
      required this.phoneNumber,
      required this.customerRepresentative,
      required this.address,
      required this.photoURL,
      required this.website,
      required this.taxNumber,
      this.role})
      : super._();

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  final String uid;
  @override
  final String email;
  @override
  final String? name;
  @override
  final String? lastName;
  @override
  final String? marketName;
  @override
  final String? phoneNumber;
  @override
  final String? customerRepresentative;
  @override
  final Address? address;
  @override
  final String? photoURL;
  @override
  final String? website;
  @override
  final String? taxNumber;
  @override
  final String? role;

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, name: $name, lastName: $lastName, marketName: $marketName, phoneNumber: $phoneNumber, customerRepresentative: $customerRepresentative, address: $address, photoURL: $photoURL, website: $website, taxNumber: $taxNumber, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.marketName, marketName) ||
                other.marketName == marketName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.customerRepresentative, customerRepresentative) ||
                other.customerRepresentative == customerRepresentative) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.taxNumber, taxNumber) ||
                other.taxNumber == taxNumber) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      name,
      lastName,
      marketName,
      phoneNumber,
      customerRepresentative,
      address,
      photoURL,
      website,
      taxNumber,
      role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(
      this,
    );
  }
}

abstract class _AppUser extends AppUser {
  factory _AppUser(
      {required final String uid,
      required final String email,
      required final String? name,
      required final String? lastName,
      required final String? marketName,
      required final String? phoneNumber,
      required final String? customerRepresentative,
      required final Address? address,
      required final String? photoURL,
      required final String? website,
      required final String? taxNumber,
      final String? role}) = _$AppUserImpl;
  _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  String get uid;
  @override
  String get email;
  @override
  String? get name;
  @override
  String? get lastName;
  @override
  String? get marketName;
  @override
  String? get phoneNumber;
  @override
  String? get customerRepresentative;
  @override
  Address? get address;
  @override
  String? get photoURL;
  @override
  String? get website;
  @override
  String? get taxNumber;
  @override
  String? get role;
  @override
  @JsonKey(ignore: true)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
