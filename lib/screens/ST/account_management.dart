import 'package:flutter/material.dart';
import 'package:domino/screens/ST/change_password.dart';
import 'package:domino/screens/ST/settings_main.dart';

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsMain(),
                        ));
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
                  const ListTile(
                    title: Text('로그아웃', style: TextStyle(color: Colors.white)),
                  )
                ],
              ))
            ],
          ),
          /*const Row(
                children: [
                  Text(
                    '이메일',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    width: 130,
                  ),
                  Text('new7932@naver.com',
                      style: TextStyle(color: Colors.white, fontSize: 16))
                ],
              ),
              ListView(children: const [
                ListTile(
                  title: Text(
                    '휴대폰 번호',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    '010 7536 0000',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ])*/
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
