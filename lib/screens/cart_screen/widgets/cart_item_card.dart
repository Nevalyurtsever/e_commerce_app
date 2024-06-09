import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/models/cart.dart';
import '../../../core/theme/app_palette.dart';
import '../../widgets/round_button.dart';
import '../providers/cart_provider.dart';

class CartItemCard extends ConsumerStatefulWidget {
  final CartModel item;
  final int index;
  const CartItemCard({super.key, required this.item, required this.index});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartItemCardState();
}

class _CartItemCardState extends ConsumerState<CartItemCard> {
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    quantityController =
        TextEditingController(text: widget.item.quantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.item.product?.imageUrl == null)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: context.theme.primaryColor,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.inventory,
                size: 40,
                color: context.theme.primaryColor,
              ),
            )
          else
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image:
                      CachedNetworkImageProvider(widget.item.product!.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(width: 25),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.product!.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Text(
                //   item.quantity.toString(),
                //   style: const TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w400,
                //     color: AppPalette.lightBorderGray,
                //   ),
                // ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    RoundButton(
                        icon: Icons.remove,
                        onTap: () async {
                          await ref
                              .read(cartProvider.notifier)
                              .increaseQuanttiy(widget.index, false);

                          quantityController.text = ref
                              .read(cartProvider)[widget.index]
                              .quantity
                              .toString();
                        },
                        backgroundColor: Colors.transparent,
                        iconColor: AppPalette.lightBorderGray,
                        borderColor: context.theme.appColors.borderColor),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        controller: quantityController,
                        textAlign: TextAlign.center,
                        onChanged: (v) {},
                        onSubmitted: (v) {
                          int quantity = int.parse(v);

                          if (quantity <= 0) return;

                          ref
                              .read(cartProvider.notifier)
                              .updateQuanttiy(widget.index, quantity);
                        },
                      ),
                    ),
                    // Text(
                    //   item.quantity.toString(),
                    //   style: const TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    const SizedBox(width: 10),
                    RoundButton(
                        icon: Icons.add,
                        onTap: () async {
                          await ref
                              .read(cartProvider.notifier)
                              .increaseQuanttiy(widget.index, true);
                          quantityController.text = ref
                              .read(cartProvider)[widget.index]
                              .quantity
                              .toString();
                        },
                        borderColor: context.theme.appColors.borderColor),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // close icon button
                IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Close',
                  onPressed: () {
                    ref.read(cartProvider.notifier).removeItem(widget.index);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: AppPalette.lightBorderGray,
                  ),
                ),
                // price

                if (widget.item.product?.discountedPrice != null)
                  Text(
                    findUndiscountPrice(
                        widget.item, context.localizations!.localeName),
                    style: context.theme.textTheme.labelSmall!.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Text(
                  findItemPrice(widget.item, context.localizations!.localeName),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String findItemPrice(CartModel item, String locale) {
    double amount = 0;

    if (item.product?.discountedPrice != null) {
      amount = item.product!.discountedPrice!;
    } else {
      amount = item.product!.boxPrice;
    }
    return Constants.currencyFormat(locale, amount * item.quantity);
  }

  String findUndiscountPrice(CartModel item, String localeName) {
    double amount = 0;

    amount = item.product!.boxPrice;

    return Constants.currencyFormat(localeName, amount * item.quantity);
  }
}
