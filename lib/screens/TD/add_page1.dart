import 'package:domino/main.dart';
import 'package:flutter/material.dart';

import 'package:domino/screens/TD/add_page2.dart';
import 'package:domino/widgets/DP/smallgrid_with_data.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:provider/provider.dart';

class AddPage1 extends StatefulWidget {
  const AddPage1({super.key});

  @override
  State<AddPage1> createState() => _AddPage1State();
}

class _AddPage1State extends State<AddPage1> {
  String? selectedGoal;
  String nextStage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(
            '도미노 만들기',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: const Color(0xff262626),
      ),
      backgroundColor: const Color(0xff262626),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '어떤 목표를 달성하기 위한 \n도미노인가요?',
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
                  height: 43,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: const Color(0xff5C5C5C),
                      )),
                  child: DropdownButton<String>(
                    value: selectedGoal,
                    items: const [
                      DropdownMenuItem(
                          value: 'Goal.1',
                          child: Text('환상적인 세계 여행',
                              style: TextStyle(color: Colors.white))),
                      DropdownMenuItem(
                          value: 'Goal.2',
                          child: Text('2023년 1학기 올A',
                              style: TextStyle(color: Colors.white))),
                      DropdownMenuItem(
                          value: 'Goal.3',
                          child: Text('10kg 감량하기',
                              style: TextStyle(color: Colors.white))),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        selectedGoal = value;
                      });
                    },
                    isExpanded: true,
                    dropdownColor: const Color(0xff262626),
                    style: const TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.white,
                    underline: Container(),
                  ),
                ),
              ],
            ),
            if (selectedGoal != null) ...[
              const SizedBox(height: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('어떤 플랜과 관련됐나요?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        children: [
                          const Smallgridwithdata(goalId: 0),
                          const Smallgridwithdata(goalId: 1),
                          const Smallgridwithdata(goalId: 2),
                          const Smallgridwithdata(goalId: 3),
                          SizedBox(
                            width: 100,
                            child: GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              children: List.generate(9, (index) {
                                if (index == 4) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: const Color(0xffFCFF62),
                                    ),
                                    margin: const EdgeInsets.all(1.0),
                                    child: Center(
                                        child: Text(
                                      context
                                          .watch<SelectFinalGoalModel>()
                                          .selectedFinalGoal,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )),
                                  );
                                } else {
                                  final inputtedDetailGoals = context
                                      .watch<SaveInputtedDetailGoalModel>()
                                      .inputtedDetailGoal;
                                  final value = inputtedDetailGoals
                                          .containsKey(index.toString())
                                      ? inputtedDetailGoals[index.toString()]
                                      : '';

                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: const Color(0xff929292),
                                    ),
                                    margin: const EdgeInsets.all(1.0),
                                    child: Center(
                                        child: Text(
                                      value!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    )),
                                  );
                                }
                              }),
                            ),
                          ),
                          const Smallgridwithdata(goalId: 5),
                          const Smallgridwithdata(goalId: 6),
                          const Smallgridwithdata(goalId: 7),
                          const Smallgridwithdata(goalId: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff131313),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: const Text(
                    '취소',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ), //취소 버튼
                if (selectedGoal != null)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPage2(),
                          ));
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff131313),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0))),
                    child: const Text(
                      '다음',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ), //다음 버튼
              ],
            ),
          ],
        ),
      ),
    );
  }
}
