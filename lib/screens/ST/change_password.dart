import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:domino/screens/LR/loginregister_find_password.dart';

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
                '비밀번호 변경',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child:Padding(
        padding: fullPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '현재 비밀번호',
                      style: TextStyle(
                          color: Color(0xff949494),
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '현재 비밀번호를 입력해 주세요.',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    SizedBox(
                      height: 35,
                      width: double.infinity,
                      child: _buildTextFormField(
                        hintText: '8~16자',
                        controller: _currentkeycontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호를 입력해 주세요.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LoginregisterFindPassword(),
                        ));
                  },
                  child: const Text(
                    '혹시 비밀번호를 잊으셨나요?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 14),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xff2A2A2A),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '새 비밀번호',
                    style: TextStyle(
                        color: Color(0xff949494), fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '새 비밀번호를 입력해 주세요.',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  SizedBox(
                    height: 35,
                    width: 350,
                    child: _buildTextFormField(
                      hintText: '8~16자',
                      controller: _newkeycontroller,
                      validator: (value) {
                        if (value == null ||
                            value.length < 8 ||
                            value.length > 16) {
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
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 35,
                    width: 350,
                    child: _buildTextFormField(
                      hintText: '',
                      controller: _checkkeycontroller,
                      validator: (value) {
                        if (value != _newkeycontroller.text) {
                          return '비밀번호가 일치하지 않습니다.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(const Color(0xffFF6767)),
                    ),
                    child: const Text('비밀번호 변경하기',
                        style: TextStyle(
                            color: backgroundColor, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),),
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
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10.0),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xffBFBFBF), fontSize: 13, fontWeight: FontWeight.w400),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(
            color:Color(0xffBFBFBF),
            width: 0.5
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(
            color:Color(0xffBFBFBF),
            width: 0.5
          )
        ),
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
}
