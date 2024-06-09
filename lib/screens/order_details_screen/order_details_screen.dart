import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../core/constants.dart';
import 'providers/order_details_provider.dart';

class OrderDetailsScreen extends ConsumerStatefulWidget {
  static String routeName = "/order";
  final String orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  VideoPlayerController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                title: Text('ID: ${data!.orderId}'),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: List.generate(
                          data.items!.length,
                          (index) => ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: data.items![index].product!.imageUrl,
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50,
                            ),
                            title: Text(data.items![index].product!.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${data.items![index].quantity} ${context.localizations!.quantity}'),
                                Text(
                                    '${context.localizations!.total}: ${Constants.currencyFormat(context.localizations!.localeName, data.items![index].unitPrice!)}'),
                              ],
                            ),
                            trailing: Text(data.items![index].status),
                          ),
                        ),
                      ),

                      if (_controller != null)
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
                                  IconButton(
                                    onPressed: () {
                                      _controller?.play();
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      size: 42,
                                    ),
                                  )
                              ],
                            ),
                          ),

                      // Expanded(
                      //   child: ListView.separated(
                      //     itemCount: data!.items!.length,
                      //     separatorBuilder: (context, index) => const Divider(),
                      //     itemBuilder: (context, index) => ListTile(
                      //       leading: CachedNetworkImage(
                      //         imageUrl: data.items![index].product!.imageUrl,
                      //         fit: BoxFit.cover,
                      //         height: 50,
                      //         width: 50,
                      //       ),
                      //       title: Text(data.items![index].product!.name),
                      //       subtitle: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //               '${data.items![index].quantity} ${context.localizations!.quantity}'),
                      //           Text(
                      //               '${context.localizations!.total}: ${Constants.currencyFormat(context.localizations!.localeName, data.items![index].unitPrice!)}'),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Divider(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${context.localizations!.note}:',
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(data.note),
                            ),
                            const Divider(),
                            Text(
                              Constants.dateTimeFormat(
                                  context.localizations!.localeName,
                                  data.date!),
                            ),
                            Text(
                                "${context.localizations!.status}: ${data.statusToString()}"),
                            Text(
                                '${context.localizations!.total}: ${Constants.currencyFormat(context.localizations!.localeName, data.orderPrice!)}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          error: (error, _) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }
}
