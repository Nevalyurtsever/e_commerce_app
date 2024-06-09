import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/product.dart';
import '../home_screen/providers/new_arrivals_provider.dart';
import '../widgets/product_card.dart';

class NewArrivalsScreen extends ConsumerStatefulWidget {
  static String routeName = "/new-arrivals";

  const NewArrivalsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewArrivalsScreenState();
}

class _NewArrivalsScreenState extends ConsumerState<NewArrivalsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = ref.watch(newArrivalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations!.new_arrivals),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(builder: (context, constarints) {
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
              },
            );
          }),
        ),
      ),
    );
  }
}
