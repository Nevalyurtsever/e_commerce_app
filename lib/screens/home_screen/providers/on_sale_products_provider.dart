import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/product.dart';
import '../../../core/repositories/firestore_repository.dart';

part 'on_sale_products_provider.g.dart';

@Riverpod(keepAlive: true)
class OnSaleProducts extends _$OnSaleProducts {
  @override
  List<Product> build() {
    state = [];
    getProducts();
    return state;
  }

  Future<void> getProducts() async {
    state = await ref.read(firestoreRepositoryProvider).getOnSaleProducts();
  }
}
