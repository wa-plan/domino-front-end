import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainGoalListService {
  static Future<List<Map<String, dynamic>>?> mainGoalList(
    BuildContext context,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    print('저장된 토큰: $token');

    if (token == null) {
      Fluttertoast.showToast(
        msg: '로그인 토큰이 없습니다. 다시 로그인해 주세요.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return null;
    }

    final url = Uri.parse('http://13.124.78.26:8080/api/mandalart');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('서버 응답 상태 코드: ${response.statusCode}');
      print('서버 응답: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        List<Map<String, dynamic>> mainGoals = jsonResponse
            .map((item) => {
                  'id': item['id'],
                  'name': item['name'],
                })
            .toList();
        print('mainGoals: $mainGoals');
        return mainGoals;
      } else {
        Fluttertoast.showToast(
          msg: '업데이트 실패: ${response.body}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: '오류 발생: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return null;
    }
  }
}

class AddSecondGoalService {
  static Future<bool> addSecondGoal({
    required String mandalartId,
    required List<String> name,
    required List<String> color,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    print('저장된 토큰: $token');

    if (token == null) {
      Fluttertoast.showToast(
        msg: '로그인 토큰이 없습니다. 다시 로그인해 주세요.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    final url = Uri.parse('http://13.124.78.26:8080/api/secondgoal/add');

    if (name.length != color.length) {
      throw Exception("Mismatch in the number of names and colors");
    }

    bool allSuccess = true;

    for (int i = 0; i < name.length; i++) {
      final body = json.encode({
        "mandalartId": mandalartId,
        "name": name[i],
        "color": color[i]
      });

      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: body,
        );

        print('서버 응답 상태 코드: ${response.statusCode}');
        print('서버 응답 본문: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          Fluttertoast.showToast(
            msg: '목표가 성공적으로 저장되었습니다.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(
            msg: '목표 생성 실패: ${response.body}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          allSuccess = false;
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: '오류 발생: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        allSuccess = false;
      }
    }

    return allSuccess;
  }
}



class SecondGoalListService {
  static Future<List<Map<String, dynamic>>?> secondGoalList(
    BuildContext context,
    String mandalartId, // Added to dynamically insert mandalartId in the URL
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    print('저장된 토큰: $token');

    if (token == null) {
      Fluttertoast.showToast(
        msg: '로그인 토큰이 없습니다. 다시 로그인해 주세요.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return null;
    }

    final url =
        Uri.parse('http://13.124.78.26:8080/api/mandalart/all/$mandalartId'); // Insert mandalartId here

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('서버 응답 상태 코드: ${response.statusCode}');
      print('서버 응답: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        // Parsing the response to match the desired structure
        final List<Map<String, dynamic>> mainGoals = [
          {
            "mandalart": jsonResponse["mandalart"],
            "secondGoals": (jsonResponse["secondGoals"] as List<dynamic>)
                .map((secondGoal) => {
                      "id": secondGoal["id"],
                      "secondGoal": secondGoal["secondGoal"],
                      "color": secondGoal["color"], // color 속성 추가
                      "thirdGoals": (secondGoal["thirdGoals"] as List<dynamic>)
                          .map((thirdGoal) => {
                                "id": thirdGoal["id"],
                                "thirdGoal": thirdGoal["thirdGoal"],
                              })
                          .toList(),
                    })
                .toList(),
          }
        ];

        print('mainGoals: $mainGoals');
        return mainGoals;
      } else {
        Fluttertoast.showToast(
          msg: '업데이트 실패: ${response.body}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: '오류 발생: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return null;
    }
  }
}


class AddThirdGoalService {
  static Future<bool> addThirdGoal({
    required List<int> secondGoalId,
    required List<String> third0,
    required List<String> third1,
    required List<String> third2,
    required List<String> third3,
    required List<String> third4,
    required List<String> third5,
    required List<String> third6,
    required List<String> third7,
    required List<String> third8,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    print('저장된 토큰: $token');

    if (token == null) {
      Fluttertoast.showToast(
        msg: '로그인 토큰이 없습니다. 다시 로그인해 주세요.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    final url = Uri.parse('http://13.124.78.26:8080/api/thirdgoal/add');

    bool allSuccess = true;

    // List of all thirdGoals
    List<List<String>> allThirdGoals = [
      third0, third1, third2, third3, third4, third5, third6, third7, third8
    ];

    for (int i = 0; i < secondGoalId.length; i++) {
      // Check if we have more thirdGoals than secondGoals
      if (i >= allThirdGoals.length) break;

      List<String> currentThirdGoals = allThirdGoals[i];
      
      for (int j = 0; j < currentThirdGoals.length; j++) {
        final thirdGoalName = currentThirdGoals[j];
        
        // Skip empty strings
        if (thirdGoalName.isEmpty) continue;

        final body = json.encode({
          "secondGoalId": secondGoalId[i],
          "name": thirdGoalName,
        });

        try {
          final response = await http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: body,
          );

          print('서버 응답 상태 코드: ${response.statusCode}');
          print('서버 응답 본문: ${response.body}');

          if (response.statusCode == 200 || response.statusCode == 201) {
            Fluttertoast.showToast(
              msg: '목표가 성공적으로 저장되었습니다.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
          } else {
            Fluttertoast.showToast(
              msg: '목표 생성 실패: ${response.body}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
            allSuccess = false;
          }
        } catch (e) {
          Fluttertoast.showToast(
            msg: '오류 발생: $e',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          allSuccess = false;
        }
      }
    }

    return allSuccess;
  }
}



class DeleteMandalartService {
  
  static Future<bool> deleteMandalart(
    BuildContext context,
    int mandalartId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    print('저장된 토큰: $token');

    if (token == null) {
      Fluttertoast.showToast(
        msg: '로그인 토큰이 없습니다. 다시 로그인해 주세요.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    final url = Uri.parse('http://13.124.78.26:8080/api/mandalart/$mandalartId');

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('서버 응답 상태 코드: ${response.statusCode}');
      print('서버 응답: ${response.body}');

      if (response.statusCode == 204) {
        // Handle successful deletion
        return true;
      } else {
        Fluttertoast.showToast(
          msg: '삭제 실패: ${response.body}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: '오류 발생: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }
  }
}
