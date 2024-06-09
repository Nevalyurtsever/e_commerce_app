import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/product.dart';
import '../../new_arrivals_screen/new_arrivals_screen.dart';
import '../../widgets/product_card.dart';
import '../providers/new_arrivals_provider.dart';

class NewArrivalssWidget extends ConsumerStatefulWidget {
  const NewArrivalssWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewArrivalssWidgetState();
}

class _NewArrivalssWidgetState extends ConsumerState<NewArrivalssWidget> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = ref.watch(newArrivalsProvider);

    if (products.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.localizations!.new_arrivals,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => context.push(NewArrivalsScreen.routeName),
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
