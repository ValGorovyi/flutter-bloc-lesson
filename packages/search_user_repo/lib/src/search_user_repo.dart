import 'package:dio/dio.dart';
import 'package:search_user_repo/src/models/models.dart';

class SearchUserRepo {
  final apiUrl = 'https://api.jikan.moe/v4/users';
  final _httpClient = Dio();

  Future<List<UserModel>> onSearch(String query) async {
    try {
      final res = await _httpClient.get(
        apiUrl,
        queryParameters: {
          'q': query,
        },
      );

      return (res.data['data'] as List)
          .map((json) => UserModel.fromJson(json))
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
