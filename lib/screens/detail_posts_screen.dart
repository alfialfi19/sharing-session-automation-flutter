import 'dart:math';

import 'package:flutter/material.dart';

import '../commons/commons.dart';

class DetailPostsScreen extends StatelessWidget {
  const DetailPostsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as PostsArguments;
    final post = argument.posts;

    Random random = Random();

    return Scaffold(
      key: const Key(UIKeys.discoverDetailPostsScreen),
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        title: const Text("Detail Posts"),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
              color: Colors.greenAccent,
            ),
            height: 130.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: Image.asset(
              Images.mekariLogo,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    post.title ?? "-",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorPalettes.black,
                        ),
                    overflow: TextOverflow.visible,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: ColorPalettes.primary,
                      size: 30.0,
                    ),
                    Text(
                      random.nextInt(6).toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Text(
              post.body ?? "-",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ColorPalettes.black,
                  ),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
