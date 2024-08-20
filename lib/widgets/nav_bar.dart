import 'package:domino/screens/MG/mygoal_create.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/nav_provider.dart';

import 'package:domino/screens/DP/list_page.dart';
import 'package:domino/screens/TD/td_main.dart';
import 'package:domino/screens/ST/settings_main.dart';
import 'package:domino/screens/MG/mygoal_main.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavBarProvider>(context);
    final int selectedIndex = navBarProvider.selectedIndex;

    return BottomNavigationBar(
      backgroundColor: const Color(0xff262626),
      selectedItemColor: const Color(0xffF6C92B),
      selectedFontSize: 12,
      unselectedItemColor: const Color(0xffBDBDBD),
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (index) {
        navBarProvider.setIndex(index);
        _onItemTapped(context, index);
      },
      items: [
        BottomNavigationBarItem(
          icon:
              Image.asset('assets/img/vector1.png', width: 15.73, height: 21.0),
          label: '나의 목표',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/img/vector2.png', width: 21, height: 21.0),
          label: '도미노 플랜',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/img/vector3.png', width: 25, height: 25.0),
          label: '오늘의 도미노',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/img/vector4.png', width: 23, height: 23.0),
          label: '설정',
        ),
      ],
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    // Use Navigator to navigate to different pages based on the index
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyGoal()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DPlistPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const TdMain()), // 현재 화면으로 돌아오기
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SettingsMain()),
        );
        break;
      default:
        break;
    }
  }
}
