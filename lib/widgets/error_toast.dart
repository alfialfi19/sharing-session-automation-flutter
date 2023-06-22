import 'package:flutter/material.dart';
import 'package:sharing_session/commons/commons.dart';

import 'widgets.dart';

class ErrorToast extends TopToast {
  ErrorToast(String error, {super.key})
      : super(
          message: error,
          borderColor: ColorPalettes.red,
          icon: Image.asset(
            ResourceIcons.reset,
            height: 24,
            width: 24,
            color: ColorPalettes.red,
          ),
        );
}
