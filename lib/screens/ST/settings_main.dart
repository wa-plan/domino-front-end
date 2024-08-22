import 'package:flutter/material.dart';
import 'package:domino/screens/ST/account_management.dart';
import 'package:domino/screens/ST/contact_us.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/apis/services/lr_services.dart'; // MorningAlertService를 가져옵니다
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsMain extends StatefulWidget {
  const SettingsMain({super.key});

  @override
  State<SettingsMain> createState() => _SettingsMainState();
}

class _SettingsMainState extends State<SettingsMain> {
  bool morningAlert = false;
  bool nightAlert = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      morningAlert = prefs.getBool('morningAlert') ?? false;
      nightAlert = prefs.getBool('nightAlert') ?? false;
    });
  }

  // 아침 알림 설정을 서버에 전송하는 메서드
  void _updateMorningAlert(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      morningAlert = value;
    });

    final result = await MorningAlertService.morningAlert(
      context,
      morningAlert ? 'ON' : 'OFF',
    );

    if (result == 'ON' || result == 'OFF') {
      // 성공적으로 요청이 완료된 경우
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('morningAlert', value); // 설정을 저장
    } else {
      // 요청이 실패한 경우
      setState(() {
        morningAlert = !value; // 상태를 원래대로 되돌림
      });
    }

    if (result == null) {
      // 오류 발생 시 상태를 원래대로 되돌림
      setState(() {
        morningAlert = !value;
      });
      Fluttertoast.showToast(
        msg: '아침 알림 설정을 업데이트하지 못했습니다.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      prefs.setBool('morningAlert', morningAlert);
    }
  }

  void _updateNightAlert(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nightAlert = value;
    });

    final result = await NightAlertService.nightAlert(
      context,
      nightAlert ? 'ON' : 'OFF',
    );

    if (result == 'ON' || result == 'OFF') {
      // 성공적으로 요청이 완료된 경우
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('nightAlert', value); // 설정을 저장
    } else {
      // 요청이 실패한 경우
      setState(() {
        nightAlert = !value; // 상태를 원래대로 되돌림
      });
    }

    if (result == null) {
      // 오류 발생 시 상태를 원래대로 되돌림
      setState(() {
        nightAlert = !value;
      });
      Fluttertoast.showToast(
        msg: '저녁 알림 설정을 업데이트하지 못했습니다.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      prefs.setBool('nightAlert', nightAlert);
    }
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
                  onChanged: (value) {
                    _updateMorningAlert(value);
                  } // 수정된 부분
                  ),
            ),
            ListTile(
              title:
                  const Text('밤 알림받기', style: TextStyle(color: Colors.white)),
              subtitle: const Text('일정 체크를 까먹지 않게 한 번 더 상기시켜줘요.',
                  style: TextStyle(color: Colors.white)),
              trailing: Switch(
                  value: nightAlert,
                  onChanged: (value) {
                    _updateNightAlert(value);
                  }),
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
