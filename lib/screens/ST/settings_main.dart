import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/ST/account_management.dart';
import 'package:domino/screens/ST/contact_us.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/apis/services/lr_services.dart';
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
      prefs.setBool('morningAlert', value);
    } else {
      setState(() {
        morningAlert = !value;
      });
    }

    if (result == null) {
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
      prefs.setBool('nightAlert', value);
    } else {
      setState(() {
        nightAlert = !value;
      });
    }

    if (result == null) {
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Padding(
          padding: appBarPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '설정',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              /*const Icon(
                Icons.settings,
                color: Colors.white,)*/
            ],
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: fullPadding,
        child: Column(
          children: [
            const SizedBox(height: 15),
            _buildSettingItem(
              menu: '계정',
              title: '내 계정',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountManagement(),
                  ),
                );
              },
            ),
            _buildCombinedSwitchItem(),
            _buildSettingItem(
              menu: '문의',
              title: '문의하기',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUs(),
                  ),
                );
              },
            ),
            _buildSettingItem(menu: '도움', title: '앱 사용설명서',
            onTap: () {
                
              },),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget _buildSettingItem(
      {required String menu, required String title, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 14),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xff2A2A2A),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(menu, style: const TextStyle(color: Color(0xff949494))),
            const SizedBox(height: 9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                if (onTap != null)
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xffD4D4D4),
                    size: 17,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCombinedSwitchItem() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 14),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xff2A2A2A),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('알림', style: TextStyle(color: Color(0xff949494))),
          const SizedBox(height: 9),
          Row(
            
            children: [
              const Text('아침 알림', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              const SizedBox(width: 13),
              const Text('일정 정리', style: TextStyle(color: Color(0xffD4D4D4), fontSize: 12, fontWeight: FontWeight.w300)),
              const Spacer(),
              Transform.scale(
              scale: 0.8, // Switch 크기 줄이기
              child: 
              SizedBox(
                height: 10,
                child: Switch(
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xff18AD00),
                  inactiveTrackColor: const Color(0xff5D5D5D),
                  inactiveThumbColor: Colors.white,
                  value: morningAlert,
                  onChanged: _updateMorningAlert,
                ),
              ),)
            ],
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              const Text('밤 알림', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              const SizedBox(width: 13),
              const Text('일정 리마인드', style: TextStyle(color: Color(0xffD4D4D4), fontSize: 12, fontWeight: FontWeight.w300)),
              const Spacer(),
              Transform.scale(
              scale: 0.8, // Switch 크기 줄이기
              child: 
              SizedBox(
                height: 10,
                child: Switch(
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xff18AD00),
                  inactiveTrackColor: const Color(0xff5D5D5D),
                  inactiveThumbColor: Colors.white,
                  value: nightAlert,
                  onChanged: _updateNightAlert,
                ),
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
