import 'package:dio/dio.dart';
import 'package:domino/apis/lr_api_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<User?> login(String userid, String password) async {
    try {
      final response = await _dio.post(
        'https://13.124.78.26:8080/login',
        data: {'userid': userid, 'password': password},
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> register(String userid, String password) async {
    try {
      final response = await _dio.post(
        'https://13.124.78.26:8080/register',
        data: {'userid': userid, 'password': password},
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
