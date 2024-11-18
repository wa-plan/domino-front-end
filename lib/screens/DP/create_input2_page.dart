import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/input2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class DPcreateInput2Page extends StatelessWidget {
  const DPcreateInput2Page({super.key});

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
          child: Text(
            '플랜 만들기',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: fullPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "목표를 이루기 위한 \n작은 계획들을 세워봐요.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
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
                  context.watch<SelectFinalGoalModel>().selectedFinalGoal,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 300,
                        width: 260,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                          ),
                          itemCount: 9,
                          itemBuilder: (context, index) {
                            if (index == 4) {
                              // 안전한 null 처리
                              final inputtedDetailGoal = context
                                          .watch<SaveInputtedDetailGoalModel>()
                                          .inputtedDetailGoal[
                                      '$selectedDetailGoal'] ??
                                  '';

                              return Container(
                                width: 80,
                                color: const Color(0xff929292),
                                margin: const EdgeInsets.all(1.0),
                                child: Center(
                                  child: Text(
                                    inputtedDetailGoal,
                                    style: const TextStyle(
                                      color: backgroundColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            } else {
                              return Input2(
                                actionPlanId: index,
                                selectedDetailGoalId: selectedDetailGoal,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Center(
                        child: Text(
                      '모든 칸을 다 채우지 않아도 괜찮아요:)',
                      style: TextStyle(
                          color: Color.fromARGB(255, 158, 158, 158),
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
