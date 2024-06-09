import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_category_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedCategoryList extends _$SelectedCategoryList {
  @override
  Set<String> build() {
    return {};
  }

  void removeCategory(List<String> selected) {
    Set<String> categories = state;

    for (String category in selected) {
      if (categories.contains(category)) {
        categories.remove(category);
      }
    }

    state = categories;
  }

  void addCategory(List<String> selected) {
    Set<String> categories = state;

    for (String category in selected) {
      categories.add(category);
    }

    state = categories;
  }
}
