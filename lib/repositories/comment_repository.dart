import 'package:sharing_session/api/api.dart';

import '../models/models.dart';

class CommentRepository {
  final CommentsApi commentsApi;

  CommentRepository(this.commentsApi);

  Future<List<Comments>> getListComments({
    String? id,
  }) async {
    final response = await commentsApi.getListComments(
      id: id,
    );

    return response;
  }
}
