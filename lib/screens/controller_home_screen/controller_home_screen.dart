import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/models/order/order.dart';
import '../../core/models/user/user.dart';
import '../order_details_screen/order_details_warepersone_screen.dart';
import '../warehousepersone_home_screen/providers/salesresponsible_provider.dart';
import 'providers/orders_for_controller.dart';
import 'providers/selected_salesresponsible_provider.dart';

class ControllerHomeScreen extends ConsumerWidget {
  const ControllerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
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

                    ref.read(ordersForControllersProvider.notifier).getOrders();
                  },
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      ref
                          .watch(selectedSalseresponsiblesProvider.notifier)
                          .setState(null);

                      ref
                          .read(ordersForControllersProvider.notifier)
                          .getAllPackagedOrders();
                    },
                    child: Text(context.localizations!.see_all),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                AppUser? salesrosponsible =
                    ref.read(selectedSalseresponsiblesProvider);

                if (salesrosponsible == null) {
                  ref
                      .read(ordersForControllersProvider.notifier)
                      .getAllPackagedOrders();
                } else {
                  ref.read(ordersForControllersProvider.notifier).getOrders();
                }
              },
              child: ListView.builder(
                itemCount: ref.watch(ordersForControllersProvider).length,
                itemBuilder: (context, index) {
                  OrderModel order =
                      ref.read(ordersForControllersProvider)[index];
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
                            Text("id: ${order.id}"),
                            Text(
                                "${Constants.dateTimeFormat(context.localizations!.localeName, order.date!)}"),
                          ],
                        ),
                        Text(
                            "${context.localizations!.customers}: ${order.orderer?.createFullName()}"),
                        Text(
                            "${context.localizations!.quantity}: ${calculateQuantity(order)}"),
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
