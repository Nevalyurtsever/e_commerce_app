import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/models/product.dart';
import '../cart_screen/providers/cart_provider.dart';
import '../product_screen/product_screen.dart';
import 'round_button.dart';

class ProductCard extends ConsumerStatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  int quantity = 0;
  late TextEditingController quantityController;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    // quantity = ref.read(cartProvider.notifier).getQuantity(widget.product.id);
    quantityController = TextEditingController(text: quantity.toString());
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        quantity = 0;
        quantityController = TextEditingController(text: quantity.toString());
      }
    });
  }

  @override
  void dispose() {
    quantityController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        context.push("${ProductScreen.routeName}/${widget.product.id}",
            extra: widget.product);
      },
      child: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 15,
          right: 15,
          bottom: 15,
        ),
        width: 170,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.theme.appColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: widget.product.imageUrl,
              child: CachedNetworkImage(
                imageUrl: widget.product.imageUrl,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Text(
                widget.product.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // price
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Constants.currencyFormat(
                              context.localizations!.localeName,
                              widget.product.price),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if (widget.product.discountedPrice != null)
                          Text(
                            Constants.currencyFormat(
                                context.localizations!.localeName,
                                widget.product.discountedPrice!),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        if (widget.product.discountedPrice == null)
                          Text(
                            Constants.currencyFormat(
                                context.localizations!.localeName,
                                widget.product.boxPrice),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        SizedBox(
                          height: 30,
                          width: 50,
                          child: TextField(
                            focusNode: focusNode,
                            onTap: () {
                              quantityController.clear();
                            },
                            controller: quantityController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (v) {
                              if (v.isNotEmpty) quantity = int.parse(v);
                            },
                            onSubmitted: (v) {
                              if (v.isNotEmpty) {
                                quantity = int.parse(v);
                                ref.read(cartProvider.notifier).addToCart(
                                    widget.product.id!, quantity, context);
                                quantity = 0;
                                quantityController = TextEditingController(
                                    text: quantity.toString());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // add to cart
                  RoundButton(
                    icon: Icons.add,
                    onTap: () {
                      ref
                          .read(cartProvider.notifier)
                          .addToCart(widget.product.id!, quantity, context);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
