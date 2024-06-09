import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/cart.dart';
import '../models/order/order.dart';
import '../models/order/order_item.dart';
import '../models/product.dart';
import '../models/reminder.dart';
import '../models/user/user.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/realtime_db_service.dart';
import '../services/storage_service.dart';

part 'firestore_repository.g.dart';

class FirestoreRepository {
  final Ref ref;
  FirestoreRepository(this.ref);

  Future<List<Reminder>> getReminders(String uid, String marketId) async {
    return ref.read(firestoreServiceProvider).getReminders(uid, marketId);
  }

  Future<void> addNewReminder(Reminder reminder, String uid) async {
    return await ref
        .read(firestoreServiceProvider)
        .addNewReminder(reminder, uid);
  }

//////////////////////////////// -PRODUCT API- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  Future<List<Product>> getOnSaleProducts() async {
    return ref.read(firestoreServiceProvider).getOnSaleProducts();
  }

  Future<List<Product>> getNewArrivals(Product? lastProduct) async {
    return ref.read(firestoreServiceProvider).getNewArrivals(lastProduct);
  }

  Future<Product?> getProduct(String productId) async {
    return await ref.read(firestoreServiceProvider).getProduct(productId);
  }

  Future<List<AppUser>> getCustomers(String uid) async {
    return ref.read(firestoreServiceProvider).getCustomers(uid);
  }

  Future<List<Product>> getFavorites(String uid) async {
    List<Product> products = [];
    List<String> favorites =
        await ref.read(realtimeDbServiceServiceProvider).getFavorites(uid);

    for (String favorite in favorites) {
      Product? product =
          await ref.read(firestoreServiceProvider).getProduct(favorite);
      if (product != null) {
        products.add(product);
      }
    }
    return products;
  }

  Future<void> favorite(List<String> productIds, String uid) async {
    await ref.read(realtimeDbServiceServiceProvider).favorite(productIds, uid);
  }

//////////////////////////////// -CART API- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  Future<void> addToCart(String userId, Map<String, dynamic> cart) async {
    return ref.read(firestoreServiceProvider).addToCart(userId, cart);
  }

  Future<List<CartModel>> getCart(String uid) async {
    List<CartModel> items =
        await ref.read(firestoreServiceProvider).getCart(uid);

    for (CartModel item in items) {
      item.product =
          await ref.read(firestoreServiceProvider).getProduct(item.productId);
    }
    items.sort(
        (a, b) => a.product!.productCode!.compareTo(b.product!.productCode!));
    return items;
  }

  Future<void> increaseCartItemAmount(
      String uid, String? id, int quantity) async {
    return await ref
        .read(firestoreServiceProvider)
        .increaseCartItemAmount(uid, id, quantity);
  }

  Future<void> removeCartItem(String uid, String? id) async {
    return await ref.read(firestoreServiceProvider).removeCartItem(uid, id);
  }

  Future<void> placeOrder(OrderModel order) async {
    await ref.read(firestoreServiceProvider).placeOrder(order);
    await ref.read(firestoreServiceProvider).clearCart(order.orderedBy);

    for (OrderItem item in order.items!) {
      await ref
          .read(firestoreServiceProvider)
          .updateBestSellerAmount(item.productId, item.quantity);
    }
  }

  Future<List<OrderModel>> getOrders(String uid, List<String> statuses) async {
    return await ref.read(firestoreServiceProvider).getOrders(uid, statuses);
  }

  Future<OrderModel?> getOrderDetails(String orderId) async {
    OrderModel? model =
        await ref.read(firestoreServiceProvider).getOrder(orderId);
    if (model != null) {
      model.orderer =
          await ref.read(firestoreServiceProvider).getUser(model.orderedBy);

      if (model.items != null) {
        for (OrderItem item in model.items!) {
          item.product = await ref
              .read(firestoreServiceProvider)
              .getProduct(item.productId);
        }

        model.items?.sort((a, b) =>
            a.product!.productCode!.compareTo(b.product!.productCode!));
      }

      return model;
    } else {
      return null;
    }
  }

  Future<List<AppUser>> getSalesresponsibles() async {
    return ref.read(firestoreServiceProvider).getSalesresponsibles();
  }

  Future<List<OrderModel>> getSalesresponsibleOrders(
      String? uid, String status) async {
    List<String> uids = [];
    List<AppUser> markets = [];
    if (uid != null) {
      markets = await ref.read(firestoreServiceProvider).getCustomers(uid);

      for (AppUser market in markets) {
        uids.add(market.uid);
      }
    }

    if (uids.isEmpty) return [];

    List<OrderModel> orders = await ref
        .read(firestoreServiceProvider)
        .getOrdersWithOrdererList(uids, status);

    for (OrderModel order in orders) {
      for (AppUser orderer in markets) {
        if (order.orderedBy == orderer.uid) {
          order.orderer = orderer;
        }
      }
    }

    orders.sort((a, b) => b.date!.compareTo(a.date!));
    return orders;
  }

  Future<List<OrderModel>> getAllOrdersByStatus(String status) async {
    List<String> marketIds = [];
    List<OrderModel> orders =
        await ref.read(firestoreServiceProvider).getAllOrdersByStatus(status);

    for (OrderModel order in orders) {
      marketIds.add(order.orderedBy);
    }

    if (marketIds.isNotEmpty) {
      List<AppUser> markets =
          await ref.read(firestoreServiceProvider).getUsers(marketIds);

      for (OrderModel order in orders) {
        for (AppUser orderer in markets) {
          if (order.orderedBy == orderer.uid) {
            order.orderer = orderer;
          }
        }
      }
    }

    return orders;
  }

  Future<void> packageOrderItem(
      String? id, String? itemId, String status) async {
    return ref
        .read(firestoreServiceProvider)
        .packageOrderItem(id, itemId, status);
  }

  Future<void> packageOrder(String orderId) async {
    return ref.read(firestoreServiceProvider).packageOrder(orderId);
  }

  Future<void> uploadOrderVideo(String orderId, String path) async {
    String? url =
        await ref.read(storageServiceProvider).uploadOrderVideo(orderId, path);

    if (url != null) {
      await ref.read(firestoreServiceProvider).putOrderVideo(orderId, url);
    }
  }

  Future<void> shipOrder(String orderId) async {
    return ref.read(firestoreServiceProvider).shipOrder(orderId);
  }

  Future<AppUser?> getUser(String uid) async {
    return await ref.read(firestoreServiceProvider).getUser(uid);
  }

  Future<void> updateUser(AppUser newUser) async {
    await ref
        .read(authServiceProvider)
        .updateUserName(newUser.createFullName());
    await ref.read(firestoreServiceProvider).updateUser(newUser);
  }

  Future<void> deleteReminder(String uid, String reminderId) async {
    return ref.read(firestoreServiceProvider).deleteReminder(uid, reminderId);
  }

  Future<void> removeVideo(String orderId, String videoUrl) async {
    await ref.read(firestoreServiceProvider).removeOrderVideo(orderId);
    await ref.read(storageServiceProvider).removeOrderVideo(videoUrl);
  }

  Future<List<OrderModel>> getOrdersByStatus(
      String? uid, DateTime selectedDate, String status) async {
    List<String> uids = [];
    List<AppUser> markets = [];
    if (uid != null) {
      markets = await ref.read(firestoreServiceProvider).getCustomers(uid);

      for (AppUser market in markets) {
        uids.add(market.uid);
      }
    }

    if (uids.isEmpty) return [];

    List<OrderModel> orders = await ref
        .read(firestoreServiceProvider)
        .getOrdersByStatus(uids, selectedDate, status);

    for (OrderModel order in orders) {
      for (AppUser orderer in markets) {
        if (order.orderedBy == orderer.uid) {
          order.orderer = orderer;
        }
      }
    }
    return orders;
  }

  Future<List<Product>> getProductsByCategoryList(
      List<String> categories, Product? lastProduct, String? orderBy) async {
    return await ref
        .read(firestoreServiceProvider)
        .getProductsByCategoryList(categories, lastProduct, orderBy);
  }

  Future<void> removeOrderItem(
      String? orderId, String? itemId, double newPrice) async {
    await ref
        .read(firestoreServiceProvider)
        .removeOrderItem(orderId, itemId, newPrice);
  }

  Future<void> updateOrderItemQuantity(String orderId, String? orderItemId,
      int quantity, double totalAmount) async {
    await ref
        .read(firestoreServiceProvider)
        .updateOrderItemQuantity(orderId, orderItemId, quantity, totalAmount);
  }

  Future<void> addOrderProductProduct(
      String orderId, OrderItem item, double newOrderPrice) async {
    await ref
        .read(firestoreServiceProvider)
        .addOrderProductProduct(orderId, item, newOrderPrice);
  }

  Future<List<Product>> getBestSellers(
      Product? lastProduct, bool descending) async {
    return ref
        .read(firestoreServiceProvider)
        .getBestSellers(lastProduct, descending);
  }
}

@riverpod
FirestoreRepository firestoreRepository(ref) {
  return FirestoreRepository(ref);
}
