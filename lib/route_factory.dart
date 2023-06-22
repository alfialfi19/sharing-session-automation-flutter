import 'package:flutter/material.dart';
import 'package:sharing_session/routes.dart';
import 'package:sharing_session/screens/home_screen.dart';
import 'package:sharing_session/screens/main_screen.dart';
import 'package:sharing_session/screens/product_screen.dart';
import 'package:sharing_session/screens/profile_screen.dart';
import 'package:sharing_session/screens/sign_in_screen.dart';
import 'package:sharing_session/screens/splash_screen.dart';

Widget? getPageByName(
  String? name, {
  bool nonNullable = false,
}) {
  switch (name) {
    case Routes.home:
      return const HomeScreen();
    case Routes.main:
      return const MainScreen();
    case Routes.product:
      return const ProductScreen();
    case Routes.profile:
      return const ProfileScreen();
    case Routes.signIn:
      return const SignInScreen();
    case Routes.splash:
      return const SplashScreen();
  }

  if (nonNullable) {
    return Container();
  }

  return null;
}
