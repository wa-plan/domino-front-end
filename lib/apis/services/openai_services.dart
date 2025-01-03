import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String? openaiKey = dotenv.env['OPENAI_KEY'];

String? apiKey = openaiKey;
const apiUrl = 'https://api.openai.com/v1/chat/completions';

Future<List<String>> generateSubGoals(String coreGoal) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content":
              "You are a helpful assistant who provides concise and goal-oriented suggestions."
        },
        {
          "role": "user",
          "content":
              "핵심목표 '$coreGoal'을(를) 달성하기 위한 13글자 이내의 세부 목표 6가지를 추천해 주세요. 각각 간결한 구 형태로 작성해 주세요."
        }
      ],
      "max_tokens": 150,
      "temperature": 0.7,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception(
        'Failed to connect: ${response.statusCode}, ${response.body}');
  }

  Map<String, dynamic> responseData =
      jsonDecode(utf8.decode(response.bodyBytes));

  // 디버그 콘솔에 API 응답 데이터 출력
  print("OpenAI Response: $responseData");

  if (responseData['choices'] == null || responseData['choices'].isEmpty) {
    throw Exception('Invalid API response: ${response.body}');
  }

  String content = responseData['choices'][0]['message']['content'];

  // 응답을 줄 단위로 나누고 숫자 제거
  return content
      .split('\n')
      .map((line) => line.replaceAll(RegExp(r'^\d+\.?\s*'), '').trim())
      .where((line) => line.isNotEmpty)
      .take(6)
      .toList();
}
