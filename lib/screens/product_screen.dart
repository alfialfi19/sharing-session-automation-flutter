import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharing_session/blocs/blocs.dart';
import 'package:sharing_session/repositories/repositories.dart';

import '../commons/commons.dart';
import '../widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(
          create: (context) {
            final repository = RepositoryProvider.of<PostRepository>(context);

            return PostsBloc(repository)
              ..add(
                LoadListPosts(),
              );
          },
        ),
      ],
      child: const ProductContent(),
    );
  }
}

class ProductContent extends StatelessWidget {
  const ProductContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key(UIKeys.discoverProductScreen),
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Posts Screen",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: 18.0,
                color: ColorPalettes.dark,
                fontWeight: FontWeight.w700,
              ),
        ),
        backgroundColor: ColorPalettes.backgroundLight,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        child: ListView(
          children: [
            BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                if (state is PostsListError) {
                  return const SectionErrorState(
                    key: Key(UIKeys.productContentErrorSection),
                  );
                }

                if (state is PostsListLoaded) {
                  var data = state.postsListData;

                  return ListView.builder(
                    key: Key(UIKeys.productContentLoadedSection),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: 12.0,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(
                                6.0,
                              ),
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                color: ColorPalettes.grayTextField2,
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                              ),
                              child: Image.asset(
                                Images.mekariLogo,
                              ),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].title ?? "-",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    "Oleh: ${data[index].title ?? "-"}",
                                    style: Theme.of(context).textTheme.caption,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return const SectionLoadingState(
                  key: Key(UIKeys.productContentLoadingSection),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
