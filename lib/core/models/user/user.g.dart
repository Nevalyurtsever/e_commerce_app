// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      lastName: json['lastName'] as String?,
      marketName: json['marketName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      customerRepresentative: json['customerRepresentative'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      photoURL: json['photoURL'] as String?,
      website: json['website'] as String?,
      taxNumber: json['taxNumber'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'lastName': instance.lastName,
      'marketName': instance.marketName,
      'phoneNumber': instance.phoneNumber,
      'customerRepresentative': instance.customerRepresentative,
      'address': instance.address?.toJson(),
      'photoURL': instance.photoURL,
      'website': instance.website,
      'taxNumber': instance.taxNumber,
      'role': instance.role,
    };
