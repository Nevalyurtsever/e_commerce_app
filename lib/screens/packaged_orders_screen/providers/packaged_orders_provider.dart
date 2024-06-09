import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/order/order.dart';
import '../../../core/models/user/user.dart';
import '../../../core/repositories/firestore_repository.dart';
import '../../warehousepersone_home_screen/providers/selected_salesresponsible_provider.dart';
part 'packaged_orders_provider.g.dart';

@Riverpod(keepAlive: true)
class PackagedOrders extends _$PackagedOrders {
  DateTime? _selectedDate;
  @override
  List<OrderModel> build() {
    return [];
  }

  Future<void> getOrders() async {
    AppUser? salesrosponsible = ref.read(selectedSalseresponsiblesProvider);

    if (_selectedDate == null) return;
    if (salesrosponsible == null) return;
    state = await ref
        .read(firestoreRepositoryProvider)
        .getOrdersByStatus(salesrosponsible.uid, _selectedDate!, "checked");
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    getOrders();
  }

  DateTime? get date => _selectedDate;
}
