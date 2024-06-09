import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../screens/order_details_screen/order_details_warepersone_screen.dart';
import '../../screens/warehousepersone_home_screen/providers/selected_salesresponsible_provider.dart';

import '../../core/constants.dart';
import '../../core/models/order/order.dart';
import '../../core/models/user/user.dart';
import 'providers/salesresponsible_orders_provider.dart';
import 'providers/salesresponsible_provider.dart';

class WarehousePersonHomeScreen extends ConsumerWidget {
  const WarehousePersonHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isBussy = ref.watch(salseresponsibleOrdersProvider.notifier).isBussy;
    List<OrderModel> orders = ref.watch(salseresponsibleOrdersProvider);
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isBussy)
            const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          if (!isBussy)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<AppUser>(
                    hint: Text(context.localizations!.please_select_a_market),
                    value: ref.watch(selectedSalseresponsiblesProvider),
                    items: ref
                        .watch(salseresponsiblesProvider)
                        .map(
                          (e) => DropdownMenuItem<AppUser>(
                            value: e,
                            child: Text(e.createFullName()),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      ref
                          .watch(selectedSalseresponsiblesProvider.notifier)
                          .setState(v);

                      ref
                          .read(salseresponsibleOrdersProvider.notifier)
                          .getSalesresponsibles();
                    },
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        ref
                            .watch(selectedSalseresponsiblesProvider.notifier)
                            .setState(null);

                        ref
                            .read(salseresponsibleOrdersProvider.notifier)
                            .getAllOrders();
                      },
                      child: Text(context.localizations!.see_all),
                    ),
                  ),
                ],
              ),
            ),
          if (!isBussy)
            if (orders.isEmpty)
              Text(
                context.localizations!.no_order,
              ),
          if (!isBussy)
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await ref
                      .read(salseresponsibleOrdersProvider.notifier)
                      .getOrders();
                },
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    OrderModel order = orders[index];
                    return Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: context.theme.appColors.cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("id: ${order.orderId}"),
                              Text(
                                  "${Constants.dateTimeFormat(context.localizations!.localeName, order.date!)}"),
                            ],
                          ),
                          Text(
                              "${context.localizations!.customers}: ${order.orderer?.createFullName()}"),
                          Text(
                              "${context.localizations!.quantity}: ${calculateQuantity(order)}"),
                          Text(
                              "${context.localizations!.amount}: ${Constants.currencyFormat(context.localizations!.localeName, order.orderPrice!)}"),
                          Text("${context.localizations!.note}: ${order.note}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () => context.push(
                                      "${OrderDetailsWarePersonScreen.routeName}/${order.id}"),
                                  child: Text(context.localizations!.details)),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
        ],
      ),
    );
  }

  String calculateQuantity(OrderModel order) {
    int quantity = 0;

    for (var item in order.items!) {
      quantity = quantity + item.quantity;
    }

    return quantity.toString();
  }
}
