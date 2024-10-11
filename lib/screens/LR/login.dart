import 'package:domino/screens/LR/loginregister_find_password.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/LR/member_register_page.dart';
import 'package:domino/apis/services/lr_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();

  final LoginService _loginService = LoginService();

  void _login() {
    final userId = _idcontroller.text;
    final password = _pwcontroller.text;

    if (userId.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: '아이디와 비밀번호를 모두 입력해 주세요.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    _loginService.login(context, userId, password);
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
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(vertical: 11),
          hintStyle: const TextStyle(
            color: Colors.grey, 
            fontSize: 13,
            ),
          border: const OutlineInputBorder(),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: onClear ??
                      () {
                        controller.clear();
                      },
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
                width: 300,
                child: _buildTextFormField(
                  hintText: '아이디를 입력해 주세요.',
                  controller: _idcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '아이디를 입력해 주세요.';
                    }
                    return null;
                  },
                ),
              )
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
                width: 300,
                child: _buildTextFormField(
                  hintText: '비밀번호를 입력해 주세요.',
                  controller: _pwcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력해 주세요.';
                    }
                    return null;
                  },
                ),
              )
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
  MyCheckBoxState createState() => MyCheckBoxState();
}

class MyCheckBoxState extends State<MyCheckBox> {
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
          _isCheck = value ?? false;
        });
      },
    );
  }
}
