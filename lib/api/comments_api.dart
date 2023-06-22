import 'package:dio/dio.dart';
import 'package:sharing_session/models/models.dart';

class CommentsApi {
  static const commentsPath = '/comments';
  static String commentsByPostPath(String id) => 'posts/$id/comments';

  final Dio _dio;

  const CommentsApi(this._dio);

  Future<List<Comments>> getListComments({
    String? id,
  }) async {
    List<Comments> results = [];

    final response = await _dio.get(
      commentsByPostPath(
        id ?? "0",
      ),
    );

    if (response.data != null) {
      List rawData = response.data;

      for (Map data in rawData) {
        results.add(
          Comments.fromJson(
            Map<String, dynamic>.from(data),
          ),
        );
      }
    }

    return results;
  }
}
