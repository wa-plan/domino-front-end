import 'package:flutter/material.dart';
import 'package:domino/screens/LR/login.dart';
import 'package:domino/apis/lr_api_function.dart';


 // 로그인 페이지 경로

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  final ApiService apiService = ApiService();

  void _register() async {
    final username = controller.text;
    final password = controller2.text;
    final user = await apiService.register(username, password);
    if (user != null) {
      // 회원가입 성공
      print('회원가입 성공: ${user.userid}');
      // TODO: Navigate to the next screen
    } else {
      // 회원가입 실패
      print('회원가입 실패');
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '회원가입',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.w600,
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
              onPressed: _register,
              child: const Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
