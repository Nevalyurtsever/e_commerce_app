import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'product.freezed.dart';
part 'product.g.dart';

@unfreezed
class Product with _$Product {
  const Product._();
  factory Product(
      {required String? id,
      required int? productCode,
      required String name,
      required String description,
      required String barkod,
      required double price,
      required double? discountedPrice,
      required String imageUrl,
      required String status,
      required double tax,
      required String? category,
      required int quantityInBox,
      required double boxPrice,
      required int? numberOfRows,
      required int? quantityInOnePallet}) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);

  double showPrice() {
    if (discountedPrice == null) {
      return price;
    } else {
      return discountedPrice!;
    }
  }
}
