import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharing_session/api/api.dart';
import 'package:sharing_session/repositories/repositories.dart';
import 'package:sharing_session/route_factory.dart';
import 'package:sharing_session/routes.dart';

import 'commons/commons.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  final BaseDioClient dioClient;

  final CommentsApi commentsApi;
  final PostsApi postsApi;
  final UsersApi usersApi;

  final CommentRepository commentRepository;
  final PostRepository postRepository;
  final UserRepository userRepository;

  const MyApp({
    Key? key,
    required this.dioClient,
    required this.commentsApi,
    required this.postsApi,
    required this.usersApi,
    required this.commentRepository,
    required this.postRepository,
    required this.userRepository,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => widget.dioClient),
        RepositoryProvider(create: (context) => widget.commentsApi),
        RepositoryProvider(create: (context) => widget.postsApi),
        RepositoryProvider(create: (context) => widget.usersApi),
        RepositoryProvider(create: (context) => widget.commentRepository),
        RepositoryProvider(create: (context) => widget.postRepository),
        RepositoryProvider(create: (context) => widget.userRepository),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: Routes.splash,
        title: "Sharing Session",
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => getPageByName(
              settings.name,
              nonNullable: true,
            )!,
            settings: settings,
          );
        },
      ),
    );
  }
}
