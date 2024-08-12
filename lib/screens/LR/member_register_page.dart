import 'package:flutter/material.dart';
import 'package:domino/screens/LR/login.dart';
import 'package:domino/apis/lr_api_function.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 20.0, 38.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      color: const Color(0xff5C5C5C),
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    '계정생성',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            const Text(
              "본인확인 및 본인인증",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                  height: 35,
                  width: 275,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: '이메일을 입력해 주세요.',
                        labelStyle: const TextStyle(
                            color: Color(0xff5C5C5C), fontSize: 13),
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
                'Phone',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                  height: 35,
                  width: 190,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: '숫자만 입력해 주세요.',
                        labelStyle: const TextStyle(
                            color: Color(0xff5C5C5C), fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: Color(0xff5C5C5C),
                              width: 1.5,
                            ))),
                    obscureText: true,
                  )),
              ElevatedButton(
                onPressed: () {},
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
              )
            ]),
            const SizedBox(height: 30.0),
            const Text(
              "아이디/비밀번호 생성",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20.0),
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
                        labelText: '3~15자 영문/숫자 조합으로 입력해 주세요.',
                        labelStyle: const TextStyle(
                            color: Color(0xff5C5C5C), fontSize: 13),
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
                        labelText: '8~16자를 입력해 주세요',
                        labelStyle: const TextStyle(
                            color: Color(0xff5C5C5C), fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: Color(0xff5C5C5C),
                              width: 1.5,
                            ))),
                    obscureText: true,
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
                        labelText: '비밀번호를 확인해 주세요.',
                        labelStyle: const TextStyle(
                            color: Color(0xff5C5C5C), fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: Color(0xff5C5C5C),
                              width: 1.5,
                            ))),
                    obscureText: true,
                  ))
            ]),
            const SizedBox(height: 20.0),
            Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(2))),
                  child: const Text(
                    '계정생성',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
