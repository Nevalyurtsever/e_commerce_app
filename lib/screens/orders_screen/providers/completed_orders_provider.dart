import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/global_providers/auth_state_provider.dart';
import '../../../core/global_providers/customer_provider.dart';
import '../../../core/global_providers/role_provider.dart';
import '../../../core/models/order/order.dart';
import '../../../core/repositories/firestore_repository.dart';

part 'completed_orders_provider.g.dart';

@Riverpod(keepAlive: true)
class CompletedOrders extends _$CompletedOrders {
  @override
  List<OrderModel> build() {
    listenCustomer();

    state = [];
    return state;
  }

  listenCustomer() {
    if (ref.read(roleStateProvider) == Role.salesResponsible) {
      final customer = ref.read(customerStateProvider);

      if (customer != null) {
        getOrders(customer.uid);
      }

      ref.listen(customerStateProvider, (previous, next) {
        if (next != null) {
          getOrders(next.uid);
        } else {
          state = [];
        }
      });
    } else {
      getOrders(ref.read(authStateProvider)!.uid);
    }
  }

  Future<void> getOrders(String uid) async {
    state =
        await ref.read(firestoreRepositoryProvider).getOrders(uid, ["shipped"]);
  }
}
