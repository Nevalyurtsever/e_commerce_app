import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/product.dart';
import '../../../core/repositories/firestore_repository.dart';

part 'new_arrivals_provider.g.dart';

@Riverpod(keepAlive: true)
class NewArrivals extends _$NewArrivals {
  @override
  List<Product> build() {
    state = [];
    getProducts();
    return state;
  }

  Future<void> getProducts() async {
    state = await ref.read(firestoreRepositoryProvider).getNewArrivals(null);
  }
}
