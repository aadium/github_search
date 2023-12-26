import 'package:dio/dio.dart';
import 'package:github_search/models/user.dart';

class GitHubService {
  final Dio dio;

  GitHubService(this.dio);

  Future<List<User>> searchUsers(String query) async {
    try {
      final response = await dio.get(
        'https://api.github.com/search/users',
        queryParameters: {'q': query},
      );

      final List<dynamic> data = response.data['items'];
      final List<User> users = data.map((json) => User.fromJson(json)).toList();

      return users;
    } catch (e) {
      throw Exception('Failed to fetch users. Please try again.');
    }
  }
}
