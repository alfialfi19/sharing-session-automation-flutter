part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {}

class LoadComments extends CommentsEvent {
  final String? postId;

  LoadComments({
    this.postId,
  });

  @override
  List<Object?> get props => [
        postId,
      ];
}
