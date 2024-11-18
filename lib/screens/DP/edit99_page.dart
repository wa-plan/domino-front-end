//DP 수정 메인 페이지
import 'package:domino/screens/DP/edit_create_color_page.dart';
import 'package:domino/screens/DP/edit_create_input1_page.dart';
import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/edit_smallgrid_with_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class Edit99Page extends StatelessWidget {
  final String mandalart;
  final int mandalartId;

  const Edit99Page({
    super.key,
    required this.mandalart,
    required this.mandalartId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: appBarPadding,
            child: Text(
              '플랜 수정하기',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          backgroundColor: backgroundColor,
        ),
        body: Padding(
            padding: fullPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '플랜을 수정할 수 있어요.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 43,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xffFCFF62),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    child: Text(
                        textAlign: TextAlign.center,
                        mandalart,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ))),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0.5,
                      mainAxisSpacing: 0.5),
                  children: [
                    EditSmallgridwithdata(goalId: 0, mandalart: mandalart,),
                    EditSmallgridwithdata(goalId: 1, mandalart: mandalart,),
                    EditSmallgridwithdata(goalId: 2, mandalart: mandalart,),
                    EditSmallgridwithdata(goalId: 3, mandalart: mandalart,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditInput1Page(
                                mandalart: mandalart,
                              ),
                            ));
                      },
                      child: Expanded(
                        child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 0.5,
                            mainAxisSpacing: 0.5,
                          ),
                          children: [
                            // Index 0
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: context
                                            .watch<GoalColor>()
                                            .selectedGoalColor['0'] ==
                                        Colors.transparent
                                    ? const Color(0xff929292)
                                    : context
                                        .watch<GoalColor>()
                                        .selectedGoalColor['0'],
                              ),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                  context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('0')
                                      ? context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['0'] ??
                                          ''
                                      : '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                                ),
                              ),
                            ),
                            // Index 1
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: context
                                            .watch<GoalColor>()
                                            .selectedGoalColor['1'] ==
                                        Colors.transparent
                                    ? const Color(0xff929292)
                                    : context
                                        .watch<GoalColor>()
                                        .selectedGoalColor['1'],
                              ),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                  context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('1')
                                      ? context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['1'] ??
                                          ''
                                      : '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                                ),
                              ),
                            ),
                            // Index 2
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: context
                                            .watch<GoalColor>()
                                            .selectedGoalColor['2'] ==
                                        Colors.transparent
                                    ? const Color(0xff929292)
                                    : context
                                        .watch<GoalColor>()
                                        .selectedGoalColor['2'],
                              ),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                  context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('2')
                                      ? context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['2'] ??
                                          ''
                                      : '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                                ),
                              ),
                            ),
                            // Index 3
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: context
                                            .watch<GoalColor>()
                                            .selectedGoalColor['3'] ==
                                        Colors.transparent
                                    ? const Color(0xff929292)
                                    : context
                                        .watch<GoalColor>()
                                        .selectedGoalColor['3'],
                              ),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                  context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('3')
                                      ? context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['3'] ??
                                          ''
                                      : '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                                ),
                              ),
                            ),
                            // Index 4 (Special handling)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: const Color(0xffFCFF62),
                              ),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                  mandalart,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            // Index 5
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: context
                                            .watch<GoalColor>()
                                            .selectedGoalColor['5'] ==
                                        Colors.transparent
                                    ? const Color(0xff929292)
                                    : context
                                        .watch<GoalColor>()
                                        .selectedGoalColor['5'],
                              ),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                  context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('5')
                                      ? context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['5'] ??
                                          ''
                                      : '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                                ),
                              ),
                            ),
                            // Index 6
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: context
                                            .watch<GoalColor>()
                                            .selectedGoalColor['6'] ==
                                        Colors.transparent
                                    ? const Color(0xff929292)
                                    : context
                                        .watch<GoalColor>()
                                        .selectedGoalColor['6'],
                              ),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                  context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('6')
                                      ? context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['6'] ??
                                          ''
                                      : '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                                ),
                              ),
                            ),
                            // Index 7
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: context
                                            .watch<GoalColor>()
                                            .selectedGoalColor['7'] ==
                                        Colors.transparent
                                    ? const Color(0xff929292)
                                    : context
                                        .watch<GoalColor>()
                                        .selectedGoalColor['7'],
                              ),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                  context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('7')
                                      ? context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['7'] ??
                                          ''
                                      : '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                                ),
                              ),
                            ),
                            // Index 8
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: context
                                            .watch<GoalColor>()
                                            .selectedGoalColor['8'] ==
                                        Colors.transparent
                                    ? const Color(0xff929292)
                                    : context
                                        .watch<GoalColor>()
                                        .selectedGoalColor['8'],
                              ),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                  context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('8')
                                      ? context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['8'] ??
                                          ''
                                      : '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    EditSmallgridwithdata(goalId: 5, mandalart: mandalart,),
                    EditSmallgridwithdata(goalId: 6, mandalart: mandalart,),
                    EditSmallgridwithdata(goalId: 7, mandalart: mandalart,),
                    EditSmallgridwithdata(goalId: 8, mandalart: mandalart,),
                  ],
                )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                builder: (context) => EditColorPage(
                                  mandalart: mandalart,
                                ),
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
                    ]),
                const SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}
