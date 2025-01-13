import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_input3.dart';
import 'package:domino/widgets/DP/Edit/Edit_Input23.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class EditInput2Page extends StatelessWidget {
  final String mandalart;
  final String firstColor;

  const EditInput2Page({
    super.key,
    required this.firstColor,
    required this.mandalart,});
  

  @override
  Widget build(BuildContext context) {
    // selectedDetailGoal을 안전하게 파싱
    final selectedDetailGoalString =
        context.watch<SelectDetailGoal>().selectedDetailGoal;
    final selectedDetailGoal = int.tryParse(selectedDetailGoalString) ?? 0;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Padding(
          padding: appBarPadding,
          child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xffD4D4D4),
                    size: 17,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '플랜 만들기',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: fullPadding,
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
              const SizedBox(height: 15),

              DPMainGoal(
                mandalart, 
                ColorTransform(firstColor).colorTransform()).dpMainGoal(),

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
                      EditInput2(
                        actionPlanId: 0,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 1
                      EditInput2(
                        actionPlanId: 1,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 2
                      EditInput2(
                        actionPlanId: 2,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 3
                      EditInput2(
                        actionPlanId: 3,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 4 (Special handling)
                      DPGrid3_E(context
                                        .watch<SaveInputtedDetailGoalModel>()
                                        .inputtedDetailGoal[
                                    selectedDetailGoal.toString()] ??
                                '', const Color(0xff929292), 15).dpGrid3_E(),
                      
                      // Index 5
                      EditInput2(
                        actionPlanId: 5,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 6
                      EditInput2(
                        actionPlanId: 6,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 7
                      EditInput2(
                        actionPlanId: 7,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 8
                      EditInput2(
                        actionPlanId: 8,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 130),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Button(
                  Colors.black,
                  Colors.white,
                  '취소',
                  () {
                    // TestInputtedActionPlanModel 초기화
                    context
                        .read<TestInputtedActionPlanModel>()
                        .resetActionPlans();
                    Navigator.pop(context);
                  },
                ).button(),
                Button(
                  Colors.black,
                  Colors.white,
                  '완료',
                  () {
                    // 모델 가져오기
                    final testModel =
                        context.read<TestInputtedActionPlanModel>();
                    final saveModel =
                        context.read<SaveInputtedActionPlanModel>();

                    // TestInputtedActionPlanModel의 데이터를 SaveInputtedActionPlanModel로 복사
                    for (int goalId = 0;
                        goalId < testModel.inputtedActionPlan.length;
                        goalId++) {
                      testModel.inputtedActionPlan[goalId]
                          .forEach((key, value) {
                        saveModel.updateActionPlan(goalId, key, value);
                      });
                    }

                    Navigator.pop(context);
                  },
                ).button(),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
