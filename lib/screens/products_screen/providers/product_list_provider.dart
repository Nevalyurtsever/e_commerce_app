import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/product.dart';
import '../../../core/repositories/firestore_repository.dart';
import 'categories_provider.dart';
import 'selected_category_provider.dart';

part 'product_list_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductList extends _$ProductList {
  String? orderBy;

  Product? _lastProduct;
  bool _bussy = false;
  bool _isMore = true;

  @override
  List<Product> build() {
    state = [];
    getProducts();
    return state;
  }

  Future<void> getProducts() async {
    state = [];
    _bussy = true;
    _lastProduct = null;
    _isMore = true;
    Set<String> categories = ref.read(selectedCategoryListProvider);

    state = await ref
        .read(firestoreRepositoryProvider)
        .getProductsByCategoryList(categories.toList(), _lastProduct, orderBy);
    if (state.isNotEmpty) _lastProduct = state.last;
    _bussy = false;
    if (state.length < 20) {
      _isMore = false;
    }
  }

  String findLocalCategory(String? category) {
    String localCategory = '';
    if (category != null) {
      Map categories = ref.read(categoriesProvider);
      localCategory = findCategory(category, categories);
    }

    return localCategory;
  }

  String findCategory(String categoryEn, Map category) {
    String localCategory = '';

    for (var ctgry in category.values) {
      if (ctgry['en'] == categoryEn) {
        localCategory = ctgry['en'];
      }
      if (ctgry['children'] != null) {
        for (var ctgrya in ctgry['children'].values) {
          if (ctgrya['en'] == categoryEn) {
            localCategory = ctgrya['en'];
          }

          if (ctgrya['children'] != null) {
            for (var ctgryaa in ctgrya['children'].values) {
              if (ctgryaa['en'] == categoryEn) {
                localCategory = ctgryaa['en'];
              }
            }
          }
        }
      }
    }
    return localCategory;
  }

  void getMore() async {
    if (orderBy == "bestSellersAscending" ||
        orderBy == "bestSellersDescending") {
      getMoreBestSellers();
      return;
    }
    if (!_bussy && _isMore) {
      _bussy = true;
      Set<String> categories = ref.read(selectedCategoryListProvider);

      List<Product> products = await ref
          .read(firestoreRepositoryProvider)
          .getProductsByCategoryList(
              categories.toList(), _lastProduct, orderBy);

      if (products.isNotEmpty) _lastProduct = products.last;

      state = [...state, ...products];
      if (products.length < 20) {
        _isMore = false;
      }
      _bussy = false;
    }
  }

  Future<void> getBestSellers() async {
    _lastProduct = null;
    bool descending = false;

    state = [];

    if (orderBy == "bestSellersAscending") {
      descending = true;
    } else {
      descending = false;
    }
    state = await ref
        .read(firestoreRepositoryProvider)
        .getBestSellers(null, descending);
    if (state.isNotEmpty) _lastProduct = state.last;
  }

  Future<void> getMoreBestSellers() async {
    bool descending = false;

    if (orderBy == "bestSellersAscending") {
      descending = false;
    } else {
      descending = true;
    }
    List<Product> bestSellers = await ref
        .read(firestoreRepositoryProvider)
        .getBestSellers(null, descending);
    if (bestSellers.isNotEmpty) _lastProduct = bestSellers.last;

    state = [...state, ...bestSellers];
  }
}
