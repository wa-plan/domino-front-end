import 'package:domino/apis/services/mg_services.dart';
import 'package:domino/screens/MG/mygoal_goal_detail.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/MG/mygoal_profile_edit.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/screens/MG/mygoal_goal_add.dart';

class MyGoal extends StatefulWidget {
  const MyGoal({super.key});

  @override
  State<MyGoal> createState() => _MyGoalState();
}

class _MyGoalState extends State<MyGoal> {

  final String message = "실패하는 것이 두려운 게 아니라\n노력하지 않는 것이 두렵다.";


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
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xff262626),
      ),
      bottomNavigationBar: const NavBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(35.0, 20, 35.0, 25.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xff5C5C5C), width: 1),
                    shape: BoxShape.circle,
                  ),

                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '당신은 어떤 사람인가요?',
                      style: TextStyle(color: Color(0xff5C5C5C)),

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '프로필 편집을 통해 \n자신을 표현해주세요.',
                      style: TextStyle(color: Color(0xff5C5C5C)),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileEdit(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  color: const Color(0xff5C5C5C),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Color(0xff5C5C5C), thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '쓰러트릴 목표',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyGoalAdd(),
                          ),
                        );
                        // 나의 목표 추가 기능
                      },
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                    ),
                    /*IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyGoalDetail(),
                              ),
                            );
                            // 나의 목표 추가 기능
                          },
                          icon: const Icon(Icons.add),
                          color: Colors.white,
                        ),*/
                  ],
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 170,
                  child: PageView(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.yellow),
                                        SizedBox(width: 10),
                                        Text(
                                          '환상적인 세계여행',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'D-200',
                                          style: TextStyle(
                                            color: Color(0xff5C5C5C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 53, 53, 53),
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                        ),
                                        width: 250,
                                        height: 80,
                                        child: const Center(
                                            child: Text(
                                          '이미지를 추가해 주세요',
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                    const SizedBox(height: 10),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Column(children: [
                                            Text(
                                              '나의 도미노',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              '80개',
                                              style: TextStyle(
                                                  color: Color(0xffFCFF62),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ]),
                                          const SizedBox(width: 15),
                                          SizedBox(
                                              child: Image.asset(
                                                  'assets/img/MG_domino.png')),
                                        ])
                                  ],
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFCFF62),
                                      borderRadius: BorderRadius.circular(3.0),
                                    ),
                                    width: 15,
                                    height: 170),
                              ]))
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                Text(
                  '오늘의 응원',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: const Color(0xff5C5C5C),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Text(
                  '쓰러트린 목표',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(child: Image.asset('assets/img/MG_domino2.png')),
                const SizedBox(height: 30.0),
                Text(
                  '쓰러트리지 못한 목표',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(child: Image.asset('assets/img/MG_domino3.png')),
              ],
            ),
          ],
        ),
      )),
      backgroundColor: const Color(0xff262626),
    );
  }
}
