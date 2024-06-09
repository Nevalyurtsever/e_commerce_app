import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/global_providers/auth_state_provider.dart';
import '../../core/global_providers/customer_provider.dart';
import '../../core/models/product.dart';
import '../widgets/product_card.dart';
import 'providers/favorites_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  static String routeName = "/favorites";

  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Product> favorites = ref.watch(favoritesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations!.favorites),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, constarints) {
              if (favorites.isEmpty) {
                return Center(
                  child: Text(
                    context.localizations!.customer_favorites_list_is_empty(
                      ref.read(customerStateProvider) == null
                          ? ref.read(authStateProvider)?.displayName.toString()
                          : ref.read(customerStateProvider)?.createFullName(),
                    ),
                  ),
                );
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constarints.maxWidth < 370
                        ? 1
                        : constarints.maxWidth < 600
                            ? 2
                            : constarints.maxWidth < 900
                                ? 3
                                : 4,
                    mainAxisSpacing: 0.8,
                    crossAxisSpacing: 1,
                    childAspectRatio: 0.65),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: favorites[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
