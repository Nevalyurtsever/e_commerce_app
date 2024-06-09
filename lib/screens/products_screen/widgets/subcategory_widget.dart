import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_list_provider.dart';
import '../providers/selected_category_provider.dart';

class SubcategoryWidget extends ConsumerStatefulWidget {
  final List subcategories;
  final Set<String> selectedCategories;

  const SubcategoryWidget(
      {super.key,
      required this.subcategories,
      required this.selectedCategories});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends ConsumerState<SubcategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.subcategories.length, (index) {
        widget.selectedCategories.add(widget.subcategories[index]['en']);

        return Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              CheckboxListTile(
                value: ref
                    .watch(selectedCategoryListProvider)
                    .contains(widget.subcategories[index]['en']),
                onChanged: (v) {
                  List<String> subvalues = [];
                  if (widget.subcategories[index]['children'] != null) {
                    subvalues =
                        getSubvalues(widget.subcategories[index]['children']);
                  }

                  List<String> selectedList = [
                    widget.subcategories[index]['en'],
                    ...subvalues
                  ];

                  if (widget.subcategories[index]['children'] != null) {
                    for (Map category in widget
                        .subcategories[index]['children'].values
                        .toList()) {
                      selectedList.add(category['en']);
                    }
                  }

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
                title: Text(widget.subcategories[index]
                    [context.localizations!.localeName]),
              ),
              if (widget.subcategories[index]['children'] != null)
                SubcategoryWidget(
                    subcategories:
                        widget.subcategories[index]['children'].values.toList(),
                    selectedCategories: widget.selectedCategories),
              const Divider(),
            ],
          ),
        );
      }),
    );
  }

  List<String> getSubvalues(Map subcategory) {
    List<String> values = [];

    subcategory.forEach((key, value) {
      values.add(value['en']);

      if (value['children'] != null) {
        List<String> subvalues = getSubvalues(value['children']);
        values.addAll(subvalues);
      }
    });

    return values;
  }
}
