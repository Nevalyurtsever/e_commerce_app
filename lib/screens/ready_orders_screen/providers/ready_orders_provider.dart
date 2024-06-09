import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../screens/warehousepersone_home_screen/providers/selected_salesresponsible_provider.dart';
import '../../../core/models/order/order.dart';
import '../../../core/models/user/user.dart';
import '../../../core/repositories/firestore_repository.dart';
part 'ready_orders_provider.g.dart';

@Riverpod(keepAlive: true)
class ReadyOrders extends _$ReadyOrders {
  DateTime? _selectedDate;
  @override
  List<OrderModel> build() {
    return [];
  }

  Future<void> getReadyOrders() async {
    AppUser? salesrosponsible = ref.read(selectedSalseresponsiblesProvider);

    if (_selectedDate == null) return;
    if (salesrosponsible == null) return;
    state = await ref
        .read(firestoreRepositoryProvider)
        .getOrdersByStatus(salesrosponsible.uid, _selectedDate!, "packaged");
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    getReadyOrders();
  }

  DateTime? get date => _selectedDate;
}
