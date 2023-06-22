part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {}

class LoadListPosts extends PostsEvent {
  @override
  List<Object?> get props => [];
}

class LoadDetailPosts extends PostsEvent {
  final String? postId;

  LoadDetailPosts({
    this.postId,
  });

  @override
  List<Object?> get props => [
        postId,
      ];
}
