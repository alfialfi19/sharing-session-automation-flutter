import 'package:flutter/material.dart';
import 'package:sharing_session/api/api.dart';
import 'package:sharing_session/main_delegate.dart';
import 'package:sharing_session/my_app.dart';
import 'package:sharing_session/repositories/repositories.dart';

Future<void> main() async {
  await mainDelegate();

  /// Clients
  final BaseDioClient _dioClient = BaseDioClient();

  /// Api
  final CommentsApi _commentsApi = CommentsApi(_dioClient.dio);
  final PostsApi _postsApi = PostsApi(_dioClient.dio);
  final UsersApi _usersApi = UsersApi(_dioClient.dio);

  /// Repository
  final CommentRepository _commentRepo = CommentRepository(_commentsApi);
  final PostRepository _postRepo = PostRepository(_postsApi);
  final UserRepository _userRepo = UserRepository(_usersApi);

  // Run App
  return runApp(
    MyApp(
      dioClient: _dioClient,
      commentsApi: _commentsApi,
      postsApi: _postsApi,
      usersApi: _usersApi,
      commentRepository: _commentRepo,
      postRepository: _postRepo,
      userRepository: _userRepo,
    ),
  );
}
