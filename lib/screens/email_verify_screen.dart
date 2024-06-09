import 'package:e_commerce_app/core/extensions.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/global_providers/auth_state_provider.dart';

class EmailVerifyScreen extends StatelessWidget {
  static String routeName = "/verify-email";

  const EmailVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmailVerificationScreen(
      sideBuilder: (context, constraints) => buildBrand(context),
      headerBuilder: (context, constraints, _) => buildBrand(context),
      actions: [EmailVerifiedAction(() {})],
    );
  }

  Widget buildBrand(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer(
          builder: (context, ref, _) {
            return Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    ref.read(authStateProvider.notifier).signOut();
                  },
                  icon: const Icon(Icons.exit_to_app)),
            );
          },
        ),
        Image.asset(
          context.theme.brightness == Brightness.dark
              ? 'assets/images/logo.png'
              : 'assets/images/logo.png',
          height: 50,
        ),
      ],
    );
  }
}
