import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:domino/apis/services/lr_services.dart';

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

  void _idFind() async {
    final phoneNum = _phoneController.text;
    final email = _idEmailController.text;

    final result = await IdFindService.findUserId(
      phoneNum: phoneNum,
      email: email,
    );

    setState(() {
      _responseId = result;
    });
  }

  void _pwFind() async {
    final userId = _userIdController.text;
    final email = _pwEmailController.text;

    await PwFindService.findPassword(
      userId: userId,
      email: email,
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
                '아이디/비밀번호 찾기',
                style: TextStyle(
                    fontSize: currentWidth < 600 ? 18 : 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: fullPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: currentWidth < 600 ? 20 : 30),
            // 아이디 찾기 영역
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "아이디 찾기",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: currentWidth < 600 ? 16 : 20),
                ),
                SizedBox(
                  width: currentWidth < 600 ? 195 : 360,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: currentWidth < 600 ? 260 : 450,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '전화번호',
                          style: TextStyle(
                              color: const Color(0xff949494),
                              fontSize: currentWidth < 600 ? 12 : 18,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: currentWidth < 600 ? 8 : 30,
                        ),
                        SizedBox(
                          height: currentWidth < 600 ? 30 : 45,
                          width: currentWidth < 600 ? 200 : 350,
                          child: CustomTextField(
                            '전화번호를 입력해 주세요.',
                            _phoneController,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return '전화번호를 입력해 주세요.';
                              }
                              return null;
                            },
                            false, // obscureText
                            1, // maxLines
                          ).textField(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                              color: const Color(0xff949494),
                              fontSize: currentWidth < 600 ? 12 : 18,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: currentWidth < 600 ? 13 : 50,
                        ),
                        SizedBox(
                          height: currentWidth < 600 ? 30 : 45,
                          width: currentWidth < 600 ? 200 : 350,
                          child: CustomTextField(
                            '이메일을 입력해 주세요.',
                            _idEmailController,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return '이메일을 입력해 주세요.';
                              }
                              return null;
                            },
                            false,
                            1,
                          ).textField(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _responseId,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(width: 20),
                        Button(Colors.black, Colors.white, '확인', _idFind)
                            .button(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 비밀번호 찾기 영역
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "비밀번호 찾기",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: currentWidth < 600 ? 16 : 20),
                ),
                SizedBox(
                  width: currentWidth < 600 ? 180 : 345,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: currentWidth < 600 ? 260 : 450,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ID',
                          style: TextStyle(
                              color: const Color(0xff949494),
                              fontSize: currentWidth < 600 ? 12 : 18,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: currentWidth < 600 ? 20 : 60,
                        ),
                        SizedBox(
                          height: currentWidth < 600 ? 30 : 45,
                          width: currentWidth < 600 ? 200 : 350,
                          child: CustomTextField(
                            '아이디를 입력해 주세요.',
                            _userIdController,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return '아이디를 입력해 주세요.';
                              }
                              return null;
                            },
                            false,
                            1,
                          ).textField(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(
                              color: const Color(0xff949494),
                              fontSize: currentWidth < 600 ? 12 : 18,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: currentWidth < 600 ? 13 : 40,
                        ),
                        SizedBox(
                          height: currentWidth < 600 ? 30 : 45,
                          width: currentWidth < 600 ? 200 : 350,
                          child: CustomTextField(
                            '이메일을 입력해 주세요.',
                            _pwEmailController,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return '이메일을 입력해 주세요.';
                              }
                              return null;
                            },
                            false,
                            1,
                          ).textField(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(Colors.black, Colors.white, '찾기', _pwFind)
                            .button(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
