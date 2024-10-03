import 'package:domino/widgets/DP/input2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class EditInput2Page extends StatelessWidget {
  final String mandalart;

  const EditInput2Page({super.key,required this.mandalart,});
  

  @override
  Widget build(BuildContext context) {
    // selectedDetailGoal을 안전하게 파싱
    final selectedDetailGoalString =
        context.watch<SelectDetailGoal>().selectedDetailGoal;
    final selectedDetailGoal = int.tryParse(selectedDetailGoalString) ?? 0;

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
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(38.0, 10.0, 38.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "플랜을 수정할 수 있어요.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                      fontWeight: FontWeight.w500,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 43,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: Color(0xffFCFF62),
                ),
                child: Text(
                  mandalart,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  height: 300,
                  width: 260,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    children: [
                      // Index 0
                      Input2(
                        actionPlanId: 0,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 1
                      Input2(
                        actionPlanId: 1,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 2
                      Input2(
                        actionPlanId: 2,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 3
                      Input2(
                        actionPlanId: 3,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 4 (Special handling)
                      Container(
                        width: 80,
                        color: context.watch<GoalColor>().selectedGoalColor['$selectedDetailGoal'] ==
                                Colors.transparent
                            ? const Color(0xff929292)
                            : context.watch<GoalColor>().selectedGoalColor['$selectedDetailGoal'],
                        margin: const EdgeInsets.all(1.0),
                        child: Center(
                          child: Text(
                            context
                                        .watch<SaveInputtedDetailGoalModel>()
                                        .inputtedDetailGoal[
                                    selectedDetailGoal.toString()] ??
                                '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Index 5
                      Input2(
                        actionPlanId: 4,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 6
                      Input2(
                        actionPlanId: 5,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 7
                      Input2(
                        actionPlanId: 6,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 8
                      Input2(
                        actionPlanId: 7,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 70),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff131313),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  child: const Text(
                    '완료',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
