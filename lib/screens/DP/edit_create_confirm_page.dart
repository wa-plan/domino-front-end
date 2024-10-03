import 'package:domino/screens/DP/edit_create_color_page.dart';
import 'package:domino/widgets/DP/confirm_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class EditConfirmPage extends StatelessWidget {
  final String mandalart;
  const EditConfirmPage({super.key, required this.mandalart});

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
              '플랜 수정하기',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '작성한 내용을 확인해주세요.',
                  style: TextStyle(
                      color: Colors.white,
                     fontSize: 17,
                      fontWeight: FontWeight.w500,
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
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        color: Color(0xffFCFF62)),
                    child: Text(mandalart,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ))),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                    child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1),
                  children: [
                     ConfirmBox(actionPlanid: 0, detailGoalid: 0),
                     ConfirmBox(actionPlanid: 1, detailGoalid: 1),
                     ConfirmBox(actionPlanid: 2, detailGoalid: 2),
                     ConfirmBox(actionPlanid: 3, detailGoalid: 3),
                    SizedBox(
                      width: 100,
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                        ),
                        children: [
                          // Index 0
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('0') &&
                                      (context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['0']
                                              ?.isNotEmpty ??
                                          false)
                                  ? context
                                              .watch<GoalColor>()
                                              .selectedGoalColor['0'] ==
                                          Colors.transparent
                                      ? const Color(0xff929292)
                                      : context
                                          .watch<GoalColor>()
                                          .selectedGoalColor['0']
                                  : Colors
                                      .transparent, // Set color to transparent if the text is empty
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
                        fontSize: 11),
                              ),
                            ),
                          ),

                          // Index 1
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('1') &&
                                      (context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['1']
                                              ?.isNotEmpty ??
                                          false)
                                  ? context
                                              .watch<GoalColor>()
                                              .selectedGoalColor['1'] ==
                                          Colors.transparent
                                      ? const Color(0xff929292)
                                      : context
                                          .watch<GoalColor>()
                                          .selectedGoalColor['1']
                                  : Colors
                                      .transparent, // Set color to transparent if the text is empty
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
                        fontSize: 11),
                              ),
                            ),
                          ),

                          // Index 2
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('2') &&
                                      (context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['2']
                                              ?.isNotEmpty ??
                                          false)
                                  ? context
                                              .watch<GoalColor>()
                                              .selectedGoalColor['2'] ==
                                          Colors.transparent
                                      ? const Color(0xff929292)
                                      : context
                                          .watch<GoalColor>()
                                          .selectedGoalColor['2']
                                  : Colors
                                      .transparent, // Set color to transparent if the text is empty
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
                        fontSize: 11),
                              ),
                            ),
                          ),

                          // Index 3
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('3') &&
                                      (context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['3']
                                              ?.isNotEmpty ??
                                          false)
                                  ? context
                                              .watch<GoalColor>()
                                              .selectedGoalColor['3'] ==
                                          Colors.transparent
                                      ? const Color(0xff929292)
                                      : context
                                          .watch<GoalColor>()
                                          .selectedGoalColor['3']
                                  : Colors
                                      .transparent, // Set color to transparent if the text is empty
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
                        fontSize: 11),
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
                                    fontSize: 12,),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          // Index 5
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('5') &&
                                      (context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['5']
                                              ?.isNotEmpty ??
                                          false)
                                  ? context
                                              .watch<GoalColor>()
                                              .selectedGoalColor['5'] ==
                                          Colors.transparent
                                      ? const Color(0xff929292)
                                      : context
                                          .watch<GoalColor>()
                                          .selectedGoalColor['5']
                                  : Colors
                                      .transparent, // Set color to transparent if the text is empty
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
                        fontSize: 11),
                              ),
                            ),
                          ),

                          // Index 6
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('6') &&
                                      (context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['6']
                                              ?.isNotEmpty ??
                                          false)
                                  ? context
                                              .watch<GoalColor>()
                                              .selectedGoalColor['6'] ==
                                          Colors.transparent
                                      ? const Color(0xff929292)
                                      : context
                                          .watch<GoalColor>()
                                          .selectedGoalColor['6']
                                  : Colors
                                      .transparent, // Set color to transparent if the text is empty
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
                        fontSize: 11),
                              ),
                            ),
                          ),

                          // Index 7
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('7') &&
                                      (context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['7']
                                              ?.isNotEmpty ??
                                          false)
                                  ? context
                                              .watch<GoalColor>()
                                              .selectedGoalColor['7'] ==
                                          Colors.transparent
                                      ? const Color(0xff929292)
                                      : context
                                          .watch<GoalColor>()
                                          .selectedGoalColor['7']
                                  : Colors
                                      .transparent, // Set color to transparent if the text is empty
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
                        fontSize: 11),
                              ),
                            ),
                          ),

                          // Index 8
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal
                                          .containsKey('8') &&
                                      (context
                                              .watch<
                                                  SaveInputtedDetailGoalModel>()
                                              .inputtedDetailGoal['8']
                                              ?.isNotEmpty ??
                                          false)
                                  ? context
                                              .watch<GoalColor>()
                                              .selectedGoalColor['8'] ==
                                          Colors.transparent
                                      ? const Color(0xff929292)
                                      : context
                                          .watch<GoalColor>()
                                          .selectedGoalColor['8']
                                  : Colors
                                      .transparent, // Set color to transparent if the text is empty
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
                        fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                     ConfirmBox(actionPlanid: 5, detailGoalid: 5),
                     ConfirmBox(actionPlanid: 6, detailGoalid: 6),
                     ConfirmBox(actionPlanid: 7, detailGoalid: 7),
                     ConfirmBox(actionPlanid: 8, detailGoalid: 8),
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
