import 'package:freezed_annotation/freezed_annotation.dart';

import 'address.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  factory AppUser({
    required String uid,
    required String email,
    required String? name,
    required String? lastName,
    required String? marketName,
    required String? phoneNumber,
    required String? customerRepresentative,
    required Address? address,
    required String? photoURL,
    required String? website,
    required String? taxNumber,
    String? role,
  }) = _AppUser;

  createFullName() {
    String fullName = '';

    if (role == "COMPANY") {
      fullName = marketName.toString();
    } else {
      if (name != null) {
        fullName = name!;
      }
      if (lastName != null) {
        fullName = "$fullName $lastName";
      }
    }

    return fullName;
  }

  factory AppUser.fromJson(Map<String, Object?> json) =>
      _$AppUserFromJson(json);
}
