import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/models/order/order.dart';
import '../../../core/models/user/user.dart';
import '../../../core/repositories/firestore_repository.dart';
import '../../../screens/warehousepersone_home_screen/providers/selected_salesresponsible_provider.dart';

part 'salesresponsible_orders_provider.g.dart';

@Riverpod(keepAlive: true)
class SalseresponsibleOrders extends _$SalseresponsibleOrders {
  bool isBussy = false;

  @override
  List<OrderModel> build() {
    getOrders();
    return [];
  }

  getOrders() {
    AppUser? salesrosponsible = ref.read(selectedSalseresponsiblesProvider);

    if (salesrosponsible != null) {
      getSalesresponsibles();
    } else {
      getAllOrders();
    }
  }

  Future<void> getSalesresponsibles() async {
    try {
      isBussy = true;
      AppUser? salesrosponsible = ref.read(selectedSalseresponsiblesProvider);
      state = [];
      List<OrderModel> orders = await ref
          .read(firestoreRepositoryProvider)
          .getSalesresponsibleOrders(salesrosponsible?.uid, "pending");
      isBussy = false;
      state = orders;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      isBussy = false;
    }
  }

  Future<void> getAllOrders() async {
    try {
      isBussy = true;
      state = [];
      List<OrderModel> orders = await ref
          .read(firestoreRepositoryProvider)
          .getAllOrdersByStatus("pending");
      isBussy = false;
      state = orders;
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
      isBussy = false;
    }
  }

  Future<void> packageOrder(String orderId) async {
    return ref.read(firestoreRepositoryProvider).packageOrder(orderId);
  }

  Future<void> uploadOrderVideo(String orderId, String path) async {
    await ref.read(firestoreRepositoryProvider).uploadOrderVideo(orderId, path);
  }

  Future<void> shipOrder(String orderId) async {
    return ref.read(firestoreRepositoryProvider).shipOrder(orderId);
  }

  Future<void> removeVideo(String orderId, String videoUrl) async {
    await ref.read(firestoreRepositoryProvider).removeVideo(orderId, videoUrl);
  }
}
