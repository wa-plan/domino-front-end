import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/LR/login.dart';
import 'package:domino/apis/services/lr_services.dart'; // Import the new service

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

  bool _isPhoneVerified = false; // 상태 변수 추가

  @override
  void initState() {
    super.initState();
    _isPhoneVerified = false;
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
                onPressed: onClear ?? () {},
                icon: const Icon(Icons.clear_outlined),
              )
            : null,
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/img/BG_image.png'), // 배경 이미지
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
                /*Row(
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
                ),*/
                const SizedBox(height: 40),
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
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(59, 56, 56, 56),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "본인확인 및 본인인증",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Email',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: 257,
                                    height: 35,
                                    child: _buildTextFormField(
                                      hintText: '이메일을 입력해 주세요.',
                                      controller: _emailController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '이메일을 입력해 주세요.';
                                        }
                                        final emailRegex =
                                            RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                                        if (!emailRegex.hasMatch(value)) {
                                          return '유효한 이메일을 입력해 주세요.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Phone',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        width: 175,
                                        child: _buildTextFormField(
                                          hintText: '전화번호를 입력해 주세요.',
                                          controller: _phoneController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return '올바른 전화번호를 입력해 주세요.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              _isPhoneVerified =
                                                  true; // 버튼 클릭 시 상태 변경
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(50, 35),
                                          backgroundColor: Colors.black,
                                          shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
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
                                ],
                              ),
                              if (_isPhoneVerified)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          55, 15, 0, 15),
                                      child: SizedBox(
                                        height: 35,
                                        width: 270,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            labelText: '인증번호 4자리를 입력해 주세요.',
                                            labelStyle: const TextStyle(
                                              color: Color(0xff5C5C5C),
                                              fontSize: 13,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              borderSide: const BorderSide(
                                                color: Color(0xff5C5C5C),
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                          obscureText: true,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                      child: const Text(
                                        '인증',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(162, 43, 43, 43),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "아이디/비밀번호 생성",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ID',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 35,
                            width: 257,
                            child: _buildTextFormField(
                              hintText: '아이디를 만들어 주세요.',
                              controller: _idController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '아이디를 입력해 주세요.';
                                }
                                if (value.length < 3 || value.length > 15) {
                                  return '아이디는 3~15자로 입력해 주세요.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'PW',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 35,
                            width: 257,
                            child: _buildTextFormField(
                              hintText: '비밀번호를 만들어 주세요.',
                              controller: _pwController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '비밀번호를 입력해 주세요.';
                                }
                                if (value.length < 8 || value.length > 16) {
                                  return '비밀번호는 8~16자로 입력해 주세요.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'PW',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 35,
                            width: 257,
                            child: _buildTextFormField(
                              hintText: '비밀번호를 확인해 주세요.',
                              controller: _checkpwController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null ||
                                    value != _pwController.text) {
                                  return '비밀번호가 일치하지 않습니다.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 17.0),
                      Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(80, 35),
                            backgroundColor: Colors.black,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          child: const Text(
                            '계정생성',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
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
