import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/cart.dart';
import '../models/order/order.dart';
import '../models/order/order_item.dart';
import '../models/product.dart';
import '../models/reminder.dart';
import '../models/user/user.dart';

part 'firestore_service.g.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;
  DocumentSnapshot? _lastBestSellerDoc;

  Future<List<Reminder>> getReminders(String uid, String marketId) async {
    List<Reminder> reminders = [];

    QuerySnapshot<Reminder> snap = await db
        .collection('users')
        .doc(uid)
        .collection('reminders')
        .where('market', isEqualTo: marketId)
        .orderBy('date')
        .withConverter<Reminder>(
          fromFirestore: (product, _) => Reminder.fromJson(product.data()!),
          toFirestore: (product, _) => product.toJson(),
        )
        .get();

    for (var product in snap.docs) {
      reminders.add(product.data());
    }

    return reminders;
  }

  Future<void> addNewReminder(Reminder reminder, String uid) async {
    DocumentReference<Reminder> ref = await db
        .collection('users')
        .doc(uid)
        .collection('reminders')
        .withConverter<Reminder>(
          fromFirestore: (reminder, _) => Reminder.fromJson(reminder.data()!),
          toFirestore: (reminder, _) => reminder.toJson(),
        )
        .add(reminder);

    await db
        .collection('users')
        .doc(uid)
        .collection('reminders')
        .doc(ref.id)
        .update({"id": ref.id});
  }

  Future<void> deleteReminder(String uid, String reminderId) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('reminders')
        .doc(reminderId)
        .delete();
  }

  //////////////////////////////// -PRODUCT API- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  Future<List<Product>> getOnSaleProducts() async {
    List<Product> products = [];

    QuerySnapshot<Product> snap = await db
        .collection('products')
        .where('status', isEqualTo: 'published')
        .where('discountedPrice', isNull: false)
        .orderBy("discountedPrice")
        .orderBy("productCode")
        .limit(20)
        .withConverter<Product>(
          fromFirestore: (product, _) => Product.fromJson(product.data()!),
          toFirestore: (product, _) => product.toJson(),
        )
        .get();

    for (var product in snap.docs) {
      Product prd = product.data();
      prd.id = product.id;
      products.add(prd);
    }

    return products;
  }

  Future<List<Product>> getNewArrivals(Product? lastProduct) async {
    List<Product> products = [];

    QuerySnapshot<Product> snap = await db
        .collection('products')
        .where('status', isEqualTo: 'published')
        .orderBy("createdAt", descending: true)
        // .startAfter([lastProduct])
        .limit(20)
        .withConverter<Product>(
          fromFirestore: (product, _) => Product.fromJson(product.data()!),
          toFirestore: (product, _) => product.toJson(),
        )
        .get();

    for (var product in snap.docs) {
      Product prd = product.data();
      prd.id = product.id;
      products.add(prd);
    }

    return products;
  }

  Future<Product?> getProduct(String productId) async {
    DocumentSnapshot<Product> snap = await db
        .collection('products')
        .doc(productId)
        .withConverter<Product>(
          fromFirestore: (product, _) => Product.fromJson(product.data()!),
          toFirestore: (product, _) => product.toJson(),
        )
        .get();

    Product? product = snap.data();
    Product? productWithId = product?.copyWith(id: snap.id);
    return productWithId;
  }
  ///////////////////////////////// -USER API- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  Future<List<AppUser>> getCustomers(String uid) async {
    List<AppUser> customers = [];
    QuerySnapshot<AppUser> query = await db
        .collection('users')
        .where('customerRepresentative', isEqualTo: uid)
        .withConverter<AppUser>(
          fromFirestore: (user, _) => AppUser.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();

    for (var user in query.docs) {
      customers.add(user.data());
    }
    return customers;
  }

  Future<AppUser?> getUser(String uid) async {
    DocumentSnapshot<AppUser> doc = await db
        .collection('users')
        .doc(uid)
        .withConverter<AppUser>(
          fromFirestore: (user, _) => AppUser.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();

    return doc.data();
  }

  Future<void> updateUser(AppUser newUser) async {
    await db.collection("users").doc(newUser.uid).update(newUser.toJson());
  }

  Future<void> updateProfilePhoto(String uid, String url) async {
    await db.collection("users").doc(uid).update({"photoURL": url});
  }

  //////////////////////////////// -CART API- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  Future<void> addToCart(String userId, Map<String, dynamic> cart) async {
    await db.collection('users').doc(userId).collection('cart').add(cart);
  }

  Future<List<CartModel>> getCart(String uid) async {
    List<CartModel> cart = [];
    QuerySnapshot<CartModel> query = await db
        .collection('users')
        .doc(uid)
        .collection('cart')
        .withConverter<CartModel>(
          fromFirestore: (user, _) => CartModel.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();

    for (var item in query.docs) {
      CartModel model = item.data();
      model.id = item.id;
      cart.add(model);
    }

    return cart;
  }

  Future<void> increaseCartItemAmount(
      String uid, String? id, int quantity) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(id)
        .withConverter<CartModel>(
          fromFirestore: (user, _) => CartModel.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .update({"quantity": quantity});
  }

  Future<void> removeCartItem(String uid, String? id) async {
    await db.collection('users').doc(uid).collection('cart').doc(id).delete();
  }

  Future<void> clearCart(String userId) async {
    QuerySnapshot query =
        await db.collection('users').doc(userId).collection('cart').get();

    for (var item in query.docs) {
      await item.reference.delete();
    }
  }

  //////////////////////////////// -ORDER API- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  Future<int> getLastOrderId() async {
    QuerySnapshot<OrderModel> query = await db
        .collection('orders')
        .orderBy('orderId', descending: true)
        .limit(1)
        .withConverter<OrderModel>(
          fromFirestore: (user, _) => OrderModel.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();

    if (query.docs.isNotEmpty) {
      return query.docs.first.data().orderId!;
    } else {
      return 0;
    }
  }

  Future<void> placeOrder(OrderModel order) async {
    List<Map<String, dynamic>> items = [];

    if (order.items != null) {
      for (OrderItem item in order.items!) {
        items.add(item.toJson());
      }
    }

    int lastOrderId = await getLastOrderId();

    DocumentReference ref = await db.collection('orders').add({
      "orderPrice": order.orderPrice,
      "orderedBy": order.orderedBy,
      // "items": items,
      "status": "pending",
      "note": order.note,
      "date": order.date,
      "orderId": lastOrderId + 1
    });

    for (Map<String, dynamic> item in items) {
      await db.collection("orders").doc(ref.id).collection('items').add(item);
    }
  }

  Future<void> removeOrderItem(
      String? orderId, String? itemId, double newPrice) async {
    await db
        .collection('orders')
        .doc(orderId)
        .collection('items')
        .doc(itemId)
        .delete();

    await db.collection('orders').doc(orderId).update({"orderPrice": newPrice});
  }

  Future<void> updateOrderItemQuantity(String orderId, String? orderItemId,
      int quantity, double totalAmount) async {
    await db
        .collection('orders')
        .doc(orderId)
        .update({"orderPrice": totalAmount});

    await db
        .collection('orders')
        .doc(orderId)
        .collection('items')
        .doc(orderItemId)
        .update({"quantity": quantity});
  }

  Future<void> addOrderProductProduct(
      String orderId, OrderItem item, double newOrderPrice) async {
    await db
        .collection('orders')
        .doc(orderId)
        .collection('items')
        .add(item.toJson());

    await db
        .collection('orders')
        .doc(orderId)
        .update({"orderPrice": newOrderPrice});
  }

  Future<List<OrderModel>> getOrders(String uid, List<String> statuses) async {
    List<OrderModel> orders = [];

    QuerySnapshot<OrderModel> query = await db
        .collection('orders')
        .where('orderedBy', isEqualTo: uid)
        .where("status", whereIn: statuses)
        .orderBy('date', descending: true)
        .withConverter<OrderModel>(
          fromFirestore: (user, _) => OrderModel.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();

    for (var item in query.docs) {
      OrderModel model = item.data();
      model.id = item.id;
      orders.add(model);
    }

    return orders;
  }

  Future<List<OrderModel>> getAllOrdersByStatus(String status) async {
    List<OrderModel> orders = [];

    QuerySnapshot<OrderModel> query = await db
        .collection('orders')
        .where("status", isEqualTo: status)
        .orderBy("date", descending: true)
        .withConverter<OrderModel>(
          fromFirestore: (user, _) => OrderModel.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();

    for (var order in query.docs) {
      OrderModel model = order.data();
      List<OrderItem> orderItemList = [];
      model.id = order.id;
      QuerySnapshot<OrderItem>? orderItems = await db
          .collection('orders')
          .doc(order.id)
          .collection('items')
          .withConverter<OrderItem>(
            fromFirestore: (user, _) => OrderItem.fromJson(user.data()!),
            toFirestore: (user, _) => user.toJson(),
          )
          .get();

      for (var item in orderItems.docs) {
        orderItemList.add(item.data());
      }
      model.items = orderItemList;
      orders.add(model);
    }

    return orders;
  }

  Future<OrderModel?> getOrder(String orderId) async {
    DocumentSnapshot<OrderModel> query = await db
        .collection('orders')
        .doc(orderId)
        .withConverter<OrderModel>(
          fromFirestore: (user, _) => OrderModel.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();

    OrderModel? order = query.data();

    order?.id = query.id;

    if (order != null) {
      QuerySnapshot<OrderItem> itemsQuery = await db
          .collection('orders')
          .doc(orderId)
          .collection('items')
          .withConverter<OrderItem>(
            fromFirestore: (user, _) => OrderItem.fromJson(user.data()!),
            toFirestore: (user, _) => user.toJson(),
          )
          .get();

      List<OrderItem> items = [];
      for (var item in itemsQuery.docs) {
        OrderItem itm = item.data();
        itm.id = item.id;
        items.add(itm);
      }
      order.items = items;
    }

    return order;
  }

  Future<List<AppUser>> getSalesresponsibles() async {
    List<AppUser> salesresponsibles = [];
    QuerySnapshot<AppUser> query = await db
        .collection('users')
        .where('role', isEqualTo: "SALESRESPONSIBLE")
        .withConverter<AppUser>(
          fromFirestore: (user, _) => AppUser.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();

    for (var user in query.docs) {
      salesresponsibles.add(user.data());
    }
    return salesresponsibles;
  }

  Future<List<OrderModel>> getOrdersWithOrdererList(
      List<String> uids, String status) async {
    List<OrderModel> orders = [];

    List<List<String>> chunks = _generateChunks(uids, 30);

    for (List<String> chunk in chunks) {
      QuerySnapshot<OrderModel> query = await db
          .collection('orders')
          .where("status", isEqualTo: status)
          .where('orderedBy', whereIn: chunk)
          .withConverter<OrderModel>(
            fromFirestore: (user, _) => OrderModel.fromJson(user.data()!),
            toFirestore: (user, _) => user.toJson(),
          )
          .get();

      for (var order in query.docs) {
        OrderModel model = order.data();
        List<OrderItem> orderItemList = [];
        model.id = order.id;
        QuerySnapshot<OrderItem>? orderItems = await db
            .collection('orders')
            .doc(order.id)
            .collection('items')
            .withConverter<OrderItem>(
              fromFirestore: (user, _) => OrderItem.fromJson(user.data()!),
              toFirestore: (user, _) => user.toJson(),
            )
            .get();

        for (var item in orderItems.docs) {
          orderItemList.add(item.data());
        }
        model.items = orderItemList;
        orders.add(model);
      }
    }

    return orders;
  }

  Future<void> packageOrderItem(
      String? id, String? itemId, String status) async {
    await db
        .collection('orders')
        .doc(id)
        .collection('items')
        .doc(itemId)
        .update({'status': status});
  }

  Future<void> packageOrder(String orderId) async {
    await db.collection('orders').doc(orderId).update({'status': "packaged"});
  }

  Future<void> putOrderVideo(String orderId, String url) async {
    await db.collection('orders').doc(orderId).update({'videoUrl': url});
  }

  Future<void> shipOrder(String orderId) async {
    await db.collection('orders').doc(orderId).update({'status': "shipped"});
  }

  Future<void> removeOrderVideo(String orderId) async {
    await db.collection('orders').doc(orderId).update({'videoUrl': null});
  }

  Future<List<OrderModel>> getOrdersByStatus(
      List<String> uids, DateTime selectedDate, String status) async {
    List<OrderModel> orders = [];

    DateTime startDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    DateTime endDate = startDate.add(const Duration(days: 1));

    QuerySnapshot<OrderModel> query = await db
        .collection('orders')
        .where('orderedBy', whereIn: uids)
        .where("status", isEqualTo: status)
        .where("date",
            isLessThanOrEqualTo: Timestamp.fromDate(endDate),
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .orderBy('date', descending: true)
        .withConverter<OrderModel>(
          fromFirestore: (user, _) => OrderModel.fromJson(user.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();

    for (var item in query.docs) {
      OrderModel model = item.data();
      model.id = item.id;
      orders.add(model);
    }

    return orders;
  }

  Future<List<AppUser>> getUsers(List<String> marketIds) async {
    List<AppUser> users = [];

    List<List<String>> chunks = _generateChunks(marketIds, 30);

    for (List<String> chunk in chunks) {
      QuerySnapshot<AppUser> query = await db
          .collection('users')
          .where('uid', whereIn: chunk)
          .withConverter<AppUser>(
            fromFirestore: (user, _) => AppUser.fromJson(user.data()!),
            toFirestore: (user, _) => user.toJson(),
          )
          .get();

      for (var user in query.docs) {
        users.add(user.data());
      }
    }

    return users;
  }

  List<List<T>> _generateChunks<T>(List<T> inList, int chunkSize) {
    List<List<T>> outList = [];
    List<T> tmpList = [];
    int counter = 0;

    for (int current = 0; current < inList.length; current++) {
      if (counter != chunkSize) {
        tmpList.add(inList[current]);
        counter++;
      }
      if (counter == chunkSize || current == inList.length - 1) {
        outList.add(tmpList.toList());
        tmpList.clear();
        counter = 0;
      }
    }

    return outList;
  }

  Future<List<Product>> getProductsByCategoryList(
      List<String> categories, Product? lastProduct, String? orderBy) async {
    List<Product> products = [];

    late QuerySnapshot<Product> snap;

    if (categories.isEmpty) {
      if (lastProduct == null) {
        if (orderBy == "priceAscending") {
          snap = await db
              .collection('products')
              .where("status", isEqualTo: "published")
              .orderBy("price")
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        } else if (orderBy == "priceDescending") {
          snap = await db
              .collection('products')
              .where("status", isEqualTo: "published")
              .orderBy("price", descending: true)
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        } else {
          snap = await db
              .collection('products')
              .where("status", isEqualTo: "published")
              .orderBy("productCode")
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        }
      } else {
        if (orderBy == "priceAscending") {
          snap = await db
              .collection('products')
              .where("status", isEqualTo: "published")
              .orderBy("price")
              .startAfter([lastProduct.price])
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        } else if (orderBy == "priceDescending") {
          snap = await db
              .collection('products')
              .where("status", isEqualTo: "published")
              .orderBy("price", descending: true)
              .startAfter([lastProduct.price])
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        } else {
          snap = await db
              .collection('products')
              .where("status", isEqualTo: "published")
              .orderBy("productCode")
              .startAfter([lastProduct.productCode])
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        }
      }
    } else {
      if (lastProduct == null) {
        if (orderBy == "priceAscending") {
          snap = await db
              .collection('products')
              .where('category', whereIn: categories)
              .where("status", isEqualTo: "published")
              .orderBy("price")
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        } else if (orderBy == "priceDescending") {
          snap = await db
              .collection('products')
              .where('category', whereIn: categories)
              .where("status", isEqualTo: "published")
              .orderBy("price", descending: true)
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        } else {
          snap = await db
              .collection('products')
              .where('category', whereIn: categories)
              .where("status", isEqualTo: "published")
              .orderBy("productCode")
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        }
      } else {
        if (orderBy == "priceAscending") {
          snap = await db
              .collection('products')
              .where('category', whereIn: categories)
              .where("status", isEqualTo: "published")
              .orderBy("price")
              .startAfter([lastProduct.price])
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        } else if (orderBy == "priceDescending") {
          snap = await db
              .collection('products')
              .where('category', whereIn: categories)
              .where("status", isEqualTo: "published")
              .orderBy("price", descending: true)
              .startAfter([lastProduct.price])
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        } else {
          snap = await db
              .collection('products')
              .where('category', whereIn: categories)
              .where("status", isEqualTo: "published")
              .orderBy("productCode")
              .startAfter([lastProduct.productCode])
              .limit(20)
              .withConverter<Product>(
                fromFirestore: (product, _) =>
                    Product.fromJson(product.data()!),
                toFirestore: (product, _) => product.toJson(),
              )
              .get();
        }
      }
    }

    for (var product in snap.docs) {
      Product prd = product.data();
      prd.id = product.id;
      products.add(prd);
    }

    return products;
  }

  Future<List<Product>> getBestSellers(
      Product? lastProduct, bool descending) async {
    late QuerySnapshot query;

    List<Product> products = [];
    List<String> ids = [];

    if (lastProduct == null) {
      _lastBestSellerDoc = null;
      query = await db
          .collection('bestSellers')
          .orderBy("salesAmount", descending: descending)
          .limit(20)
          .get();
    } else {
      query = await db
          .collection('bestSellers')
          .orderBy("salesAmount")
          .orderBy("salesAmount", descending: descending)
          .startAfterDocument(_lastBestSellerDoc!)
          .limit(20)
          .get();
    }

    for (var product in query.docs) {
      ids.add(product.id);
    }

    _lastBestSellerDoc = query.docs.last;

    QuerySnapshot<Product> snap = await db
        .collection('products')
        .where("status", isEqualTo: "published")
        .where("id", whereIn: ids)
        .withConverter<Product>(
          fromFirestore: (product, _) => Product.fromJson(product.data()!),
          toFirestore: (product, _) => product.toJson(),
        )
        .get();

    for (String id in ids) {
      for (var product in snap.docs) {
        if (id == product.id) {
          Product prd = product.data();
          prd.id = product.id;
          products.add(prd);
        }
      }
    }

    return products;
  }

  Future<void> updateBestSellerAmount(String productId, int quantity) async {
    DocumentSnapshot doc =
        await db.collection("bestSellers").doc(productId).get();
    int qntty = quantity;

    if (doc.data() != null) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      qntty = data['salesAmount'] + quantity;
    }

    await db
        .collection('bestSellers')
        .doc(productId)
        .set({"salesAmount": qntty});
  }
}

@riverpod
FirestoreService firestoreService(ref) {
  return FirestoreService();
}
