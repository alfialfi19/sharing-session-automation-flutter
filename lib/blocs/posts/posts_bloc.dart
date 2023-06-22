import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository postRepository;

  PostsBloc(this.postRepository) : super(PostsInitial()) {
    on<LoadListPosts>(_loadListPostsHandler);
    on<LoadDetailPosts>(_loadDetailPostsHandler);
  }

  Future<void> _loadListPostsHandler(
    LoadListPosts event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsListLoading());

    try {
      final response = await postRepository.getListPosts();

      emit(PostsListLoaded(
        postsListData: response,
      ));
    } on DioError catch (error) {
      emit(PostsListError());
    } catch (error) {
      emit(PostsListError());
    }
  }

  Future<void> _loadDetailPostsHandler(
    LoadDetailPosts event,
    Emitter<PostsState> emit,
  ) async {
    emit(PostsDetailLoading());

    try {
      final response = await postRepository.getPostById(
        id: event.postId,
      );

      emit(PostsDetailLoaded(
        postsData: response,
      ));
    } on DioError catch (error) {
      emit(PostsDetailError());
    } catch (error) {
      emit(PostsDetailError());
    }
  }
}
