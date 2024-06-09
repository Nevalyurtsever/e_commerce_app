import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../core/global_providers/role_provider.dart';
import '../../core/models/order/order.dart';
import '../../core/models/order/order_item.dart';
import '../../core/models/product.dart';
import '../../core/repositories/firestore_repository.dart';
import '../controller_home_screen/providers/orders_for_controller.dart';
import '../on_sale_products_screen/widgets/search.dart';
import '../warehousepersone_home_screen/providers/salesresponsible_orders_provider.dart';
import '../widgets/custom_video_picker.dart';
import 'providers/order_details_provider.dart';

class OrderDetailsWarePersonScreen extends ConsumerStatefulWidget {
  static String routeName = "/order-wareperson";
  final String orderId;

  const OrderDetailsWarePersonScreen({super.key, required this.orderId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderDetailsWarePersonScreenState();
}

class _OrderDetailsWarePersonScreenState
    extends ConsumerState<OrderDetailsWarePersonScreen> {
  VideoPlayerController? _controller;
  bool bussy = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (bussy) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Order"),
        ),
        body: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return ref.watch(orderDetailsProvider(widget.orderId)).when(
          data: (data) {
            if (data?.videoUrl != null && _controller == null) {
              _controller = VideoPlayerController.networkUrl(
                Uri.parse(data!.videoUrl!),
              )..initialize().then((value) => setState(() {}));
              _controller?.addListener(() {
                setState(() {});
              });
            }
            return Scaffold(
              appBar: AppBar(
                title: Text(data!.orderId.toString()),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            text: "${context.localizations!.market}: ",
                            style: context.theme.appTextTheme.boldSubtitleStyle,
                            children: [
                              TextSpan(
                                text: data.orderer?.createFullName(),
                                style: context.theme.appTextTheme.bodyMedium,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            text: "${context.localizations!.note}: ",
                            style: context.theme.appTextTheme.boldSubtitleStyle,
                            children: [
                              TextSpan(
                                text: data.note,
                                style: context.theme.appTextTheme.bodyMedium
                                    .copyWith(height: 1.2),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            text: "${context.localizations!.status}: ",
                            style: context.theme.appTextTheme.boldSubtitleStyle,
                            children: [
                              TextSpan(
                                text: data.statusToString(),
                                style: context.theme.appTextTheme.bodyMedium,
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Image",
                                  style: context
                                      .theme.appTextTheme.boldSubtitleStyle,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  context.localizations!.product,
                                  style: context
                                      .theme.appTextTheme.boldSubtitleStyle,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  context.localizations!.quantity,
                                  style: context
                                      .theme.appTextTheme.boldSubtitleStyle,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  context.localizations!.ready,
                                  style: context
                                      .theme.appTextTheme.boldSubtitleStyle,
                                ),
                              ),
                              if (ref.read(roleStateProvider) ==
                                  Role.controller)
                                Expanded(
                                  child: Text(
                                    context.localizations!.checked,
                                    style: context
                                        .theme.appTextTheme.boldSubtitleStyle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (data.items != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: List.generate(
                                data.items!.length,
                                (index) => Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (v) async {
                                          double unitPrice =
                                              data.items![index].unitPrice! *
                                                  data.items![index].quantity;

                                          double newPrice =
                                              data.orderPrice! - unitPrice;

                                          await ref
                                              .read(firestoreRepositoryProvider)
                                              .removeOrderItem(
                                                  data.id,
                                                  data.items![index].id,
                                                  newPrice);

                                          ref.invalidate(orderDetailsProvider(
                                              widget.orderId));
                                        },
                                        backgroundColor:
                                            context.theme.appColors.danger,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: context.localizations!.delete,
                                      ),
                                      SlidableAction(
                                        onPressed: (v) {
                                          int quantity = 0;
                                          showDialog(
                                            context: context,
                                            builder: (context) => Material(
                                              child: AlertDialog.adaptive(
                                                title: Text(context
                                                    .localizations!.quantity),
                                                content: TextField(
                                                  onChanged: (v) {
                                                    quantity = int.parse(v);
                                                  },
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () =>
                                                        updateQuantity(
                                                            quantity,
                                                            data.items![index],
                                                            data),
                                                    child: Text(context
                                                        .localizations!.save),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        backgroundColor:
                                            const Color(0xFF21B7CA),
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        label: context.localizations!.edit,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CachedNetworkImage(
                                            imageUrl: data.items![index]
                                                .product!.imageUrl,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            data.items![index].product!.name,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data.items![index].quantity
                                                .toString(),
                                            style: context.theme.appTextTheme
                                                .boldSubtitleStyle,
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Checkbox(
                                              value: data.items![index]
                                                          .status ==
                                                      'packaged' ||
                                                  data.items![index].status ==
                                                      'checked',
                                              onChanged: (v) async {
                                                String status;

                                                if (v!) {
                                                  status = 'packaged';
                                                } else {
                                                  status = 'pending';
                                                }

                                                data.items![index].status =
                                                    status;
                                                setState(() {});

                                                await ref
                                                    .read(
                                                        firestoreRepositoryProvider)
                                                    .packageOrderItem(
                                                        widget.orderId,
                                                        data.items![index].id,
                                                        status);

                                                ref.invalidate(
                                                  orderDetailsProvider(
                                                      widget.orderId),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        if (ref.read(roleStateProvider) ==
                                            Role.controller)
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Checkbox(
                                                value:
                                                    data.items![index].status ==
                                                        'checked',
                                                onChanged: (v) async {
                                                  String status;
                                                  if (v!) {
                                                    status = "checked";
                                                  } else {
                                                    status = 'packaged';
                                                  }
                                                  data.items![index].status =
                                                      status;
                                                  setState(() {});
                                                  await ref
                                                      .read(
                                                          firestoreRepositoryProvider)
                                                      .packageOrderItem(
                                                          widget.orderId,
                                                          data.items![index].id,
                                                          status);

                                                  ref.invalidate(
                                                    orderDetailsProvider(
                                                        widget.orderId),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        const Divider(),
                        if (data.videoUrl != null && _controller != null)
                          if (_controller!.value.isInitialized)
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AspectRatio(
                                    aspectRatio: _controller!.value.aspectRatio,
                                    child: VideoPlayer(_controller!),
                                  ),
                                  if (!_controller!.value.isPlaying)
                                    IconButton.filledTonal(
                                      onPressed: () {
                                        _controller?.play();
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.play_arrow,
                                        size: 42,
                                      ),
                                    ),
                                  if (ref.read(roleStateProvider) ==
                                      Role.warehouseperson)
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton.filled(
                                        onPressed: () async {
                                          setState(() {
                                            bussy = true;
                                          });
                                          await ref
                                              .read(
                                                  salseresponsibleOrdersProvider
                                                      .notifier)
                                              .removeVideo(widget.orderId,
                                                  data.videoUrl!);

                                          ref.invalidate(orderDetailsProvider(
                                              widget.orderId));

                                          setState(() {
                                            bussy = false;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                        if (data.videoUrl != null && _controller != null)
                          if (!_controller!.value.isInitialized)
                            const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (data.videoUrl == null)
                              TextButton.icon(
                                onPressed: () async {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => CustomViedoPicker(
                                      callbackImage: (File? v) async {
                                        setState(() {
                                          bussy = true;
                                        });
                                        if (v != null) {
                                          await ref
                                              .read(
                                                  salseresponsibleOrdersProvider
                                                      .notifier)
                                              .uploadOrderVideo(
                                                  widget.orderId, v.path);

                                          ref.invalidate(orderDetailsProvider(
                                              widget.orderId));
                                        }
                                        setState(() {
                                          bussy = false;
                                        });
                                      },
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.video_call),
                                label: Text(context.localizations!.add_a_video),
                              ),
                            if (ref.read(roleStateProvider) == Role.controller)
                              TextButton.icon(
                                onPressed: () =>
                                    addNewProduct(data.orderPrice!),
                                icon: const Icon(Icons.add),
                                label:
                                    Text(context.localizations!.add_a_product),
                              )
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (ref.read(roleStateProvider) ==
                                Role.warehouseperson &&
                            data.status == OrderStatus.pending)
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (data.videoUrl == null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog.adaptive(
                                      title: Text(context
                                          .localizations!.missing_information),
                                      content: Text(context.localizations!
                                          .please_upload_a_video),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Ok'),
                                        )
                                      ],
                                    ),
                                  );
                                  return;
                                }
                                bool isTherePendingItem = false;
                                for (final item in data.items!) {
                                  if (item.status == "pending") {
                                    isTherePendingItem = true;
                                  }
                                }

                                if (isTherePendingItem) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog.adaptive(
                                      title: Text(context
                                          .localizations!.missing_information),
                                      content: Text(context.localizations!
                                          .please_make_sure_all_items_are_prepared),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Ok'),
                                        )
                                      ],
                                    ),
                                  );
                                  return;
                                }
                                await ref
                                    .read(
                                        salseresponsibleOrdersProvider.notifier)
                                    .packageOrder(widget.orderId);

                                ref
                                    .read(
                                        salseresponsibleOrdersProvider.notifier)
                                    .getSalesresponsibles();
                                if (mounted) context.go('/');
                              },
                              child: Text(context.localizations!.complete),
                            ),
                          ),
                        if (ref.read(roleStateProvider) == Role.controller &&
                            data.status == OrderStatus.packaged)
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                bool isTherePendingItem = false;
                                for (final item in data.items!) {
                                  if (item.status == "packaged") {
                                    isTherePendingItem = true;
                                  }
                                }

                                if (isTherePendingItem) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog.adaptive(
                                      title: Text(context
                                          .localizations!.missing_information),
                                      content: Text(context.localizations!
                                          .please_make_sure_all_items_are_prepared),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Ok'),
                                        )
                                      ],
                                    ),
                                  );
                                  return;
                                }

                                await ref
                                    .read(
                                        salseresponsibleOrdersProvider.notifier)
                                    .shipOrder(widget.orderId);

                                ref
                                    .read(ordersForControllersProvider.notifier)
                                    .getOrders();

                                if (mounted) context.go('/');
                              },
                              child: Text(context.localizations!.complete),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          error: (error, _) => Center(
            child: Text(error.toString()),
          ),
          loading: () => Scaffold(
            appBar: AppBar(
              title: Text(widget.orderId),
            ),
            body: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        );
  }

  Future<void> updateQuantity(
      int quantity, OrderItem item, OrderModel order) async {
    setState(() {
      bussy = true;
    });

    // double productPrice;
    // if (item.product!.discountedPrice == null) {
    //   productPrice = item.product!.price;
    // } else {
    //   productPrice = item.product!.discountedPrice!;
    // }

    double total = order.orderPrice! -
        (item.unitPrice! * item.quantity) +
        (item.unitPrice! * quantity);

    Navigator.pop(context);

    await ref
        .read(firestoreRepositoryProvider)
        .updateOrderItemQuantity(widget.orderId, item.id, quantity, total);

    ref.invalidate(
      orderDetailsProvider(widget.orderId),
    );

    setState(() {
      bussy = false;
    });
  }

  addNewProduct(double orderPrice) async {
    Product? product = await showSearch<Product?>(
      context: context,
      delegate: ProductSearchDelegate(),
    );

    if (product != null && mounted) {
      int quantity = 0;
      late double price;

      if (product.discountedPrice != null) {
        price = product.discountedPrice!;
      } else {
        price = product.price;
      }
      showDialog(
        context: context,
        builder: (context) => Material(
          child: AlertDialog.adaptive(
            title: Text(context.localizations!.add_a_product),
            content: TextField(
              onChanged: (v) {
                quantity = int.parse(v);
              },
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    bussy = true;
                  });
                  OrderItem item = OrderItem(
                      id: null,
                      productId: product.id!,
                      quantity: quantity,
                      unitPrice: price,
                      status: "idle");

                  double newOrderPrice = orderPrice + (quantity * price);

                  await ref
                      .read(firestoreRepositoryProvider)
                      .addOrderProductProduct(
                          widget.orderId, item, newOrderPrice);

                  ref.invalidate(orderDetailsProvider(widget.orderId));

                  if (mounted) Navigator.pop(context);

                  setState(() {
                    bussy = false;
                  });
                },
                child: Text(context.localizations!.save),
              )
            ],
          ),
        ),
      );
    }
  }
}
