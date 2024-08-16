import 'package:flutter/material.dart';
import 'package:domino/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:domino/screens/LR/loginregister_find_password.dart';
import 'package:domino/apis/services/lr_services.dart'; // 서비스 파일 import

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _currentkeycontroller = TextEditingController();
  final _newkeycontroller = TextEditingController();
  final _checkkeycontroller = TextEditingController();

  @override
  void dispose() {
    _currentkeycontroller.dispose();
    _newkeycontroller.dispose();
    _checkkeycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 20.0, 20.0, 0.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: Colors.white,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '비밀번호 변경',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xff262626),
      ),
      backgroundColor: const Color(0xff262626),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '현재 비밀번호를 입력해 주세요.',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 350,
              child: _buildTextFormField(
                hintText: '비밀번호를 입력해 주세요.',
                controller: _currentkeycontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력해 주세요.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '새 비밀번호를 입력해 주세요.',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 350,
              child: _buildTextFormField(
                hintText: '8~16자를 입력해 주세요.',
                controller: _newkeycontroller,
                validator: (value) {
                  if (value == null || value.length < 8 || value.length > 16) {
                    return '비밀번호는 8~16자리여야 해요.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '새 비밀번호를 확인해 주세요.',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              width: 350,
              child: _buildTextFormField(
                hintText: '비밀번호를 다시 입력해 주세요.',
                controller: _checkkeycontroller,
                validator: (value) {
                  if (value != _newkeycontroller.text) {
                    return '비밀번호가 일치하지 않습니다.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginregisterFindPassword(),
                    ));
              },
              child: const Text(
                '혹시 비밀번호를 잊으셨나요?',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: SizedBox(
                  height: 60,
                  child: TextButton(
                    onPressed: () async {
                      if (_newkeycontroller.text != _checkkeycontroller.text) {
                        Fluttertoast.showToast(
                          msg: '새 비밀번호가 일치하지 않습니다.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        return;
                      }
/*
                      // 비밀번호 변경 요청
                      final success =
                          await ChangePasswordService.changePassword(
                        currentPassword: _currentkeycontroller.text,
                        newPassword: _newkeycontroller.text,
                      );

                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                        );
                      }*/
                    },
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                    ),
                    child: const Text('비밀번호 변경하기',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          border: const OutlineInputBorder(),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: onClear ?? () {},
                  icon: const Icon(Icons.clear_outlined),
                )
              : null,
        ),
        validator: validator,
      ),
    );
  }
}
