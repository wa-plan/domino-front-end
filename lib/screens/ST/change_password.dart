import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/ST/password_provider.dart';
import 'package:domino/main.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

String receivedkey = 'abc';

final currentkey = GlobalKey<FormState>();
final newkey = GlobalKey<FormState>();
final checkkey = GlobalKey<FormState>();

//텍스트폼필드에 기본으로 들어갈 초기 텍스트 값
TextEditingController currentkeycontroller = TextEditingController(text: '');
TextEditingController newkeycontroller = TextEditingController(text: '');
TextEditingController checkkeycontroller = TextEditingController(text: '');

//텍스트폼필드 함수 만들기
Widget currentTextFormField({
  required FormFieldSetter<String?> onSaved,
  required FormFieldValidator<String?> validator,
}) {
  return TextFormField(
    onSaved: onSaved,
    validator: validator,
    controller: currentkeycontroller,
    style: const TextStyle(fontSize: 16, color: Colors.white),
    decoration: InputDecoration(
      hintText: '현재 비밀번호를 입력해 주세요.',
      hintStyle: const TextStyle(color: Colors.grey),
      border: const OutlineInputBorder(),
      suffixIcon: currentkeycontroller.text.isNotEmpty
          ? IconButton(
              onPressed: () {
                currentkeycontroller.clear();
              },
              icon: const Icon(Icons.clear_outlined),
            )
          : null,
    ),
  );
}

Widget newTextFormField({
  required FormFieldSetter<String?> onSaved,
  required FormFieldValidator<String?> validator,
}) {
  return TextFormField(
    onSaved: onSaved,
    validator: validator,
    controller: newkeycontroller,
    style: const TextStyle(fontSize: 16, color: Colors.white),
    decoration: InputDecoration(
      hintText: '새 비밀번호를 입력해 주세요.',
      hintStyle: const TextStyle(color: Colors.grey),
      border: const OutlineInputBorder(),
      suffixIcon: newkeycontroller.text.isNotEmpty
          ? IconButton(
              onPressed: () {
                newkeycontroller.clear();
              },
              icon: const Icon(Icons.clear_outlined),
            )
          : null,
    ),
  );
}

Widget checkTextFormField({
  required FormFieldSetter<String?> onSaved,
  required FormFieldValidator<String?> validator,
}) {
  return TextFormField(
    onSaved: onSaved,
    validator: validator,
    controller: checkkeycontroller,
    style: const TextStyle(fontSize: 16, color: Colors.white),
    decoration: InputDecoration(
      hintText: '비밀번호 확인을 입력해 주세요.',
      hintStyle: const TextStyle(color: Colors.grey),
      border: const OutlineInputBorder(),
      suffixIcon: checkkeycontroller.text.isNotEmpty
          ? IconButton(
              onPressed: () {
                checkkeycontroller.clear();
              },
              icon: const Icon(Icons.clear_outlined),
            )
          : null,
    ),
  );
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  void initState() {
    super.initState();
    // Provider 값을 초기화
    final passwordProvider =
        Provider.of<PasswordProvider>(context, listen: false);
    passwordProvider.currentpw = '';
    passwordProvider.newpw = '';
    passwordProvider.checkpw = '';
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
            Form(
              key: currentkey,
              child: currentTextFormField(
                onSaved: (value) {
                  Provider.of<PasswordProvider>(context, listen: false)
                      .currentpw = value ?? '';
                },
                validator: (value) {
                  if (value != receivedkey) {
                    return '비밀번호를 정확하게 입력해주세요';
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
            Form(
              key: newkey,
              child: newTextFormField(
                onSaved: (value) {
                  Provider.of<PasswordProvider>(context, listen: false).newpw =
                      value ?? '';
                },
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
            Form(
              key: checkkey,
              child: checkTextFormField(
                onSaved: (value) {
                  Provider.of<PasswordProvider>(context, listen: false)
                      .checkpw = value ?? '';
                },
                validator: (value) {
                  if (value !=
                      Provider.of<PasswordProvider>(context, listen: false)
                          .newpw) {
                    return '새 비밀번호와 비밀번호 확인이 일치하지 않아요.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                '혹시 비밀번호를 잊으셨나요?',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                width: double.infinity, // 부모의 최대 너비만큼 버튼의 너비를 설정
                child: SizedBox(
                  height: 60, // 버튼의 높이 설정
                  child: TextButton(
                    onPressed: () {
                      if (currentkey.currentState!.validate()) {
                        currentkey.currentState!.save();
                      }
                      if (newkey.currentState!.validate()) {
                        newkey.currentState!.save();
                      }
                      if (checkkey.currentState!.validate()) {
                        checkkey.currentState!.save();
                      }
                      // 값 비교
                      final currentPw =
                          Provider.of<PasswordProvider>(context, listen: false)
                              .currentpw;
                      final newPw =
                          Provider.of<PasswordProvider>(context, listen: false)
                              .newpw;
                      final checkPw =
                          Provider.of<PasswordProvider>(context, listen: false)
                              .checkpw;

                      if (currentPw == receivedkey &&
                          newPw.length > 7 &&
                          newPw.length < 17 &&
                          checkPw == newPw) {
                        // 초기화
                        currentkeycontroller.clear();
                        newkeycontroller.clear();
                        checkkeycontroller.clear();
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                        );
                      }
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
}
