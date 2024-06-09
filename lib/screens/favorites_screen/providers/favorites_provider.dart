import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/global_providers/auth_state_provider.dart';
import '../../../core/global_providers/customer_provider.dart';
import '../../../core/global_providers/role_provider.dart';
import '../../../core/models/product.dart';
import '../../../core/repositories/firestore_repository.dart';

part 'favorites_provider.g.dart';

@Riverpod(keepAlive: true)
class Favorites extends _$Favorites {
  @override
  List<Product> build() {
    getInitial();
    listenCustomer();

    state = [];
    return state;
  }

  listenCustomer() {
    final customer = ref.read(customerStateProvider);

    if (customer != null) {
      getFavoriteProducts(customer.uid);
    }

    ref.listen(customerStateProvider, (previous, next) {
      if (next != null) {
        getFavoriteProducts(next.uid);
      } else {
        state = [];
      }
    });
  }

  getInitial() {
    final customer = ref.read(customerStateProvider);

    if (customer != null) {
      getFavoriteProducts(customer.uid);
    } else {
      getFavoriteProducts(ref.read(authStateProvider)!.uid);
    }
  }

  Future<void> getFavoriteProducts(String uid) async {
    try {
      state = await ref.read(firestoreRepositoryProvider).getFavorites(uid);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }

  void favorite(String? productId) async {
    if (productId == null) return;

    Role? role = ref.read(roleStateProvider);
    String? uid;
    if (role == Role.salesResponsible) {
      uid = ref.read(customerStateProvider)?.uid;
      if (uid == null) return;
    } else {
      uid = ref.read(authStateProvider)!.uid;
    }

    List<String> ids = [];
    for (Product product in state) {
      ids.add(product.id!);
    }

    if (ids.contains(productId)) {
      List<String> ids = [];
      List<Product> products = [];

      for (Product product in state) {
        ids.add(product.id!);
        if (product.id != productId) {
          products.add(product);
        }
      }

      if (!ids.contains(productId)) return;
      ids.remove(productId);

      await ref.read(firestoreRepositoryProvider).favorite(ids, uid);

      state = products;
    } else {
      ids.add(productId);

      await ref.read(firestoreRepositoryProvider).favorite(ids, uid);
      Product? product =
          await ref.read(firestoreRepositoryProvider).getProduct(productId);

      if (product != null) {
        state = [...state, product];
      }
    }
  }

  bool isFavorite(Product productFromList) {
    bool isFavorite = false;
    for (Product product in state) {
      if (product.id == productFromList.id) {
        isFavorite = true;
      }
    }
    return isFavorite;
  }
}
