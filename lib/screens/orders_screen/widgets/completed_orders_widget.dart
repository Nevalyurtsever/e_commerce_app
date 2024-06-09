import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/order/order.dart';
import '../providers/completed_orders_provider.dart';
import 'order_item_card.dart';

class CompletedOrdersWidget extends ConsumerWidget {
  const CompletedOrdersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(completedOrdersProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.separated(
          itemCount: orders.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            OrderModel order = orders[index];
            return OrderItemCard(order: order);
          },
        ),
      ),
    );
  }
}
