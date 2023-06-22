part of 'posts_bloc.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsListLoading extends PostsState {}

class PostsListLoaded extends PostsState {
  final List<Posts> postsListData;

  PostsListLoaded({
    required this.postsListData,
  });
}

class PostsListError extends PostsState {}

class PostsDetailLoading extends PostsState {}

class PostsDetailLoaded extends PostsState {
  final Posts postsData;

  PostsDetailLoaded({
    required this.postsData,
  });
}

class PostsDetailError extends PostsState {}
