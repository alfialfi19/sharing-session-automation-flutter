import 'package:flutter/material.dart';
import 'package:sharing_session/routes.dart';

import 'screens/screens.dart';

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
    case Routes.detailPosts:
      return const DetailPostsScreen();
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
