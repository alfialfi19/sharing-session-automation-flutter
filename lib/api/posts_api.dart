import 'package:dio/dio.dart';
import 'package:sharing_session/models/models.dart';

class PostsApi {
  static const postsPath = '/posts';
  static String postByIdtPath(String id) => 'posts/$id';

  final Dio _dio;

  const PostsApi(this._dio);

  Future<List<Posts>> getListPosts() async {
    List<Posts> results = [];

    final response = await _dio.get(
      postsPath,
    );

    if (response.data != null) {
      List rawData = response.data;

      for (Map data in rawData) {
        results.add(
          Posts.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      }
    }

    return results;
  }

  Future<Posts> getPostById({
    String? id,
  }) async {
    final response = await _dio.get(
      postByIdtPath(id ?? "0"),
    );

    return Posts.fromJson(response.data);
  }
}
