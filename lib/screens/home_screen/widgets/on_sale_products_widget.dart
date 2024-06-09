import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/product.dart';
import '../../on_sale_products_screen/on_sale_products_screen.dart';
import '../../widgets/product_card.dart';
import '../providers/on_sale_products_provider.dart';

class OnSaleProductsWidget extends ConsumerStatefulWidget {
  const OnSaleProductsWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnSaleProductsWidgetState();
}

class _OnSaleProductsWidgetState extends ConsumerState<OnSaleProductsWidget> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = ref.watch(onSaleProductsProvider);

    if (products.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.localizations!.on_sale,
                // style: context.theme.textTheme.headlineMedium,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => context.push(OnSaleProductsScreen.routeName),
                child: Text(context.localizations!.see_all),
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemBuilder: (context, index) => ProductCard(
              product: products[index],
            ),
          ),
        )
      ],
    );
  }
}
