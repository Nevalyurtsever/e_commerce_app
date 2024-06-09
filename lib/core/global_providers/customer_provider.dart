import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user/user.dart';
part 'customer_provider.g.dart';

@Riverpod(keepAlive: true)
class CustomerState extends _$CustomerState {
  @override
  AppUser? build() {
    return null;
  }

  void updateState(AppUser? customer) {
    state = customer;
  }
}
