import 'dart:ui';
import 'package:domino/screens/LR/loginregister_find_password.dart';
import 'package:domino/screens/TD/td_main.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/LR/register.dart';
import 'package:domino/apis/services/lr_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();
  final storage = const FlutterSecureStorage();
  String userInfo = ""; //user의 정보를 저장하기 위한 변수

  final LoginService _loginService = LoginService();

  /*_asyncMethod() async {
    if (await storage.read(key: "token") != null) {
      if (!mounted) return;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const TdMain()));
    }
  }*/
  Future<void> _asyncMethod() async {
    // 먼저 저장된 토큰이 있는지 확인
    final String? authToken = await storage.read(key: "token");

    if (authToken == null || authToken.isEmpty) {
      print("로그인 토큰이 없습니다. 자동 로그인 불가능.");
      return; // 토큰이 없으면 자동 로그인하지 않음
    }

    // 저장된 로그인 정보 읽기
    final String? storedUserInfo = await storage.read(key: "login");

    // null 체크 후 할당 (null이면 빈 문자열로 초기화)
    userInfo = storedUserInfo ?? "";
    print("Stored User Info: $userInfo");

    if (userInfo.isNotEmpty) {
      // userInfo에서 userId와 password 추출
      final parts = userInfo.split(' ');
      final userIdIndex = parts.indexOf('id');
      final passwordIndex = parts.indexOf('password');

      String? userId;
      String? password;

      if (userIdIndex != -1 && userIdIndex + 1 < parts.length) {
        userId = parts[userIdIndex + 1];
      }
      if (passwordIndex != -1 && passwordIndex + 1 < parts.length) {
        password = parts[passwordIndex + 1];
      }

      print("UserID: $userId");
      print("Password: $password");

      // userId와 password가 모두 있으면 로그인 처리
      if (userId != null && password != null) {
        bool isSuccess = await _loginService.login(context, userId, password);

        if (isSuccess) {
          // 로그인 성공 시에만 이동
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TdMain()),
            );
          }
        } else {
          print("자동 로그인 실패: 로그인 정보를 확인하세요.");
        }
      } else {
        print("로그인 정보가 불완전합니다.");
      }
    } else {
      print("저장된 로그인 정보가 없습니다.");
    }
  }

  void _login() async {
    final userId = _idcontroller.text;
    final password = _pwcontroller.text;

    if (userId.isEmpty || password.isEmpty) {
      Message(
        "아이디와 비밀번호를 모두 입력해주세요.",
        const Color(0xffFF6767), // 텍스트 색상
        const Color(0xff412C2C), // 배경 색상
        borderColor: const Color(0xffFF6767), // 테두리 색상
        icon: Icons.block, // 아이콘
      ).message(context);
      return;
    }

    bool isSuccess = await _loginService.login(context, userId, password);
    if (isSuccess) {
      // 로그인 성공 시 화면 전환
      final String? accessToken = await storage.read(key: "token");
      if (accessToken == null || accessToken.isEmpty) {
        await storage.write(
            key: "token",
            value: "your_generated_token_here"); // 실제 토큰을 받아와 저장해야 함
      }

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TdMain()),
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "로그인에 실패했습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/img/BG_image2.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: appBarPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(
                        height: 25,
                        child: Image.asset('assets/img/LRDominho.png')),
                    const SizedBox(width: 10),
                    const Text(
                      '도닦기',
                      style: TextStyle(
                          color: Color.fromARGB(210, 255, 255, 255),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.7),
                    )
                  ],
                ),
                const SizedBox(height: 30),
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
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 13),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 7.0,
                      sigmaY: 7.0,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'ID',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Pretendard",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 37,
                                  width: 280,
                                  child: CustomTextField(
                                          '아이디를 입력해 주세요.', _idcontroller,
                                          (value) {
                                    if (value == null || value.isEmpty) {
                                      return '아이디를 입력해 주세요.';
                                    }
                                    return null;
                                  }, false, 1)
                                      .textField(),
                                )
                              ]),
                          const SizedBox(height: 20.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'PW',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: 37,
                                  width: 280,
                                  child: CustomTextField(
                                          '비밀번호를 입력해 주세요.', _pwcontroller,
                                          (value) {
                                    if (value == null || value.isEmpty) {
                                      return '비밀번호를 입력해 주세요.';
                                    }
                                    return null;
                                  }, false, 1)
                                      .textField(),
                                )
                              ]),
                          const SizedBox(height: 20.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginregisterFindPassword(),
                                            ),
                                          );
                                        },
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 10.5, 15, 10.5),
                                          backgroundColor: const Color.fromARGB(
                                              255, 33, 33, 33),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                        ),
                                        child: const Text(
                                          '아이디/비밀번호 찾기',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ]),
                                Button(
                                  Colors.black,
                                  Colors.white,
                                  '로그인',
                                  () async {
                                    // SecureStorage에 데이터 저장
                                    await storage.write(
                                      key: "login",
                                      value:
                                          "id ${_idcontroller.text} password ${_pwcontroller.text}",
                                    );
                                    _login();
                                  },
                                ).button()
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
