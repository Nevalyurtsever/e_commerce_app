import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_search_service.g.dart';

class ProductSearchService {
  // final _filterState = FilterState();
  final _hitsSearcher = HitsSearcher(
    applicationID: "0AK6F80C5E",
    apiKey: "9df22a1ab86eeb423898e0e104c4000e",
    indexName: "products",
  );
  //..connectFilterState(_filterState);

  // final CompositeDisposable _components = CompositeDisposable();

  ProductSearchService() {
    // _components
    //   ..add(_filterState)
    //   ..add(_hitsSearcher);
  }

  void search(String query) {
    _hitsSearcher.query(query);
  }

  Stream<SearchResponse> get productsPage => _hitsSearcher.responses;

  void dispose() {
    // _components.dispose();
  }
}

@riverpod
ProductSearchService productSearchService(ref) {
  return ProductSearchService();
}
