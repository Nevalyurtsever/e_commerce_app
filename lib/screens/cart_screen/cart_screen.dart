import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/global_providers/auth_state_provider.dart';
import '../../core/global_providers/customer_provider.dart';
import '../../core/global_providers/role_provider.dart';
import '../../core/models/cart.dart';
import '../order_success_screen.dart';
import '../orders_screen/providers/order_list_provider.dart';
import 'providers/cart_provider.dart';
import 'widgets/cart_item_card.dart';

class CartScreen extends ConsumerStatefulWidget {
  static const String routeName = "/cart";

  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  String note = '';
  bool _bussy = false;
  @override
  Widget build(BuildContext context) {
    List<CartModel> items = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations!.cart),
      ),
      body: _bussy
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (contex, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return CartItemCard(
                            item: items[index],
                            index: index,
                          );
                          // return ListTile(
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(12),
                          //   ),
                          //   leading: CircleAvatar(
                          //     backgroundImage: CachedNetworkImageProvider(
                          //         items[index].product!.imageUrl),
                          //   ),
                          //   title: Text(items[index].product!.name),
                          //   subtitle: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       if (items[index].product?.discountedPrice != null)
                          //         Text(
                          //           findUndiscountPrice(items[index],
                          //               context.localizations!.localeName),
                          //           style:
                          //               context.theme.textTheme.labelSmall!.copyWith(
                          //             decoration: TextDecoration.lineThrough,
                          //           ),
                          //         ),
                          //       if (items[index].product?.discountedPrice != null)
                          //         const SizedBox(width: 10),
                          //       Text(
                          //           findItemPrice(items[index],
                          //               context.localizations!.localeName),
                          //           style: context.theme.textTheme.displayMedium!),
                          //     ],
                          //   ),
                          //   trailing: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       IconButton(
                          //         onPressed: () {
                          //           ref
                          //               .read(cartProvider.notifier)
                          //               .increaseQuanttiy(index, false);
                          //         },
                          //         icon: Icon(items[index].quantity == 1
                          //             ? Icons.delete_forever
                          //             : Icons.remove),
                          //       ),
                          //       CircleAvatar(
                          //         child: Text(
                          //           items[index].quantity.toString(),
                          //         ),
                          //       ),
                          //       IconButton(
                          //         onPressed: () {
                          //           ref
                          //               .read(cartProvider.notifier)
                          //               .increaseQuanttiy(index, true);
                          //         },
                          //         icon: const Icon(Icons.add),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        }),
                  ),
                  TextField(
                    onChanged: (value) => note = value,
                    decoration: InputDecoration(
                        labelText: context.localizations!.description),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
      bottomSheet: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: '${context.localizations!.total}: ',
                      children: [
                        TextSpan(
                          text: ref.read(cartProvider.notifier).getTotalAmount(
                              context.localizations!.localeName),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: '${context.localizations!.discount}: ',
                      children: [
                        TextSpan(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          text: ref
                              .read(cartProvider.notifier)
                              .getDiscountAmount(
                                  context.localizations!.localeName),
                        )
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: '${context.localizations!.tax}: ',
                      children: [
                        TextSpan(
                          text: Constants.currencyFormat(
                            context.localizations!.localeName,
                            ref.read(cartProvider.notifier).getTaxAmount(),
                          ),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                    child: Divider(),
                  ),
                  Text.rich(
                    TextSpan(
                      text: '${context.localizations!.order_amount}: ',
                      children: [
                        TextSpan(
                          text: Constants.currencyFormat(
                            context.localizations!.localeName,
                            ref.read(cartProvider.notifier).getOrderAmount(),
                          ),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: items.isEmpty || _bussy
                    ? null
                    : () async {
                        bool send = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog.adaptive(
                            title: Text(context.localizations!.place_order),
                            content: Text(context
                                .localizations!.are_you_sure_you_want_to_order),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(context.localizations!.cancel),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child:
                                    Text(context.localizations!.continue_key),
                              ),
                            ],
                          ),
                        );

                        if (send) {
                          setState(() {
                            _bussy = true;
                          });
                          bool result = await ref
                              .read(cartProvider.notifier)
                              .placeOrder(note);

                          setState(() {
                            _bussy = true;
                          });

                          if (result && context.mounted) {
                            late String? uid;

                            if (ref.read(roleStateProvider) ==
                                Role.salesResponsible) {
                              final customer = ref.read(customerStateProvider);

                              if (customer != null) {
                                uid = customer.uid;
                              }
                            } else {
                              uid = ref.read(authStateProvider)!.uid;
                            }
                            if (uid != null) {
                              ref.read(ordersProvider.notifier).getOrders();
                            }

                            context.go(OrderSuccessScreen.routeName);
                          }
                        }
                      },
                child: Text(context.localizations!.continue_key),
              )
            ],
          ),
        ),
      ),
    );
  }

  String findItemPrice(CartModel item, String locale) {
    double amount = 0;

    if (item.product?.discountedPrice != null) {
      amount = item.product!.discountedPrice! * item.quantity;
    } else {
      amount = item.product!.price * item.quantity;
    }
    return Constants.currencyFormat(locale, amount);
  }
}
