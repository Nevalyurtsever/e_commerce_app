import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/order/order.dart';
import 'providers/order_list_provider.dart';
import 'widgets/completed_orders_widget.dart';
import 'widgets/order_item_card.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  static String routeName = "/orders";

  const OrdersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localizations!.order_history),
        ),
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(text: context.localizations!.pending),
              Tab(text: context.localizations!.completed)
            ]),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await ref.read(ordersProvider.notifier).getOrders();
                      },
                      child: ListView.separated(
                        itemCount: orders.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          OrderModel order = orders[index];
                          return OrderItemCard(order: order);
                        },
                      ),
                    ),
                  ),
                  const CompletedOrdersWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
