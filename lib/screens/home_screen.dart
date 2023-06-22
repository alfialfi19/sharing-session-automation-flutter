import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharing_session/widgets/widgets.dart';

import '../blocs/blocs.dart';
import '../commons/commons.dart';
import '../repositories/repositories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
      child: const HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key(UIKeys.discoverHomeScreen),
      backgroundColor: ColorPalettes.backgroundLight,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                if (state is PostsListError) {
                  return const SectionErrorState(
                    key: Key(UIKeys.homeContentErrorSection),
                  );
                }

                if (state is PostsListLoaded) {
                  var data = state.postsListData;
                  Random random = Random();

                  return Column(
                    children: [
                      Row(
                        key: const Key(UIKeys.homeWelcomeSection),
                        children: [
                          Container(
                            height: 56.0,
                            width: 56.0,
                            padding: const EdgeInsets.all(
                              6.0,
                            ),
                            decoration: BoxDecoration(
                              color: ColorPalettes.grayTextField2,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                              child: Image.asset(
                                Images.mekariLogo,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome,",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                "Lorem ipsum",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      TextField(
                        controller: searchController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Input something here',
                          hintStyle:
                              Theme.of(context).textTheme.caption?.copyWith(
                                    color: ColorPalettes.grayHint,
                                    fontWeight: FontWeight.w400,
                                  ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ColorPalettes.grayHint,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              24.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: ColorPalettes.grayTextField,
                            ),
                            borderRadius: BorderRadius.circular(
                              24.0,
                            ),
                          ),
                          focusColor: ColorPalettes.primary,
                          filled: true,
                          fillColor: ColorPalettes.grayTextField2,
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      SizedBox(
                        key: const Key(UIKeys.homeContentLoadedSection),
                        // height: MediaQuery.of(context).size.height,
                        height: MediaQuery.of(context).size.height * 0.60,
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: false,
                          itemCount: 10,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // crossAxisSpacing: 18.0,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ),
                                color: ColorPalettes.grayTextField2,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12.0),
                                        topLeft: Radius.circular(12.0),
                                      ),
                                      color: Colors.yellow,
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
                                    height: 6.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                    ),
                                    child: Text(
                                      data[index].title ?? "-",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star_rounded,
                                            color: ColorPalettes.primary,
                                          ),
                                          Text(
                                            random.nextInt(6).toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                    ],
                  );
                }

                return const SectionLoadingState(
                  key: Key(UIKeys.homeContentLoadingSection),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
