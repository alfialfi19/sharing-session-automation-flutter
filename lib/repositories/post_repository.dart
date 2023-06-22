import 'package:sharing_session/api/api.dart';
import 'package:sharing_session/models/models.dart';

class PostRepository {
  final PostsApi postsApi;

  PostRepository(this.postsApi);

  Future<List<Posts>> getListPosts() async {
    final response = await postsApi.getListPosts();

    return response;
  }

  Future<Posts> getPostById({
    String? id,
  }) async {
    final response = await postsApi.getPostById(
      id: id,
    );

    return response;
  }
}
