import 'package:flutter/material.dart';

import '../commons/commons.dart';

class SectionEmptyState extends StatelessWidget {
  const SectionEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: Center(
        child: Text(
          "Tidak ada data",
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: ColorPalettes.dark,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
    );
  }
}
