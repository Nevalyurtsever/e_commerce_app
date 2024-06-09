import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/repositories/realtime_db_repository.dart';
part 'categories_provider.g.dart';

@Riverpod(keepAlive: true)
class Categories extends _$Categories {
  @override
  Map<String, dynamic> build() {
    state = {};
    getCategories();

    return state;
  }

  Future<void> getCategories() async {
    state = await ref.read(realtimeDbRepositoryProvider).getCategories();
  }

  List<String> getEnValues(String categoryEn) {
    List<String> values = [];

    state.forEach((key, value) {
      if (categoryEn == value['en']) {
        values.add(value['en']);
        if (value['children'] != null) {
          List<String> subvalues = getSubcategoryValues(value['children']);
          values.addAll(subvalues);
        }
      }
    });

    return values;
  }

  List<String> getSubcategoryValues(Map subcategory) {
    List<String> values = [];
    subcategory.forEach((key, value) {
      values.add(value['en']);
      if (value['children'] != null) {
        List<String> subvalues = getSubcategoryValues(value['children']);
        values.addAll(subvalues);
      }
    });
    return values;
  }
}
