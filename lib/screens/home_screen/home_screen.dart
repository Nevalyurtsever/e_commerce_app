import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/product.dart';
import '../on_sale_products_screen/widgets/search.dart';
import '../product_screen/product_screen.dart';
import '../products_screen/products_screen.dart';
import 'widgets/new_arrivals_widget.dart';
import 'widgets/on_sale_products_widget.dart';
import 'widgets/reminder_list_widget.dart';
import 'widgets/slider_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SliderWidget(),
          Row(
            children: [
              const SizedBox(width: 5),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: context.localizations!.search,
                      suffixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.only(left: 15),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    onSubmitted: (v) async {
                      Product? product = await showSearch<Product?>(
                        context: context,
                        query: v,
                        delegate: ProductSearchDelegate(),
                      );

                      if (product != null && context.mounted) {
                        context.push("${ProductScreen.routeName}/${product.id}",
                            extra: product);
                      }
                    },
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push(ProductsScreen.routeName);
                },
                child: Text(context.localizations!.see_all),
              )
            ],
          ),
          const ReminderListWidget(),
          const OnSaleProductsWidget(),
          const NewArrivalssWidget(),
        ],
      ),
    );
  }
}
