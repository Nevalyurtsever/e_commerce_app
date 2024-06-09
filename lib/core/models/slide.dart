import 'package:freezed_annotation/freezed_annotation.dart';

import 'product.dart';
part 'slide.freezed.dart';
part 'slide.g.dart';

@unfreezed
class Slide with _$Slide {
  factory Slide(
      {required String id,
      required Product? product,
      required String productId,
      required String imageUrl,
      required String status,
      required int order}) = _Slide;

  factory Slide.fromJson(Map<String, Object?> json) => _$SlideFromJson(json);
}
