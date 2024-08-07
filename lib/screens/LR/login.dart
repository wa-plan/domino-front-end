import 'package:domino/apis/lr_api_function.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/LR/member_register_page.dart'; // 회원가입 페이지 경로

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  final ApiService apiService = ApiService();

  void _login() async {
    final username = controller.text;
    final password = controller2.text;
    final user = await apiService.login(username, password);
    if (user != null) {
      // 로그인 성공
      print('로그인 성공: ${user.userid}');
      // TODO: Navigate to the next screen
    } else {
      // 로그인 실패
      print('로그인 실패');
      // TODO: Show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff262626),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff262626),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Row(
            children: [
              Text(
                '로그인',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: '아이디를 입력해주세요.'),
            ),
            TextField(
              controller: controller2,
              decoration: const InputDecoration(labelText: '비밀번호를 입력해주세요.'),
              obscureText: true,
            ),
            const SizedBox(height: 40.0),
            TextButton(
              onPressed: _login,
              child: const Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
