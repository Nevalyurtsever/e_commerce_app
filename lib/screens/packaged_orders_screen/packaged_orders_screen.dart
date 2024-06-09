import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/packaged_orders_screen/providers/packaged_orders_provider.dart';
import '../../screens/warehousepersone_home_screen/providers/salesresponsible_provider.dart';
import '../../screens/warehousepersone_home_screen/providers/selected_salesresponsible_provider.dart';

import '../../core/constants.dart';
import '../../core/models/order/order.dart';
import '../../core/models/user/user.dart';

class PackagedOrdersScreen extends ConsumerWidget {
  static const String routeName = "/packaged-orders";

  const PackagedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<OrderModel> orders = ref.watch(packagedOrdersProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  ref.read(packagedOrdersProvider.notifier).getOrders();
                },
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 1000),
                    ),
                    lastDate: DateTime.now().add(
                      const Duration(days: 1000),
                    ),
                  );
                  if (date != null) {
                    ref.read(packagedOrdersProvider.notifier).setDate(date);
                  }
                },
                child: Text(
                    ref.read(packagedOrdersProvider.notifier).date == null
                        ? "Select a date"
                        : Constants.dateFormat(
                            context.localizations!.localeName,
                            ref.read(packagedOrdersProvider.notifier).date!)),
              ),
            ],
          ),
        ),
        Expanded(
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
                            Text("id: ${order.id}"),
                            Text(
                                "${Constants.dateTimeFormat(context.localizations!.localeName, order.date!)}"),
                          ],
                        ),
                        Text(
                            "${context.localizations!.customers}: ${order.orderer?.createFullName()}"),
                        Text(
                            "${context.localizations!.amount}: ${Constants.currencyFormat(context.localizations!.localeName, order.orderPrice!)}"),
                        Text("${context.localizations!.note}: ${order.note}"),
                      ],
                    ),
                  );
                }))
      ],
    );
  }
}
