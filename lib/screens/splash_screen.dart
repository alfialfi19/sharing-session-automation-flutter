import 'package:flutter/material.dart';
import 'package:sharing_session/routes.dart';

import '../commons/commons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Navigator.pushReplacementNamed(context, Routes.signIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalettes.white,
      child: Image.asset(
        Images.mekariLogo,
        height: 80.0,
        width: 80.0,
        fit: BoxFit.contain,
      ),
    );
  }
}
