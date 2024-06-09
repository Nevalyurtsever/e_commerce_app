import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/global_providers/auth_state_provider.dart';
import '../../../core/models/user/user.dart';
import '../../../core/repositories/firestore_repository.dart';

part 'customers_provider.g.dart';

@Riverpod(keepAlive: true)
class Customers extends _$Customers {
  late List<AppUser> customers;
  @override
  List<AppUser> build() {
    customers = [];
    state = [];
    getCustomers();
    return state;
  }

  Future<void> getCustomers() async {
    state = await ref
        .read(firestoreRepositoryProvider)
        .getCustomers(ref.read(authStateProvider)!.uid);
    customers = state;
  }

  void search(String v) {
    state = [];
    for (AppUser customer in customers) {
      if (customer.createFullName().toLowerCase().contains(v.toLowerCase())) {
        state = [...state, customer];
      }
    }
  }
}
