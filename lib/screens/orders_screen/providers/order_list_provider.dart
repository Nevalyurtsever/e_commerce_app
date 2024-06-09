import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/global_providers/auth_state_provider.dart';
import '../../../core/global_providers/customer_provider.dart';
import '../../../core/global_providers/role_provider.dart';
import '../../../core/models/order/order.dart';
import '../../../core/repositories/firestore_repository.dart';

part 'order_list_provider.g.dart';

@Riverpod(keepAlive: true)
class Orders extends _$Orders {
  String? uid;
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
        uid = customer.uid;
        getOrders();
      }

      ref.listen(customerStateProvider, (previous, next) {
        if (next != null) {
          uid = next.uid;
          getOrders();
        } else {
          uid = null;
          state = [];
        }
      });
    } else {
      uid = ref.read(authStateProvider)!.uid;
      getOrders();
    }
  }

  Future<void> getOrders() async {
    if (uid == null) return;
    state = await ref
        .read(firestoreRepositoryProvider)
        .getOrders(uid!, ["pending", "packaged"]);
  }
}
