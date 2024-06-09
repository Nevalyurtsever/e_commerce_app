import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/categories_provider.dart';
import '../providers/product_list_provider.dart';
import '../providers/selected_category_provider.dart';
import 'subcategory_widget.dart';

class CategoryFilterWidget extends ConsumerStatefulWidget {
  const CategoryFilterWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoryFilterWidgetState();
}

class _CategoryFilterWidgetState extends ConsumerState<CategoryFilterWidget> {
  @override
  Widget build(BuildContext context) {
    List categories = ref.watch(categoriesProvider).values.toList();

    if (categories.isEmpty) return const SizedBox.shrink();

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                categories.length,
                (index) => MainCategoryWidget(index: index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainCategoryWidget extends ConsumerStatefulWidget {
  final int index;

  const MainCategoryWidget({super.key, required this.index});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainCategoryWidgetState();
}

class _MainCategoryWidgetState extends ConsumerState<MainCategoryWidget> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    Set<String> selectedCategories = ref.watch(selectedCategoryListProvider);
    List categories = ref.watch(categoriesProvider).values.toList();

    return Column(
      children: [
        CheckboxListTile(
          value: selectedCategories.contains(categories[widget.index]['en']),
          onChanged: (v) {
            List<String> allValues = ref
                .read(categoriesProvider.notifier)
                .getEnValues(categories[widget.index]['en']);

            List<String> selectedList = [
              categories[widget.index]['en'],
              ...allValues
            ];

            if (v!) {
              ref
                  .read(selectedCategoryListProvider.notifier)
                  .addCategory(selectedList);
            } else {
              ref
                  .read(selectedCategoryListProvider.notifier)
                  .removeCategory(selectedList);
            }

            ref.read(productListProvider.notifier).getProducts();

            setState(() {});
          },
          title: Row(
            children: [
              if (categories[widget.index]['children'] != null)
                IconButton(
                  onPressed: () {
                    isExpand = !isExpand;
                    setState(() {});
                  },
                  icon: Icon(isExpand ? Icons.expand_less : Icons.expand_more),
                ),
              Text(
                categories[widget.index][context.localizations!.localeName],
              ),
            ],
          ),
        ),
        if (categories[widget.index]['children'] != null && isExpand)
          SubcategoryWidget(
            subcategories: categories[widget.index]['children'].values.toList(),
            selectedCategories: {categories[widget.index]['en']},
          ),
        if (categories[widget.index]['children'] != null && isExpand)
          const Divider(),
      ],
    );
  }
}
