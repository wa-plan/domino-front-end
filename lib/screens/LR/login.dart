import 'package:domino/screens/LR/loginregister_find_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:domino/screens/LR/member_register_page.dart';
import 'package:domino/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  void _login() async {
    final userId = controller.text;
    final password = controller2.text;

    final url = Uri.parse('http://13.124.78.26:8080/api/auth/login');

    final body = jsonEncode({
      'userId': userId,
      'password': password,
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

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // 서버 응답에서 'accessToken'을 추출
        final accessToken = responseData['accessToken'] ?? '';

        if (accessToken.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('authToken', accessToken);

          Fluttertoast.showToast(
            msg: '로그인 성공!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          // 로그인 성공 후 MyApp 화면으로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyApp(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: '토큰을 받아오지 못했습니다.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: '로그인 실패: ${response.body}',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff262626),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff262626),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 38.0, 0.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        '계정생성',
                        style: TextStyle(
                          color: const Color(0xff5C5C5C),
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'ID',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                  height: 35,
                  width: 275,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        labelText: '아이디를 입력해 주세요.',
                        labelStyle: const TextStyle(color: Color(0xff5C5C5C),fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: Color(0xff5C5C5C),
                              width: 1.5,
                            ))),
                  ))
            ]),
            const SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'PW',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                  height: 35,
                  width: 275,
                  child: TextField(
                    controller: controller2,
                    decoration: InputDecoration(
                        labelText: '비밀번호를 입력해 주세요.',
                        labelStyle: const TextStyle(color: Color(0xff5C5C5C),fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: Color(0xff5C5C5C),
                              width: 1.5,
                            ))),
                    obscureText: true,
                  ))
            ]),
            const SizedBox(height: 40.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(children: [
                          Text(
                            '자동으로 로그인되기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          MyCheckBox(),
                        ]),
                        const SizedBox(height: 5.0),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginregisterFindPassword(),
                                ),
                              );
                            },
                            child: const Text(
                              '아이디/비밀번호 찾기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ))
                      ]),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffBDBDBD),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(2))),
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  )
                ]),
          ],
        ),
      ),
    );
  }
}

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool _isCheck = false;

  List<String> checkList = [];

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _isCheck,
      activeColor: const Color(0xffFCFF62),
      checkColor: Colors.black,
      onChanged: (value) {
        setState(() {
          _isCheck = value!;
        });
      },
    );
  }
}
