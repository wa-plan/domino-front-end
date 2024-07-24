import 'package:domino/screens/DP/create_select_page.dart';
import 'package:flutter/material.dart';

class DPlistPage extends StatelessWidget {
  const DPlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff262626),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              PopupMenuButton(
                iconColor: const Color(0xff5C5C5C),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                        value: 'edit',
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                          '삭제하기',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ))),
                    const PopupMenuItem(
                        value: 'delete',
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                          '수정하기',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ))),
                  ];
                },
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      print('edit');
                      break;
                    case 'delete':
                      print('delete');
                      break;
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                color: const Color(0xff5C5C5C),
                iconSize: 35.0, // 아이콘 크기 조절
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DPcreateSelectPage(),
                    ),
                  );
                },
              ),
            ]),

            const SizedBox(
              height: 20,
            ),

            const Text(
              '목표를 달성할 수 있는 \n 플랜을 만들어 봐요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff5C5C5C),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),

            // PageView()
          ],
        ),
      ),
    );
  }
}
