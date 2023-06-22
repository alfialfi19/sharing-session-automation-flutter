import 'package:dio/dio.dart';
import 'package:sharing_session/models/models.dart';

class UsersApi {
  static const usersPath = '/users/1';

  final Dio _dio;

  const UsersApi(this._dio);

  Future<Users> getUsers() async {
    final response = await _dio.get(
      usersPath,
    );

    return Users.fromJson(response.data);
  }
}
