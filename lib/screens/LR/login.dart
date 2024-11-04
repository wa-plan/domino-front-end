import 'package:domino/screens/LR/loginregister_find_password.dart';
import 'package:domino/styles.dart';
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
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(10.0),
        hintStyle: const TextStyle(
            color: Color(0xffBFBFBF),
            fontSize: 13,
            fontWeight: FontWeight.w400),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 147, 147, 147), width: 0.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 147, 147, 147), width: 0.5)),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: appBarPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  Image.asset('assets/img/LRDominho.png'),
                  const SizedBox(width: 15),
                  const Text(
                    '도닦기에 오신 것을\n환영합니다.',
                    style: TextStyle(
                        color: Color.fromARGB(210, 255, 255, 255),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        height: 1.7),
                  )
                ],
              ),
              const SizedBox(height: 40),
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
              const SizedBox(height: 13),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(3),
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
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 35,
                            width: 280,
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
                            height: 35,
                            width: 280,
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
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                                        fontWeight: FontWeight.w400),
                                  ),
                                  MyCheckBox(),
                                ]),
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
                                          fontWeight: FontWeight.w400),
                                    ))
                              ]),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(2))),
                            child: const Text(
                              '로그인',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          )
                        ]),
                  ],
                ),
              ),
            ],
          ),
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
      activeColor: mainRed,
      checkColor: Colors.black,
      onChanged: (value) {
        setState(() {
          _isCheck = value ?? false;
        });
      },
    );
  }
}
