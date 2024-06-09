import 'package:freezed_annotation/freezed_annotation.dart';
part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  factory Address({
    required String? country,
    required String? state,
    required String? city,
    required String? street,
    required String? no,
    required String? zipcode,
    required String? town,
    required String? additionalAddress,
  }) = _Address;

  factory Address.fromJson(Map<String, Object?> json) =>
      _$AddressFromJson(json);
}
