import 'package:freezed_annotation/freezed_annotation.dart';

import '../product.dart';

part 'order_item.freezed.dart';
part 'order_item.g.dart';

@unfreezed
class OrderItem with _$OrderItem {
  factory OrderItem(
      {required String? id,
      required String productId,
      required int quantity,
      required double? unitPrice,
      required String status,
      Product? product}) = _OrderItem;

  factory OrderItem.fromJson(Map<String, Object?> json) =>
      _$OrderItemFromJson(json);
}
