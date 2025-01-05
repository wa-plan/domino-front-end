import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_input3.dart';
import 'package:domino/widgets/DP/Create/SMART.dart';
import 'package:domino/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class DPcreateInput2Page extends StatelessWidget {
  final String firstColor;
  const DPcreateInput2Page({super.key, required this.firstColor,});

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
                    PopupDialog.show(
                        context,
                        '지금 나가면,\n작성한 내용이 사라져!',
                        true, // cancel
                        false, // delete
                        false, // signout
                        true, //success
                        onCancel: () {
                      // 취소 버튼을 눌렀을 때 실행할 코드
                      Navigator.pop(context);
                    }, onSuccess: () async {
                      for (int i = 0; i < 9; i++) {
                        context
                            .read<SaveInputtedDetailGoalModel>()
                            .updateDetailGoal(i.toString(), "");
                      }

                      for (int i = 0; i < 9; i++) {
                        context
                            .read<TestInputtedDetailGoalModel>()
                            .updateTestDetailGoal(i.toString(), "");
                      }

                      for (int i = 0; i < 9; i++) {
                        context.read<GoalColor>().updateGoalColor(
                            i.toString(), const Color(0xff929292));
                      }

                      for (int i = 0; i < 9; i++) {
                        for (int j = 0; j < 9; j++) {
                          context
                              .read<SaveInputtedActionPlanModel>()
                              .updateActionPlan(i, j.toString(), "");
                        }
                      }

                      for (int i = 0; i < 9; i++) {
                        for (int j = 0; j < 9; j++) {
                          context
                              .read<TestInputtedActionPlanModel>()
                              .updateTestActionPlan(i, j.toString(), "");
                        }
                      }

                      // 팝업 닫기
                      Navigator.pop(context);

                      // 이전 페이지로 이동
                      Navigator.pop(context);

                      Navigator.pop(context);
                    });
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '목표를 이루기 위한 계획을 짜봐요.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 4,
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                // 첫 번째 색상
                                Container(
                                  decoration: BoxDecoration(
                                    color: mainRed, // 첫 번째 색상
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  width: 6,
                                  height: 13, // 첫 번째 높이 (6.0으로 고정)
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                // 두 번째 색상
                                Container(
                                  decoration: BoxDecoration(
                                    color: mainRed, // 두 번째 색상
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  width: 6,
                                  height: 18, // 두 번째 높이 (예: 10 추가)
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                // 세 번째 색상
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 86, 86, 86),
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  width: 6,
                                  height: 23, // 세 번째 높이 (예: 20 추가)
                                ),
                              ],
                            ),
                          ],
                        ),
              const SizedBox(height: 20),
              DPMainGoal(
                                context.watch<SelectFinalGoalModel>().selectedFinalGoal,
                                Color(int.parse(firstColor
                                    .replaceAll('Color(', '')
                                    .replaceAll(')', ''))))
                            .dpMainGoal(),
                        const SizedBox(
                          height: 45,
                        ),
              Column(
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

                              return 
                              Container(
                                width: 80,
                                
                                margin: const EdgeInsets.all(1.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: const Color(0xff929292),
                                ),
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
                    
                      SMART().smart(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  const SizedBox(
                          height: 45,
                        ),
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
