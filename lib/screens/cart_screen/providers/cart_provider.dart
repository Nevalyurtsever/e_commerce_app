import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants.dart';
import '../../../core/global_providers/auth_state_provider.dart';
import '../../../core/global_providers/customer_provider.dart';
import '../../../core/global_providers/role_provider.dart';
import '../../../core/models/cart.dart';
import '../../../core/models/order/order.dart';
import '../../../core/models/order/order_item.dart';
import '../../../core/repositories/firestore_repository.dart';
import '../../orders_screen/providers/order_list_provider.dart';
import '../cart_screen.dart';

part 'cart_provider.g.dart';

@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  bool _bussy = false;
  @override
  List<CartModel> build() {
    getCart();
    return [];
  }

  getCart() async {
    if (ref.read(roleStateProvider) == Role.salesResponsible) {
      final customer = ref.read(customerStateProvider);

      if (customer != null) {
        state =
            await ref.read(firestoreRepositoryProvider).getCart(customer.uid);
      }
    } else {
      state = await ref
          .read(firestoreRepositoryProvider)
          .getCart(ref.read(authStateProvider)!.uid);
    }
  }

  Future<void> addToCart(String id, int quantity, BuildContext context) async {
    if (_bussy) return;
    _bussy = true;
    if (quantity == 0) quantity = 1;

    try {
      bool isAdded = false;
      int index = 0;
      // check add status of different users
      await getCart();

      for (int i = 0; i < state.length; i++) {
        if (state[i].productId == id) {
          isAdded = true;
          quantity = quantity + state[i].quantity;
          index = i;
        }
      }
      // for (CartModel item in state) {
      //   if (item.productId == id) {
      //     isAdded = true;
      //     quantity = quantity + item.quantity;
      //   }
      // }

      // if (isAdded) {
      //   showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog.adaptive(
      //       title: Text(
      //           context.localizations!.this_product_is_already_in_the_cart),
      //       actions: [
      //         ElevatedButton(
      //           onPressed: () => Navigator.pop(context),
      //           child: const Text('Ok'),
      //         )
      //       ],
      //     ),
      //   );

      //   return;
      // }
      Map<String, dynamic> cart = {"productId": id, "quantity": quantity};
      late String userId;

      if (ref.read(roleStateProvider) == Role.salesResponsible) {
        userId = ref.read(customerStateProvider)!.uid;
      } else {
        userId = ref.read(authStateProvider)!.uid;
      }
      if (isAdded) {
        await updateQuanttiy(index, quantity);
      } else {
        await ref.read(firestoreRepositoryProvider).addToCart(userId, cart);
      }
      getCart();
      ref.read(ordersProvider.notifier).getOrders();

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: Text(context.localizations!.product_added_to_cart),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              ),
              TextButton(
                onPressed: () => context.go(CartScreen.routeName),
                child: Text(context.localizations!.go_to_cart),
              ),
            ],
          ),
        );
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
    _bussy = false;
  }

  Future<void> increaseQuanttiy(int index, bool increase) async {
    if (_bussy) return;
    _bussy = true;

    late String userId;
    CartModel item = state[index];
    late int quantity;

    if (ref.read(roleStateProvider) == Role.salesResponsible) {
      userId = ref.read(customerStateProvider)!.uid;
    } else {
      userId = ref.read(authStateProvider)!.uid;
    }

    if (increase) {
      quantity = item.quantity + 1;
    } else {
      quantity = item.quantity - 1;
    }
    if (quantity <= 0) {
      await ref
          .read(firestoreRepositoryProvider)
          .removeCartItem(userId, item.id);
      List<CartModel> items = state;
      items.removeAt(index);
      state = [];
      state = items;
    } else {
      await ref
          .read(firestoreRepositoryProvider)
          .increaseCartItemAmount(userId, item.id, quantity);

      List<CartModel> items = state;
      items[index] = item.copyWith(quantity: quantity);
      state = [];
      state = items;
    }

    _bussy = false;
  }

  String getTotalAmount(String locale) {
    double totalAmount = 0;

    for (CartModel item in state) {
      totalAmount = totalAmount + (item.product!.boxPrice * item.quantity);
    }

    return Constants.currencyFormat(locale, totalAmount);
  }

  getDiscountAmount(String localeName) {
    double discountAmount = 0;

    for (CartModel item in state) {
      if (item.product?.discountedPrice != null) {
        discountAmount = discountAmount +
            (item.product!.boxPrice * item.quantity) -
            (item.product!.discountedPrice! * item.quantity);
      }
    }

    return Constants.currencyFormat(localeName, discountAmount);
  }

  double getOrderAmount() {
    double orderAmount = 0;

    for (CartModel item in state) {
      if (item.product?.discountedPrice != null) {
        orderAmount =
            orderAmount + (item.product!.discountedPrice! * item.quantity);
      } else {
        orderAmount = orderAmount + (item.product!.boxPrice * item.quantity);
      }
    }

    return orderAmount;
  }

  double getTaxAmount() {
    double taxAmount = 0;

    for (CartModel item in state) {
      if (item.product?.tax != null) {
        if (item.product?.discountedPrice != null) {
          taxAmount = taxAmount +
              (item.product!.discountedPrice! *
                  item.product!.tax /
                  100 *
                  item.quantity);
        } else {
          taxAmount = taxAmount +
              (item.product!.boxPrice *
                  item.product!.tax /
                  100 *
                  item.quantity);
        }
      }
    }
    return taxAmount;
  }

  Future<bool> placeOrder(String note) async {
    if (_bussy) return false;
    _bussy = true;
    try {
      String uid;

      if (ref.read(roleStateProvider) == Role.salesResponsible) {
        uid = ref.read(customerStateProvider)!.uid;
      } else {
        uid = ref.read(authStateProvider)!.uid;
      }

      List<OrderItem> items = [];
      double totalPrice = 0;

      for (CartModel item in state) {
        late double productPrice;

        if (item.product?.discountedPrice != null) {
          productPrice = item.product!.discountedPrice!;
        } else {
          productPrice = item.product!.boxPrice;
        }

        totalPrice = totalPrice + (productPrice * item.quantity);

        items.add(
          OrderItem(
              id: null,
              productId: item.productId,
              quantity: item.quantity,
              unitPrice: productPrice,
              status: 'pending'),
        );
      }

      OrderModel order = OrderModel(
          id: null,
          orderedBy: uid,
          items: items,
          orderPrice: totalPrice,
          status: OrderStatus.pending,
          note: note,
          date: DateTime.now(),
          orderer: null,
          videoUrl: null,
          orderId: null);
      await ref.read(firestoreRepositoryProvider).placeOrder(order);
      state = [];
      _bussy = false;
      return true;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      _bussy = false;
      return false;
    }
  }

  void removeItem(int index) async {
    late String userId;

    if (ref.read(roleStateProvider) == Role.salesResponsible) {
      userId = ref.read(customerStateProvider)!.uid;
    } else {
      userId = ref.read(authStateProvider)!.uid;
    }
    await ref
        .read(firestoreRepositoryProvider)
        .removeCartItem(userId, state[index].id);
    List<CartModel> items = state;
    items.removeAt(index);
    state = [];
    state = items;
  }

  Future<void> updateQuanttiy(int index, int quantity) async {
    late String userId;
    CartModel item = state[index];

    if (ref.read(roleStateProvider) == Role.salesResponsible) {
      userId = ref.read(customerStateProvider)!.uid;
    } else {
      userId = ref.read(authStateProvider)!.uid;
    }

    await ref
        .read(firestoreRepositoryProvider)
        .increaseCartItemAmount(userId, item.id, quantity);

    List<CartModel> items = state;
    items[index] = item.copyWith(quantity: quantity);
    state = [];
    state = items;
  }

  int getQuantity(String? id) {
    int quantity = 1;

    for (CartModel item in state) {
      if (item.productId == id) {
        quantity = item.quantity;
      }
    }
    return quantity;
  }
}
