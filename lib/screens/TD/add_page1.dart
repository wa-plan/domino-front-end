import 'package:domino/main.dart';
import 'package:flutter/material.dart';

import 'package:domino/screens/TD/add_page2.dart';
import 'package:domino/widgets/DP/smallgridWithData.dart';
import 'package:domino/screens/TD/add_page2.dart';
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
                  DropdownMenuItem(value: 'Goal.1', child: Text('환상적인 세계 여행')),
                  DropdownMenuItem(
                      value: 'Goal.2', child: Text('2023년 1학기 올A')),
                  DropdownMenuItem(value: 'Goal.3', child: Text('10kg 감량하기')),
                ],
                onChanged: (String? value) {
                  setState(() {
                    selectedGoal = value;
                    nextStage = '어떤 플랜과 관련됐나요?';
                  });
                },
                isExpanded: true,
                dropdownColor: const Color(0xff262626),
                style: const TextStyle(color: Colors.white),
                iconEnabledColor: Colors.white,
                underline: Container(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
              children: [
                const smallgridWithData(goalId: 0),
                const smallgridWithData(goalId: 1),
                const smallgridWithData(goalId: 2),
                const smallgridWithData(goalId: 3),
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
                        final value =
                            inputtedDetailGoals.containsKey(index.toString())
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
                            value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          )),
                        );
                      }
                    }),
                  ),
                ),
                const smallgridWithData(goalId: 5),
                const smallgridWithData(goalId: 6),
                const smallgridWithData(goalId: 7),
                const smallgridWithData(goalId: 8),
              ],
            )),
            Text(nextStage,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 480,
            ),
            Row(children: [
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

              TextButton(
                //임의버튼(만다라트 대용버튼)
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
              )
            ])
          ],
        ),
      ),
    );
  }
}
