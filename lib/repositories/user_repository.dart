import 'package:sharing_session/api/api.dart';

import '../models/models.dart';

class UserRepository {
  final UsersApi usersApi;

  UserRepository(this.usersApi);

  Future<Users> getUsers() async {
    final response = await usersApi.getUsers();

    return response;
  }
}
