// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../user/user.dart';
import 'order_item.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@unfreezed
class OrderModel with _$OrderModel {
  const OrderModel._();
  factory OrderModel({
    required String? id,
    required int? orderId,
    required String orderedBy,
    required AppUser? orderer,
    required List<OrderItem>? items,
    required double? orderPrice,
    required OrderStatus status,
    required String note,
    required String? videoUrl,
    @JsonKey(name: 'date', fromJson: _dateFromJson) DateTime? date,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, Object?> json) =>
      _$OrderModelFromJson(json);

  statusToString() {
    String state = '';
    switch (status) {
      case OrderStatus.pending:
        state = "Pending";
        break;
      case OrderStatus.packaged:
        state = "Packaged";
        break;
      case OrderStatus.checked:
        state = "Checked";
        break;
      case OrderStatus.shipped:
        state = "Shipped";
        break;
      case OrderStatus.completed:
        state = "Completed";
        break;

      default:
        state = "Pending";
    }
    return state;
  }
}

DateTime _dateFromJson(Timestamp timestamp) => timestamp.toDate();

enum OrderStatus { pending, packaged, checked, shipped, completed }
