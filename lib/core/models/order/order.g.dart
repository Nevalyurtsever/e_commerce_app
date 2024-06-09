// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      id: json['id'] as String?,
      orderId: (json['orderId'] as num?)?.toInt(),
      orderedBy: json['orderedBy'] as String,
      orderer: json['orderer'] == null
          ? null
          : AppUser.fromJson(json['orderer'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderPrice: (json['orderPrice'] as num?)?.toDouble(),
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      note: json['note'] as String,
      videoUrl: json['videoUrl'] as String?,
      date: _dateFromJson(json['date'] as Timestamp),
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'orderedBy': instance.orderedBy,
      'orderer': instance.orderer,
      'items': instance.items,
      'orderPrice': instance.orderPrice,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'note': instance.note,
      'videoUrl': instance.videoUrl,
      'date': instance.date?.toIso8601String(),
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.packaged: 'packaged',
  OrderStatus.checked: 'checked',
  OrderStatus.shipped: 'shipped',
  OrderStatus.completed: 'completed',
};
