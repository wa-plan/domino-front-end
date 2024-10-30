import 'package:domino/main.dart';
import 'package:domino/screens/LR/login.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/ST/change_password.dart';
import 'package:domino/widgets/popup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:domino/apis/services/lr_services.dart'; // Import the new service

class AccountManagement extends StatefulWidget {
  const AccountManagement({super.key});

  @override
  State<AccountManagement> createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
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
                  '계정관리',
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
                '내 계정',
                style: TextStyle(color: Colors.white),
              ),
              Expanded(
                  child: ListView(
                children: [
                  const AccountInfo(infoType: '이메일', info: 'new7932@naver.com'),
                  const AccountInfo(infoType: '휴대폰 번호', info: '010 7536 7932'),
                  const AccountInfo(infoType: '로그인 정보', info: '카카오톡'),
                  ListTile(
                    title: const Text('비밀번호 변경',
                        style: TextStyle(color: Colors.white)),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePassword(),
                          ));
                    },
                  ),
                  ListTile(
                    title: const Text('로그아웃',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      _logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('탈퇴하기',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      PopupDialog.show(
                        context,
                        '이건 아니야.. \n정말 떠날거야...?',
                        true, // cancel
                        false, // delete
                        true, // signout
                        false,
                        onCancel: () {
                          // 취소 버튼을 눌렀을 때 실행할 코드
                          Navigator.of(context).pop();
                        },

                        onDelete: () {
                          // 삭제 버튼을 눌렀을 때 실행할 코드
                        },
                        onSignOut: () {
                          // 탈퇴 버튼을 눌렀을 때 실행할 코드
                          SignOutService.signOut(context);
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyApp(),
                              ));
                        },
                      );
                    },
                  )
                ],
              ))
            ],
          ),
        ));
  }
}

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key, required this.infoType, required this.info});
  final String infoType;
  final String info;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        infoType,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: Text(
        info,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
      ),
    );
  }
}

void _logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('authToken');
}
