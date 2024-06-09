import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/models/order/order.dart';
import '../../order_details_screen/order_details_screen.dart';

class OrderItemCard extends StatelessWidget {
  final OrderModel order;
  const OrderItemCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push("${OrderDetailsScreen.routeName}/${order.id}"),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 93,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: findColorByStatus(order.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        order.statusToString(),
                        style: TextStyle(
                            color: findColorByStatus(order.status),
                            fontSize: 12),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: findColorByStatus(order.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Icon(
                      Icons.check_outlined,
                      color: findColorByStatus(order.status),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black45),
                    ),
                    child: Icon(
                      Icons.inventory_2,
                      color: order.status == OrderStatus.packaged ||
                              order.status == OrderStatus.shipped ||
                              order.status == OrderStatus.completed
                          ? const Color(0xffFFC62B)
                          : Colors.grey,
                      // findColorByStatus(order.status),
                      size: 18,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black45,
                      ),
                    ),
                    child: Icon(
                      Icons.local_shipping,
                      color: order.status == OrderStatus.shipped ||
                              order.status == OrderStatus.completed
                          ? const Color(0xff00AB67)
                          : Colors.grey,
                      // findColorByStatus(order.status),
                      size: 20,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black45,
                      ),
                    ),
                    child: Icon(
                      Icons.check_outlined,
                      color: order.status == OrderStatus.completed
                          ? const Color(0xff0067FF)
                          : Colors.grey,
                      // findColorByStatus(order.status),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text("Order ID",
                            style: context.theme.appTextTheme.contentMedium),
                        Center(
                          child: Text(
                            order.orderId.toString(),
                            style: const TextStyle(
                                fontFamily: "AirbnbCereal_W_Md", fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          context.localizations!.total,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Center(
                          child: Text(
                            Constants.currencyFormat(
                                context.localizations!.localeName,
                                order.orderPrice!),
                            style: const TextStyle(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Constants.dateTimeFormat(
                      context.localizations!.localeName, order.date!),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  order.note,
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color findColorByStatus(OrderStatus status) {
    Color color = const Color(0xffFF3B3B);

    switch (status) {
      case OrderStatus.pending:
        color = const Color.fromARGB(255, 239, 139, 139);
        break;
      case OrderStatus.packaged:
        color = const Color(0xffFF3B3B);
        break;
      case OrderStatus.checked:
        color = const Color(0xffFFC62B);
        break;
      case OrderStatus.shipped:
        color = const Color(0xff00AB67);
        break;
      case OrderStatus.completed:
        color = const Color(0xff0067FF);
        break;

      default:
        color = const Color(0xffFF3B3B);
    }
    return color;
  }
}
