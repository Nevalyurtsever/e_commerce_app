import 'package:e_commerce_app/core/extensions.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/sign-in";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
        showAuthActionSwitch: false,
        providers: [
          EmailAuthProvider(),
        ],
        sideBuilder: (context, constraints) => buildSideBar(context),
        headerBuilder: (context, constraints, _) {
          return buildHeader(context);
        });
  }

  buildSideBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          context.theme.brightness == Brightness.dark
              ? 'assets/images/logo.png'
              : 'assets/images/logo.png',
          height: 50,
        ),
      ],
    );
  }

  buildHeader(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
