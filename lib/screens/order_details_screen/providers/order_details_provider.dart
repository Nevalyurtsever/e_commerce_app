import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/order/order.dart';
import '../../../core/repositories/firestore_repository.dart';

part 'order_details_provider.g.dart';

@riverpod
Future<OrderModel?> orderDetails(Ref ref, String id) {
  return ref.read(firestoreRepositoryProvider).getOrderDetails(id);
}
