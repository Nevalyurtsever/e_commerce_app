import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/product.dart';
import '../home_screen/providers/on_sale_products_provider.dart';
import '../product_screen/product_screen.dart';
import '../widgets/product_card.dart';
import 'widgets/search.dart';

class OnSaleProductsScreen extends ConsumerStatefulWidget {
  static String routeName = "/on-sale";

  const OnSaleProductsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnSaleProductsScreenState();
}

class _OnSaleProductsScreenState extends ConsumerState<OnSaleProductsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = ref.watch(onSaleProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations!.on_sale),
        actions: [
          IconButton(
            onPressed: () async {
              Product? product = await showSearch<Product?>(
                context: context,
                delegate: ProductSearchDelegate(),
              );
              if (product != null && mounted) {
                context.push("${ProductScreen.routeName}/${product.id}",
                    extra: product);
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constarints) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constarints.maxWidth < 370
                    ? 1
                    : constarints.maxWidth < 600
                        ? 2
                        : constarints.maxWidth < 900
                            ? 3
                            : 4,
                mainAxisSpacing: 0.5,
                crossAxisSpacing: 0.5,
                childAspectRatio: 0.65),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            });
      }),
    );
  }
}
