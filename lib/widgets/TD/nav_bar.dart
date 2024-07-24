import 'package:domino/main.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/ST/settings_main.dart';
import 'package:domino/screens/DP/list_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DPlistPage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DPlistPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsMain()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xff262626),
      selectedItemColor: const Color(0xffF6C92B),
      selectedFontSize: 12,
      unselectedItemColor: const Color(0xffBDBDBD),
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
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
}
