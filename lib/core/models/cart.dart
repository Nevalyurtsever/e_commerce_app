import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'product.dart';
part 'cart.freezed.dart';
part 'cart.g.dart';

@unfreezed
class CartModel with _$CartModel {
  factory CartModel(
      {required String? id,
      required String productId,
      required int quantity,
      required Product? product}) = _CartModel;

  factory CartModel.fromJson(Map<String, Object?> json) =>
      _$CartModelFromJson(json);
}
