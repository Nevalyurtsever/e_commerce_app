import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/product.dart';
import '../cart_screen/cart_screen.dart';
import '../on_sale_products_screen/widgets/search.dart';
import '../widgets/product_card.dart';
import 'providers/product_list_provider.dart';
import 'providers/scroll_controller_provider.dart';
import 'widgets/category_filter_widget.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  static String routeName = "/products";

  const ProductsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  late ScrollController _scrollController;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
        initialScrollOffset: ref.read(productListOffsetProvider));
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _scrollController.addListener(() {
      ref
          .read(productListOffsetProvider.notifier)
          .updateState(_scrollController.offset);
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent - 500 &&
          !_scrollController.position.outOfRange) {
        ref.read(productListProvider.notifier).getMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(context.localizations!.product),
            const Spacer(),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.go(CartScreen.routeName);
            },
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () async {
              if (!kIsWeb) {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    title: Text(
                      context.localizations!.order_by,
                    ),
                    actions: <CupertinoActionSheetAction>[
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          ref.read(productListProvider.notifier).orderBy =
                              "priceAscending";
                          ref.read(productListProvider.notifier).getProducts();

                          Navigator.pop(context);
                        },
                        child: Text(context.localizations!.price_ascending),
                      ),
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          ref.read(productListProvider.notifier).orderBy =
                              "priceDescending";
                          ref.read(productListProvider.notifier).getProducts();

                          Navigator.pop(context);
                        },
                        child: Text(context.localizations!.price_descending),
                      ),
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          ref.read(productListProvider.notifier).orderBy =
                              "bestSellersAscending";
                          ref
                              .read(productListProvider.notifier)
                              .getBestSellers();

                          Navigator.pop(context);
                        },
                        child: Text(context.localizations!.best_sellers),
                      ),
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          ref.read(productListProvider.notifier).orderBy =
                              "bestSellersDescending";
                          ref
                              .read(productListProvider.notifier)
                              .getBestSellers();

                          Navigator.pop(context);
                        },
                        child: Text(context.localizations!.least_sold),
                      ),
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () {
                          ref.read(productListProvider.notifier).orderBy = null;
                          ref.read(productListProvider.notifier).getProducts();

                          Navigator.pop(context);
                        },
                        child: Text(context.localizations!.product_code),
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(context.localizations!.cancel),
                    ),
                  ),
                );
              } else {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  builder: (context) => Consumer(builder: (context, ref, _) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.localizations!.order_by,
                            style: context.theme.textTheme.titleMedium,
                          ),
                          const Divider(),
                          const SizedBox(height: 15),
                          ListTile(
                            title: Text(context.localizations!.price_ascending),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              ref.read(productListProvider.notifier).orderBy =
                                  "priceAscending";
                              ref
                                  .read(productListProvider.notifier)
                                  .getProducts();

                              Navigator.pop(context);
                            },
                          ),
                          const Divider(),
                          ListTile(
                            title:
                                Text(context.localizations!.price_descending),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              ref.read(productListProvider.notifier).orderBy =
                                  "priceDescending";
                              ref
                                  .read(productListProvider.notifier)
                                  .getProducts();

                              Navigator.pop(context);
                            },
                          ),
                          const Divider(),
                          ListTile(
                            title:
                                Text(context.localizations!.price_descending),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              ref.read(productListProvider.notifier).orderBy =
                                  "priceDescending";
                              ref
                                  .read(productListProvider.notifier)
                                  .getProducts();

                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }
            },
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () async {
              // Product? product =
              await showSearch<Product?>(
                context: context,
                delegate: ProductSearchDelegate(),
              );

              // if (product != null && context.mounted) {
              //   context.push("${ProductScreen.routeName}/${product.id}",
              //       extra: product);
              // }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      endDrawer: const Drawer(child: CategoryFilterWidget()),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constarints) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: constarints.maxWidth < 370
                        ? 2
                        : constarints.maxWidth < 600
                            ? 2
                            : constarints.maxWidth < 900
                                ? 3
                                : 4,
                    mainAxisSpacing: 0.2,
                    crossAxisSpacing: 0.3,
                    childAspectRatio: 0.65),
                itemCount: ref.watch(productListProvider).length,
                itemBuilder: (context, index) {
                  return ProductCard(
                      product: ref.read(productListProvider)[index]);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.jumpTo(0);
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
