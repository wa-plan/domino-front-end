import 'package:domino/screens/DP/create_confirm_page.dart';
import 'package:domino/screens/DP/create_input1_page.dart';
import 'package:domino/widgets/DP/smallgrid_with_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class DPcreate99Page extends StatelessWidget {
  final String? mainGoalId;
  const DPcreate99Page({super.key, required this.mainGoalId});

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
            padding: const EdgeInsets.fromLTRB(38.0, 15.0, 40.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '목표를 이루기 위한 \n작은 계획들을 세워봐요.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
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
                      shape: BoxShape.rectangle,
                      color: Color(0xffFCFF62),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    child: Text(
                        textAlign: TextAlign.center,
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
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1),
                  children: [
                    const Smallgridwithdata(goalId: 0),
                    const Smallgridwithdata(goalId: 1),
                    const Smallgridwithdata(goalId: 2),
                    const Smallgridwithdata(goalId: 3),
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
                    ),
                    const Smallgridwithdata(goalId: 5),
                    const Smallgridwithdata(goalId: 6),
                    const Smallgridwithdata(goalId: 7),
                    const Smallgridwithdata(goalId: 8),
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
                                builder: (context) =>
                                    DPcreateConfirmPage(
                                      mainGoalId: mainGoalId,
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
