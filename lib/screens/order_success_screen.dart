import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessScreen extends StatelessWidget {
  final Map? details;
  static String routeName = "/success";

  const OrderSuccessScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Lottie.network(
              'https://assets10.lottiefiles.com/datafiles/Wv6eeBslW1APprw/data.json',
              height: 150,
              width: 150,
              fit: BoxFit.contain,
              repeat: false),
          Center(
            child: Text(context
                .localizations!.your_order_has_been_received_successfully),
          ),
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: ElevatedButton(
              onPressed: () => context.go('/'),
              child: Text(context.localizations!.go_back),
            ),
          )
        ],
      ),
    );
  }
}
