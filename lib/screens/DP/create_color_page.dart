import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/widgets/DP/confirm_box.dart';

class DPcreateColorPage extends StatefulWidget {
  const DPcreateColorPage({super.key});

  @override
  _DPcreateColorPageState createState() => _DPcreateColorPageState();
}

class _DPcreateColorPageState extends State<DPcreateColorPage> {
  //const DPcreateColorPage({super.key});

  int selectIndex = 0;

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
                  '플랜을 꾸밀 수 있어요.',
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
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            selectIndex = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: selectIndex == 0
                                      ? Colors.white
                                      : const Color(0xff262626))),
                          child: SizedBox(
                              width: 100,
                              child: GridView.count(
                                  crossAxisCount: 3,
                                  children: List.generate(9, (index) {
                                    final inputtedActionPlan = context
                                        .watch<SaveInputtedActionPlanModel>()
                                        .inputtedActionPlan[0];
                                    final values = inputtedActionPlan
                                            .containsKey(index.toString())
                                        ? inputtedActionPlan[index.toString()]
                                        : '';
                                    final detailGoal = context
                                        .watch<SaveInputtedDetailGoalModel>()
                                        .inputtedDetailGoal['0'];
                                    final color1 = context
                                        .watch<GoalColor>()
                                        .selectedGoalColor['0'];
                                    final backgroundColor1 = detailGoal.isEmpty
                                        ? const Color(0xff262626)
                                        : color1;

                                    if (index == 4) {
                                      return Container(
                                        color: backgroundColor1,
                                        margin: const EdgeInsets.all(1.0),
                                        child: Text(
                                          detailGoal,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    } else {
                                      final isValueEmpty = values.isEmpty;
                                      final backgroundColor2 = isValueEmpty
                                          ? const Color(0xff262626)
                                          : const Color(0xff5C5C5C);

                                      return Container(
                                        color: backgroundColor2,
                                        margin: const EdgeInsets.all(1.0),
                                        child: Text(
                                          values.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }
                                  }))),
                        )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            selectIndex = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: selectIndex == 1
                                      ? Colors.white
                                      : const Color(0xff262626))),
                          child: const ConfirmBox(
                              actionPlanid: 1, detailGoalid: 1),
                        )),
                    const ConfirmBox(actionPlanid: 2, detailGoalid: 2),
                    const ConfirmBox(actionPlanid: 3, detailGoalid: 3),
                    SizedBox(
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
                            final values = inputtedDetailGoals
                                    .containsKey(index.toString())
                                ? inputtedDetailGoals[index.toString()]
                                : '';
                            final isValueEmpty = values.isEmpty;
                            final backgroundColor2 = isValueEmpty
                                ? const Color(0xff262626)
                                : const Color(0xff929292);

                            return Container(
                              color: backgroundColor2,
                              margin: const EdgeInsets.all(1.0),
                              child: Text(
                                values,
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        }),
                      ),
                    ),
                    const ConfirmBox(actionPlanid: 5, detailGoalid: 5),
                    const ConfirmBox(actionPlanid: 6, detailGoalid: 6),
                    const ConfirmBox(actionPlanid: 7, detailGoalid: 7),
                    const ConfirmBox(actionPlanid: 8, detailGoalid: 8),
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '컬러 테마',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Expanded(
                    child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6),
                        children: [
                      GestureDetector(
                          onTap: () {
                            context.read<GoalColor>().updateGoalColor(
                                '$selectIndex', const Color(0xffFF7A7A));
                          },
                          child: Container(
                            color: const Color(0xffFF7A7A),
                          )),
                      Container(
                        color: const Color(0xffFFB82D),
                      ),
                      Container(
                        color: const Color(0xffFCFF62),
                      ),
                      Container(
                        color: const Color(0xff72FF5B),
                      ),
                      Container(
                        color: const Color(0xff5DD8FF),
                      ),
                      Container(
                        color: const Color(0xff929292),
                      ),
                      Container(
                        color: const Color(0xffFF5794),
                      ),
                      Container(
                        color: const Color(0xffAE7CFF),
                      ),
                      Container(
                        color: const Color(0xffC77B7F),
                      ),
                      Container(
                        color: const Color(0xff009255),
                      ),
                      Container(
                        color: const Color(0xff3184FF),
                      ),
                      Container(
                        color: const Color(0xff11D1C2),
                      ),
                    ])),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DPcreateColorPage(),
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
