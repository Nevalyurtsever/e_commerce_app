import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/warehousepersone_home_screen/providers/selected_salesresponsible_provider.dart';
import '../../core/constants.dart';
import '../../core/models/order/order.dart';
import '../../core/models/user/user.dart';
import '../warehousepersone_home_screen/providers/salesresponsible_provider.dart';
import 'providers/ready_orders_provider.dart';

class ReadyOrdersScreen extends ConsumerWidget {
  static const String routeName = "/ready-orders";

  const ReadyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<OrderModel> readyOrders = ref.watch(readyOrdersProvider);
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
                  ref.read(readyOrdersProvider.notifier).getReadyOrders();
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
                    ref.read(readyOrdersProvider.notifier).setDate(date);
                  }
                },
                child: Text(ref.read(readyOrdersProvider.notifier).date == null
                    ? "Select a date"
                    : Constants.dateFormat(context.localizations!.localeName,
                        ref.read(readyOrdersProvider.notifier).date!)),
              ),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: readyOrders.length,
                itemBuilder: (context, index) {
                  OrderModel order = readyOrders[index];
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
