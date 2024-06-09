import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../order_details_screen/order_details_screen.dart';
import '../../orders_screen/providers/order_list_provider.dart';

class OrderNotesWidget extends ConsumerWidget {
  const OrderNotesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return ListView.separated(
        itemCount: orders.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(orders[index].note),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context
                .push("${OrderDetailsScreen.routeName}/${orders[index].id}"),
          );
        });
  }
}
