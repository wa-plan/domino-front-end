import 'package:flutter/material.dart';
import 'package:domino/screens/ST/account_management.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/ST/password_provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

String receivedkey = 'abc';

final currentkey = GlobalKey<FormState>();
String currentPassword = '';
TextEditingController currentkeycontroller = TextEditingController(text: null);
final newkey = GlobalKey<FormState>();
String newPassword = '';
TextEditingController newkeycontroller = TextEditingController(text: null);
final checkkey = GlobalKey<FormState>();
String checkPassword = '';
TextEditingController checkkeycontroller = TextEditingController(text: null);

//텍스트폼필드 함수 만들기
currentTextFormField({
  required FormFieldSetter onSaved,
  required FormFieldValidator validator,
}) {
  return TextFormField(
    onSaved: onSaved,
    validator: validator,
    controller: currentkeycontroller,
    style: const TextStyle(fontSize: 16, color: Colors.white),
    decoration: InputDecoration(
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

//텍스트폼필드 함수 만들기
newTextFormField({
  required FormFieldSetter onSaved,
  required FormFieldValidator validator,
}) {
  return TextFormField(
    onSaved: onSaved,
    validator: validator,
    controller: newkeycontroller,
    style: const TextStyle(fontSize: 16, color: Colors.white),
    decoration: InputDecoration(
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

//텍스트폼필드 함수 만들기
checkTextFormField({
  required FormFieldSetter onSaved,
  required FormFieldValidator validator,
}) {
  return TextFormField(
    onSaved: onSaved,
    validator: validator,
    controller: checkkeycontroller,
    style: const TextStyle(fontSize: 16, color: Colors.white),
    decoration: InputDecoration(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountManagement(),
                      ));
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
            Form(
              key: currentkey,
              child: currentTextFormField(
                onSaved: (value) {
                  setState(() {
                    Provider.of<PasswordProvider>(context).currentpw = value;
                  });
                },
                validator: (value) {
                  if (value != receivedkey) {
                    return '비밀번호를 전확히 입력해주세요';
                  }
                  return null;
                },
              ),
            ),
            const Text(
              '새 비밀번호를 입력해 주세요.',
              style: TextStyle(color: Colors.white),
            ),
            Form(
              key: newkey,
              child: newTextFormField(
                onSaved: (value) {
                  setState(() {
                    Provider.of<PasswordProvider>(context).newpw = value;
                  });
                },
                validator: (value) {
                  if (value.length < 1) {
                    return '비밀번호는 8~16자리여야 해요.';
                  }
                  return null;
                },
              ),
            ),
            const Text(
              '새 비밀번호를 확인해 주세요.',
              style: TextStyle(color: Colors.white),
            ),
            Form(
              key: checkkey,
              child: checkTextFormField(
                onSaved: (value) {
                  setState(() {
                    Provider.of<PasswordProvider>(context).checkpw = value;
                  });
                },
                validator: (value) {
                  if (value.length < 1) {
                    return '새 비밀번호와 비밀번호 확인이 일치하지 않아요.';
                  }
                  return null;
                },
              ),
            ),
            Text(
              Provider.of<PasswordProvider>(context).currentpw,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
