import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/constants.dart';
import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/product.dart';
import '../../core/repositories/firestore_repository.dart';
import '../cart_screen/providers/cart_provider.dart';
import '../favorites_screen/providers/favorites_provider.dart';
import '../full_screen_image_screen.dart';

class ProductScreen extends ConsumerStatefulWidget {
  static String routeName = "/products";
  final String productId;
  final Product? product;

  const ProductScreen({super.key, required this.productId, this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  late TextEditingController _quantityController;
  Product? product;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: '1');
    getProduct();
  }

  getProduct() async {
    if (widget.product == null) {
      product = await ref
          .read(firestoreRepositoryProvider)
          .getProduct(widget.productId);
    } else {
      product = widget.product;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    final favorites = ref.watch(favoritesProvider);

    for (var prd in favorites) {
      if (prd.id == product?.id) {
        isFavorite = true;
      }
    }
    if (product == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.productId),
        ),
        body: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: false,
            onStretchTrigger: () async {
              debugPrint('onstrech');
            },
            expandedHeight: context.height * 0.35,
            flexibleSpace: FlexibleSpaceBar(
              background: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FullScreenImage(imagePath: product!.imageUrl),
                    ),
                  );
                },
                child: Hero(
                  tag: product!.imageUrl,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product!.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(product!.name,
                            style: context.theme.appTextTheme.titleStyle),
                      ),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(favoritesProvider.notifier)
                              .favorite(product!.id);
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                        ),
                      ),
                    ],
                  ),
                ),
                if (product?.boxPrice != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                        '${context.localizations!.unit_price}: ${Constants.currencyFormat(context.localizations!.localeName, product!.price)}',
                        style: context.theme.appTextTheme.subtitleStyle),
                  ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              int quantity =
                                  int.parse(_quantityController.text);
                              if (quantity > 1) {
                                quantity--;
                                _quantityController.text = quantity.toString();
                              }
                            });
                          },
                          iconSize: 30,
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(
                                color: context.theme.appColors.borderColor),
                          ),
                          child: TextField(
                            controller: _quantityController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: context.theme.appColors.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              int quantity =
                                  int.parse(_quantityController.text);
                              quantity++;
                              _quantityController.text = quantity.toString();
                            });
                          },
                          iconSize: 30,
                          icon: const Icon(
                            Icons.add,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          showPrice(),
                          style: context.theme.appTextTheme.titleStyle.copyWith(
                            color: product?.discountedPrice == null
                                ? null
                                : Colors.grey,
                            fontSize:
                                product?.discountedPrice == null ? 24 : 16,
                            decoration: product?.discountedPrice != null
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        if (product?.discountedPrice != null)
                          Text(showDiscountPrice(),
                              style: context.theme.appTextTheme.titleStyle),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addToCart(product!.id!,
                          int.parse(_quantityController.text), context);
                    },
                    child: Text(context.localizations!.add_to_cart),
                  ),
                ),
                if (product?.description != null) const Divider(),
                if (product?.description != null)
                  ExpansionTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    title: Text(
                      context.localizations!.description,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    expandedAlignment:
                        Alignment.centerLeft, // default is centerRight
                    expandedCrossAxisAlignment:
                        CrossAxisAlignment.start, // default is center
                    children: List.generate(
                      1,
                      (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product?.description ??
                                context.localizations!.no_description,
                          ),
                          Text(
                              "${context.localizations!.barcode}: ${product?.barkod}"),
                          Text(
                              "${context.localizations!.product_code}: ${product?.productCode}"),
                        ],
                      ),
                    ),
                  ),
                const Divider(),
                ExpansionTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    title: Text(
                      context.localizations!.box_information,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    expandedAlignment:
                        Alignment.centerLeft, // default is centerRight
                    expandedCrossAxisAlignment:
                        CrossAxisAlignment.start, // default is center
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            '${context.localizations!.quantity_in_box}: ${product?.quantityInBox}'),
                      ),
                      // if (product?.boxPrice != null)
                      //   Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Text(
                      //         '${context.localizations!.box_price}: ${product?.boxPrice}'),
                      //   ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            '${context.localizations!.number_of_rows}: ${product!.numberOfRows}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            '${context.localizations!.number_of_pallets}: ${product!.quantityInOnePallet}'),
                      ),
                    ]),
              ],
            ),
          )
        ],
      ),
    );
  }

  String showPrice() {
    double price;
    price = product!.boxPrice * int.parse(_quantityController.text);

    return Constants.currencyFormat(context.localizations!.localeName, price);
  }

  String showDiscountPrice() {
    double price;
    price = product!.discountedPrice! * int.parse(_quantityController.text);

    return Constants.currencyFormat(context.localizations!.localeName, price);
  }
}
