import 'dart:ui';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/LR/login.dart';
import 'package:domino/apis/services/lr_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key 추가

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _idController = TextEditingController();
  final _pwController = TextEditingController();
  final _checkpwController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _idController.dispose();
    _pwController.dispose();
    _checkpwController.dispose();
    super.dispose();
  }

  void _register() {
    final userId = _idController.text;
    final password = _pwController.text;
    final email = _emailController.text;
    final phoneNum = _phoneController.text;

    RegistrationService.register(
      context: context,
      userId: userId,
      password: password,
      email: email,
      phoneNum: phoneNum,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Padding(
          padding: appBarPadding,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: const Color(0xffD4D4D4),
                iconSize: 17,
              ),
              Text(
                '계정생성',
                style: TextStyle(
                    fontSize: currentWidth < 600 ? 20 : 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "본인확인 및 본인인증",
                      style: TextStyle(
                        color: const Color(0xffD4D4D4),
                        fontWeight: FontWeight.bold,
                        fontSize: currentWidth < 600 ? 13 : 16,
                      ),
                    ),
                    SizedBox(
                      width: currentWidth < 600 ? 150 : 300,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: currentWidth < 600 ? 15 : 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              height: currentWidth < 600 ? 30 : 45,
                              width: currentWidth < 600 ? 200 : 350,
                              child: CustomTextField(
                                      '이메일 주소를 입력해 주세요.', _emailController,
                                      (value) {
                                if (value == null || value.isEmpty) {
                                  return '이메일을 주소를 입력해 주세요.';
                                }
                                final emailRegex =
                                    RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                                if (!emailRegex.hasMatch(value)) {
                                  return '유효한 이메일을 입력해 주세요.';
                                }
                                return null;
                              }, false, 1)
                                  .textField(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Phone',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: currentWidth < 600 ? 15 : 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: currentWidth < 600 ? 30 : 45,
                                  width: currentWidth < 600 ? 200 : 350,
                                  child: CustomTextField(
                                          '전화번호를 입력해 주세요.', _phoneController,
                                          (value) {
                                    if (value == null || value.isEmpty) {
                                      return '올바른 전화번호를 입력해 주세요.';
                                    }
                                    return null;
                                  }, false, 1)
                                      .textField(),
                                ),
                                const SizedBox(width: 10.0),
                              ],
                            ),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "아이디 생성",
                      style: TextStyle(
                        color: const Color(0xffD4D4D4),
                        fontWeight: FontWeight.bold,
                        fontSize: currentWidth < 600 ? 13 : 16,
                      ),
                    ),
                    SizedBox(
                      width: currentWidth < 600 ? 195 : 355,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ID',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: currentWidth < 600 ? 15 : 18,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: currentWidth < 600 ? 30 : 45,
                            width: currentWidth < 600 ? 210 : 350,
                            child: CustomTextField(
                                    '아이디를 입력해주세요.', _idController, (value) {
                              if (value == null || value.isEmpty) {
                                return '3~15자 영문/숫자 조합으로 입력해주세요.';
                              }
                              if (value.length < 3 || value.length > 15) {
                                return '아이디는 3~15자로 입력해 주세요.';
                              }
                              return null;
                            }, false, 1)
                                .textField(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "비밀번호 생성",
                      style: TextStyle(
                        color: const Color(0xffD4D4D4),
                        fontWeight: FontWeight.bold,
                        fontSize: currentWidth < 600 ? 13 : 16,
                      ),
                    ),
                    SizedBox(
                      width: currentWidth < 600 ? 180 : 340,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: currentWidth < 600 ? 245 : 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'PW',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: currentWidth < 600 ? 15 : 18,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: currentWidth < 600 ? 30 : 45,
                            width: currentWidth < 600 ? 200 : 350,
                            child: CustomTextField(
                                    '8~16자를 입력해 주세요.', _pwController, (value) {
                              if (value == null || value.isEmpty) {
                                return '8~16자를 입력해 주세요.';
                              }
                              if (value.length < 8 || value.length > 16) {
                                return '비밀번호는 8~16자로 입력해 주세요.';
                              }
                              return null;
                            }, true, 1)
                                .textField(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'PW',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: currentWidth < 600 ? 15 : 18,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: currentWidth < 600 ? 30 : 45,
                            width: currentWidth < 600 ? 200 : 350,
                            child: CustomTextField(
                                    '비밀번호를 확인해 주세요.', _checkpwController,
                                    (value) {
                              if (value == null ||
                                  value != _pwController.text) {
                                return '비밀번호가 일치하지 않습니다.';
                              }
                              return null;
                            }, true, 1)
                                .textField(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 17.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              child: Button(Colors.black, Colors.white, '계정생성',
                                      _register)
                                  .button()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
