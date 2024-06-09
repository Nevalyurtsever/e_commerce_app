// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SlideImpl _$$SlideImplFromJson(Map<String, dynamic> json) => _$SlideImpl(
      id: json['id'] as String,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      productId: json['productId'] as String,
      imageUrl: json['imageUrl'] as String,
      status: json['status'] as String,
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$$SlideImplToJson(_$SlideImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'productId': instance.productId,
      'imageUrl': instance.imageUrl,
      'status': instance.status,
      'order': instance.order,
    };
