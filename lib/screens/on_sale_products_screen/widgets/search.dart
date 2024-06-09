import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/product.dart';
import '../../../core/services/product_search_service.dart';
import '../../product_screen/product_screen.dart';

class ProductSearchDelegate extends SearchDelegate<Product?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return showCustomResults();
  }

  Consumer showCustomResults() {
    return Consumer(builder: (context, ref, _) {
      ref.read(productSearchServiceProvider).search(query);
      return StreamBuilder(
        stream: ref.read(productSearchServiceProvider).productsPage,
        builder: (context, snapshot) {
          // print(snapshot.data?.hits);

          // response.hits.map(Product.fromJson).toList();

          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              if (snapshot.data!.hits.isNotEmpty) {
                List<Product> products = [];

                for (var element in snapshot.data!.hits) {
                  // Hit hit = snapshot.data!.hits[index];
                  Product product = Product.fromJson(element);

                  if (product.status == "published") {
                    products.add(product);
                  }
                }
                return ListView.separated(
                  itemCount: products.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    // Hit hit = snapshot.data!.hits[index];
                    Product product = products[index];

                    return ListTile(
                      onTap: () async {
                        // close(context, product);

                        if (kIsWeb) {
                          await launchUrl(
                            Uri.parse(
                                "https://enfaapp.web.app/products/${product.id}"),
                            webOnlyWindowName: '_blank',
                          );
                        } else {
                          context.push(
                              "${ProductScreen.routeName}/${product.id}",
                              extra: product);
                        }
                      },
                      leading: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        fit: BoxFit.cover,
                        height: 70,
                        width: 70,
                      ),
                      title: Text(product.name),
                      subtitle: Text(product.productCode.toString()),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('Ürün yok'),
                );
              }
            } else {
              return const Center(
                child: Text('Ürün yok'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return showCustomResults();
  }
}
