// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String?,
      productCode: (json['productCode'] as num?)?.toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      barkod: json['barkod'] as String,
      price: (json['price'] as num).toDouble(),
      discountedPrice: (json['discountedPrice'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String,
      status: json['status'] as String,
      tax: (json['tax'] as num).toDouble(),
      category: json['category'] as String?,
      quantityInBox: (json['quantityInBox'] as num).toInt(),
      boxPrice: (json['boxPrice'] as num).toDouble(),
      numberOfRows: (json['numberOfRows'] as num?)?.toInt(),
      quantityInOnePallet: (json['quantityInOnePallet'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productCode': instance.productCode,
      'name': instance.name,
      'description': instance.description,
      'barkod': instance.barkod,
      'price': instance.price,
      'discountedPrice': instance.discountedPrice,
      'imageUrl': instance.imageUrl,
      'status': instance.status,
      'tax': instance.tax,
      'category': instance.category,
      'quantityInBox': instance.quantityInBox,
      'boxPrice': instance.boxPrice,
      'numberOfRows': instance.numberOfRows,
      'quantityInOnePallet': instance.quantityInOnePallet,
    };
