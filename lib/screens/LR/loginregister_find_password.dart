import 'package:flutter/material.dart';
import 'package:domino/screens/LR/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class LoginregisterFindPassword extends StatefulWidget {
  const LoginregisterFindPassword({super.key});

  @override
  State<LoginregisterFindPassword> createState() =>
      _LoginregisterFindPasswordState();
}

class _LoginregisterFindPasswordState extends State<LoginregisterFindPassword> {
  final _phoneController = TextEditingController();
  final _idEmailController = TextEditingController();
  String _responseId = '';

  final _userIdController = TextEditingController();
  final _pwEmailController = TextEditingController();
  final _verifyNumController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _idEmailController.dispose();
    _userIdController.dispose();
    _pwEmailController.dispose();
    _verifyNumController.dispose();
    _responseId = '';
    super.dispose();
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

  void _idFind() async {
    final phoneNum = _phoneController.text;
    final email = _idEmailController.text;

    final url = Uri.parse('http://13.124.78.26:8080/api/user/find_userId');

    final body = jsonEncode({
      'phoneNum': phoneNum,
      'email': email,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print('서버 응답 상태 코드: ${response.statusCode}');
      print('서버 응답: ${response.body}');
      // 서버 응답 데이터를 상태에 저장
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _responseId = responseData.toString(); // 예시로 userId를 사용
        });
      } else {
        Fluttertoast.showToast(
          msg: '사용자 ID를 찾을 수 없습니다.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: '오류 발생: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void _pwFind() async {
    final userId = _userIdController.text;
    final email = _pwEmailController.text;

    final url = Uri.parse('http://13.124.78.26:8080/api/user/reset_password');

    final body = jsonEncode({
      'userId': userId,
      'email': email,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print('서버 응답 상태 코드: ${response.statusCode}');
      print('서버 응답: ${response.body}');
    } catch (e) {
      Fluttertoast.showToast(
        msg: '오류 발생: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff262626),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                color: Colors.white,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                visualDensity: const VisualDensity(horizontal: -4),
              ),
              const SizedBox(width: 10.0),
              Text(
                '아이디 / 비밀번호 찾기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]),
            const SizedBox(height: 30.0),
            const Text(
              "아이디 찾기",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'Phone',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 35,
                width: 350,
                child: _buildTextFormField(
                  hintText: '전화번호를 입력해 주세요.',
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '전화번호를 입력해 주세요.';
                    }
                    return null;
                  },
                ),
              ),
            ]),
            const SizedBox(height: 10.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 35,
                width: 350,
                child: _buildTextFormField(
                  hintText: '이메일을 입력해 주세요.',
                  controller: _idEmailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력해 주세요.';
                    }
                    return null;
                  },
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _responseId,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: _idFind,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                  ),
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50.0),
            const Text(
              "비밀번호 찾기",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'ID',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 35,
                width: 350,
                child: _buildTextFormField(
                  hintText: '아이디를 입력해 주세요.',
                  controller: _userIdController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '아이디를 입력해 주세요.';
                    }
                    return null;
                  },
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 35,
                width: 350,
                child: _buildTextFormField(
                  hintText: '이메일을 입력해 주세요.',
                  controller: _pwEmailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력해 주세요.';
                    }
                    return null;
                  },
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _pwFind,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                  ),
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
