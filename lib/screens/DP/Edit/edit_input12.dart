import 'package:domino/provider/DP/model.dart';
import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_input2.dart';
import 'package:domino/widgets/DP/Edit/Edit_Input12.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditInput1Page extends StatelessWidget {
  final String mandalart;
  final String firstColor;

  const EditInput1Page({
    super.key,
    required this.firstColor,
    required this.mandalart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          backgroundColor: backgroundColor,
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
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: fullPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("플랜을 수정할 수 있어요.",
                        style: TextStyle(
                            color: Colors.white,
                           fontSize: 17,
                      fontWeight: FontWeight.w500,
                            letterSpacing: 1.1)),
                    const SizedBox(
                      height: 15,
                    ),
                    DPMainGoal(
                      mandalart, 
                      ColorTransform(firstColor).colorTransform()).dpMainGoal(),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                        child: SizedBox(
                            height: 300,
                            width: 260,
                            child: GridView(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5),
                                children: [
                                   const EditInput1(selectedDetailGoalId: 0),
                                   const EditInput1(selectedDetailGoalId: 1),
                                   const EditInput1(selectedDetailGoalId: 2),
                                   const EditInput1(selectedDetailGoalId: 3),

                                   DPGrid3_E(
                                    mandalart, 
                                    ColorTransform(firstColor).colorTransform(), 
                                    13).dpGrid3_E(),
                                 
                                   const EditInput1(selectedDetailGoalId: 5),
                                   const EditInput1(selectedDetailGoalId: 6),
                                   const EditInput1(selectedDetailGoalId: 7),
                                   const EditInput1(selectedDetailGoalId: 8),
                                ]))),
                    
                    const SizedBox(
                      height: 130,
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        Colors.black,
                        Colors.white,
                        '취소',
                        () {
                          // TestInputtedDetailGoalModel만 초기화
                          context
                              .read<TestInputtedDetailGoalModel>()
                              .resetDetailGoals();
                          Navigator.pop(context);
                        },
                      ).button(),
                      Button(Colors.black, Colors.white, '저장', () {
                        // 현재 context를 통해 두 모델에 접근
                        final testModel =
                            context.read<TestInputtedDetailGoalModel>();
                        final saveModel =
                            context.read<SaveInputtedDetailGoalModel>();

                        // TestInputtedDetailGoalModel의 데이터를 SaveInputtedDetailGoalModel로 복사
                        testModel.testinputtedDetailGoal.forEach((key, value) {
                          saveModel.updateDetailGoal(
                              key, value); // Save 모델에 값 저장
                        });

                        Navigator.pop(context);
                      }).button()
                    ])
                  ],
                ))));
  }
}
