import 'package:flutter/material.dart';
import 'package:domino/screens/ST/account_management.dart';
import 'package:domino/screens/ST/contact_us.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/apis/services/lr_services.dart'; // MorningAlertService를 가져옵니다

class SettingsMain extends StatefulWidget {
  const SettingsMain({super.key});

  @override
  State<SettingsMain> createState() => _SettingsMainState();
}

class _SettingsMainState extends State<SettingsMain> {
  bool morningAlert = false;
  bool nightAlert = false;

  // 아침 알림 설정을 서버에 전송하는 메서드
  void _updateMorningAlert(bool value) async {
    setState(() {
      morningAlert = value;
    });

    // MorningAlertService의 morningAlert 메서드를 호출합니다.
    await MorningAlertService.morningAlert(
      context,
      value ? 'on' : 'off',
    );
  }

  void _updateNightAlert(bool value) async {
    setState(() {
      nightAlert = value;
    });

    // nightAlertService의 nightAlert 메서드를 호출합니다.
    await NightAlertService.nightAlert(
      context,
      value ? 'on' : 'off',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(
            '설정',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: const Color(0xff262626),
      ),
      backgroundColor: const Color(0xff262626),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
        child: ListView(
          children: [
            const Text(
              '알림 설정',
              style: TextStyle(color: Colors.white),
            ),
            ListTile(
              title:
                  const Text('아침 알림받기', style: TextStyle(color: Colors.white)),
              subtitle: const Text('아침에 오늘의 일정을 정리해서 알려줘요.',
                  style: TextStyle(color: Colors.white)),
              trailing: Switch(
                value: morningAlert,
                onChanged: _updateMorningAlert, // 수정된 부분
              ),
            ),
            ListTile(
              title:
                  const Text('밤 알림받기', style: TextStyle(color: Colors.white)),
              subtitle: const Text('일정 체크를 까먹지 않게 한 번 더 상기시켜줘요.',
                  style: TextStyle(color: Colors.white)),
              trailing: Switch(value: nightAlert, onChanged: _updateNightAlert),
            ),
            ListTile(
              title: const Text('계정관리', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountManagement(),
                  ),
                );
              },
            ),
            const ListTile(
              title: Text('앱 사용설명서', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: const Text('문의하기', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUs(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
