/*import 'package:flutter/material.dart';
import 'package:domino/screens/MG/mygoal_profile_edit.dart';
import 'package:domino/apis/mg_api_fucntion.dart';


class MyGoal extends StatefulWidget {
  const MyGoal({super.key});

  @override
  State<MyGoal> createState() => _MyGoalState();
}

class _MyGoalState extends State<MyGoal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(
            '나의 목표',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.edit)), 
            color: Colors.white,
          // 프로필 편집 mygoal_profile_edit.dart
        ),
        backgroundColor: const Color(0xff262626),
        Container(width: 500,
          children[ 
            Divider(color: Colors.red, thickness: 2.0),
            Text(
            '쓰러트릴 목표',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.bold),
            ), 
            Text(
            mainAxisAlignment: mainAxisAlignment.center,
            '새로운 목표를 세워볼까요?',
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold),
            ), 
            IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.add)), 
            color: Colors.white,
          // 나의 목표 추가 edit
           ],
          ),
      ),
      backgroundColor: const Color(0xff262626),
),
  },
}

class _cheering extends State<MyGoal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          const Text(
                  '오늘의 응원',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all();
                    Navigator.of(context).pop();
                  ),
                Text(
                  overflow: TextOverflow.ellipsis, 
                  '$_message',
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600
                  )
                ),
          // 오늘의 응원 랜덤 메시지
        ),
        backgroundColor: const Color(0xff262626),
        Container(width: 500,
          children[ 
            Divider(color: Colors.red, thickness: 2.0),
            Text(
            '쓰러트린 목표',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.bold),
            ), 
            Text(
            mainAxisAlignment: mainAxisAlignment.center,
            '함께 목표를 쓰러트려봐요',
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold),
            ), 
           ],
          ),
      ),
      backgroundColor: const Color(0xff262626),
      Container(width: 500,
          children[ 
            Divider(color: Colors.red, thickness: 2.0),
            Text(
            '쓰러트리지 못한 목표',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.bold),
            ), 
            Text(
            mainAxisAlignment: mainAxisAlignment.center,
            '쓰러트리지 못한 목표가 없어요요',
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold),
            ), 
           ],
          ),
      ),
),
  },
}
*/