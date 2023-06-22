import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentRepository commentRepository;

  CommentsBloc(this.commentRepository) : super(CommentsInitial()) {
    on<LoadComments>(_loadCommentsHandler);
  }

  Future<void> _loadCommentsHandler(
    LoadComments event,
    Emitter<CommentsState> emit,
  ) async {
    emit(CommentsListLoading());

    try {
      final response = await commentRepository.getListComments(
        id: event.postId,
      );

      emit(CommentsListLoaded(
        commentsData: response,
      ));
    } on DioError catch (error) {
      emit(CommentsListError());
    } catch (error) {
      emit(CommentsListError());
    }
  }
}
