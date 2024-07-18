import 'package:domino/screens/DP/create_confirm_page.dart';
import 'package:domino/screens/DP/create_input1_page.dart';
import 'package:domino/widgets/DP/smallgrid_with_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class DPcreate99Page extends StatelessWidget {
  const DPcreate99Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff262627),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff262626),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Text(
              '플랜 만들기',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '목표를 이루기 위한 \n작은 계획들을 세워봐요.',
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
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle, color: Color(0xffFCFF62)),
                    child: Text(
                        context.watch<SelectFinalGoalModel>().selectedFinalGoal,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ))),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: [
                    const SmallgridWithData(goalId: 0),
                    const SmallgridWithData(goalId: 1),
                    const SmallgridWithData(goalId: 2),
                    const SmallgridWithData(goalId: 3),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DPcreateInput1Page(),
                            ));
                      },
                      child: SizedBox(
                        width: 100,
                        child: GridView.count(
                          crossAxisCount: 3,
                          children: List.generate(9, (index) {
                            if (index == 4) {
                              return Container(
                                color: const Color(0xffFCFF62),
                                margin: const EdgeInsets.all(1.0),
                                child: Text(
                                  context
                                      .watch<SelectFinalGoalModel>()
                                      .selectedFinalGoal,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
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
                                color: const Color(0xff929292),
                                margin: const EdgeInsets.all(1.0),
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }
                          }),
                        ),
                      ),
                    ),
                    const SmallgridWithData(goalId: 5),
                    const SmallgridWithData(goalId: 6),
                    const SmallgridWithData(goalId: 7),
                    const SmallgridWithData(goalId: 8),
                  ],
                )),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff131313),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: const Text(
                    '이전',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DPcreateConfirmPage(),
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
              ],
            )));
  }
}
