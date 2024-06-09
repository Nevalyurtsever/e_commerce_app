import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/models/user/user.dart';
import '../../../screens/warehousepersone_home_screen/providers/selected_salesresponsible_provider.dart';
import '../../../core/models/order/order.dart';
import '../../../core/repositories/firestore_repository.dart';
part 'orders_for_controller.g.dart';

@Riverpod(keepAlive: true)
class OrdersForControllers extends _$OrdersForControllers {
  @override
  List<OrderModel> build() {
    getAllPackagedOrders();
    return [];
  }

  Future<void> getOrders() async {
    AppUser? salesrosponsible = ref.read(selectedSalseresponsiblesProvider);
    state = await ref
        .read(firestoreRepositoryProvider)
        .getSalesresponsibleOrders(salesrosponsible?.uid, "packaged");
  }

  Future<void> getAllPackagedOrders() async {
    state = await ref
        .read(firestoreRepositoryProvider)
        .getAllOrdersByStatus("packaged");
  }

  Future<void> packageOrder(String orderId) async {
    return ref.read(firestoreRepositoryProvider).packageOrder(orderId);
  }

  Future<void> uploadOrderVideo(String orderId, String path) async {
    ref.read(firestoreRepositoryProvider).uploadOrderVideo(orderId, path);
  }
}
