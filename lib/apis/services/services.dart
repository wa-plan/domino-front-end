import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> fetchUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('authToken');

  if (token == null) {
    print('토큰이 없습니다.');
    return;
  }

  final url = Uri.parse('http://13.124.78.26:8080/api/user/data');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('서버 응답: $responseData');
      // TODO: 서버 응답 처리
    } else {
      print('API 호출 실패 상태 코드: ${response.statusCode}');
      print('서버 응답: ${response.body}');
    }
  } catch (e) {
    print('오류 발생: $e');
  }
}
