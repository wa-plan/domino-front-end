import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:domino/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _currentkeycontroller = TextEditingController();
  final _newkeycontroller = TextEditingController();
  final _checkkeycontroller = TextEditingController();

  @override
  void dispose() {
    _currentkeycontroller.dispose();
    _newkeycontroller.dispose();
    _checkkeycontroller.dispose();
    super.dispose();
  }

  Future<String?> _changePw() async {
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

    final currentPassword = _currentkeycontroller.text;
    final newPassword = _newkeycontroller.text;

    final url = Uri.parse('http://13.124.78.26:8080/api/user/me/password');

    final body = jsonEncode({
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      print('서버 응답 상태 코드: ${response.statusCode}');

      if (response.statusCode == 200) {
        try {
          Fluttertoast.showToast(
            msg: '비밀번호가 성공적으로 변경되었습니다.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyApp(),
            ),
          );
        } catch (e) {
          Fluttertoast.showToast(
            msg: '응답 데이터 처리 중 오류 발생: JSON 파싱 오류 - $e',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          return null;
        }
      } else {
        Fluttertoast.showToast(
          msg: '비밀번호 변경 실패: ${response.body}',
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
    return null;
  }

  Widget _buildTextFormField({
    required String hintText,
    required TextEditingController controller,
    required FormFieldValidator<String?> validator,
    bool obscureText = false,
    void Function()? onClear,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          border: const OutlineInputBorder(),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: onClear ?? () {},
                  icon: const Icon(Icons.clear_outlined),
                )
              : null,
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 20.0, 20.0, 0.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: Colors.white,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '비밀번호 변경',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xff262626),
      ),
      backgroundColor: const Color(0xff262626),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '현재 비밀번호를 입력해 주세요.',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 350,
              child: _buildTextFormField(
                hintText: '비밀번호를 입력해 주세요.',
                controller: _currentkeycontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력해 주세요.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '새 비밀번호를 입력해 주세요.',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 350,
              child: _buildTextFormField(
                hintText: '8~16자를 입력해 주세요.',
                controller: _newkeycontroller,
                validator: (value) {
                  if (value == null || value.length < 8 || value.length > 16) {
                    return '비밀번호는 8~16자리여야 해요.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '새 비밀번호를 확인해 주세요.',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 350,
              child: _buildTextFormField(
                hintText: '비밀번호를 다시 입력해 주세요.',
                controller: _checkkeycontroller,
                validator: (value) {
                  if (value != _newkeycontroller.text) {
                    return '비밀번호가 일치하지 않습니다.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                '혹시 비밀번호를 잊으셨나요?',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: SizedBox(
                  height: 60,
                  child: TextButton(
                    onPressed: () async {
                      if (_newkeycontroller.text != _checkkeycontroller.text) {
                        Fluttertoast.showToast(
                          msg: '새 비밀번호가 일치하지 않습니다.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        return;
                      }

                      // 비밀번호 변경 요청
                      final result = await _changePw();
                      if (result != null) {
                        // 새 토큰을 사용해 추가 작업을 처리할 수 있습니다.
                      }
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                    child: const Text('비밀번호 변경하기',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
