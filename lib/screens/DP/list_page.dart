import 'package:domino/screens/DP/create_select_page.dart';
import 'package:flutter/material.dart';
import 'package:domino/widgets/TD/nav_bar.dart';

class DPlistPage extends StatelessWidget {
  const DPlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff262626),
        appBar: AppBar(
          backgroundColor: const Color(0xff262626),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Text(
              '도미노 플랜',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  color: const Color(0xff5C5C5C),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DPcreateSelectPage(),
                        ));
                  },
                ),

                Container() //PageView()
              ],
            )),
        bottomNavigationBar: const NavBar());
  }
}
