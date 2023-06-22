part of 'comments_bloc.dart';

abstract class CommentsState {}

class CommentsInitial extends CommentsState {}

class CommentsListLoading extends CommentsState {}

class CommentsListLoaded extends CommentsState {
  final List<Comments> commentsData;

  CommentsListLoaded({
    required this.commentsData,
  });
}

class CommentsListError extends CommentsState {}
