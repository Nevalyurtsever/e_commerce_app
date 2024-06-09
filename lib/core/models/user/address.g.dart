// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      country: json['country'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      street: json['street'] as String?,
      no: json['no'] as String?,
      zipcode: json['zipcode'] as String?,
      town: json['town'] as String?,
      additionalAddress: json['additionalAddress'] as String?,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'no': instance.no,
      'zipcode': instance.zipcode,
      'town': instance.town,
      'additionalAddress': instance.additionalAddress,
    };
