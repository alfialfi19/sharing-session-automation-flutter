import 'package:flutter/material.dart';

import '../commons/commons.dart';
import 'top_toast.dart';

class InfoToast extends TopToast {
  InfoToast(String message, {super.key})
      : super(
          message: message,
          borderColor: ColorPalettes.warning,
          icon: Image.asset(
            ResourceIcons.reset,
            height: 24,
            width: 24,
            color: ColorPalettes.warning,
          ),
        );
}
