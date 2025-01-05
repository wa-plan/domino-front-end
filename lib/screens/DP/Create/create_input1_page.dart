import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_input2.dart';
import 'package:domino/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class DPcreateInput1Page extends StatefulWidget {
  final String firstColor;
  const DPcreateInput1Page({
    super.key,
    required this.firstColor,
  });

  @override
  State<DPcreateInput1Page> createState() => _DPcreateInput1Page();
}

class _DPcreateInput1Page extends State<DPcreateInput1Page> {
  String Clicked = 'no';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: appBarPadding,
            child:Row(
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
                  const SizedBox(
                    height: 20,
                  ),
                  DPMainGoal(
                                context.watch<SelectFinalGoalModel>().selectedFinalGoal,
                                Color(int.parse(widget.firstColor
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
                                child: GridView(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5),
                                    children: [
                                      const Input1(selectedDetailGoalId: 0),
                                      const Input1(selectedDetailGoalId: 1),
                                      const Input1(selectedDetailGoalId: 2),
                                      const Input1(selectedDetailGoalId: 3),
                                      Container(
                                        width: 80,
                                        margin: const EdgeInsets.all(1.0),
                                        padding: const EdgeInsets.all(7.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Color(int.parse(widget
                                              .firstColor
                                              .replaceAll('Color(', '')
                                              .replaceAll(')', ''))),
                                        ),
                                        child: Center(
                                            child: Text(
                                          context
                                              .watch<SelectFinalGoalModel>()
                                              .selectedFinalGoal,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                      const Input1(selectedDetailGoalId: 5),
                                      const Input1(selectedDetailGoalId: 6),
                                      const Input1(selectedDetailGoalId: 7),
                                      const Input1(selectedDetailGoalId: 8),
                                    ]))),
                        const SizedBox(
                          height: 35,
                        ),
                        const Center(
                            child: Text(
                          '모든 칸을 다 채우지 않아도 괜찮아요:)',
                          style: TextStyle(
                              color: Color.fromARGB(255, 158, 158, 158),
                              fontWeight: FontWeight.w300,
                              fontSize: 13),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  const SizedBox(
                          height: 47,
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
                          print(
                              'Test Model: ${testModel.testinputtedDetailGoal}');
                          // TestInputtedDetailGoalModel의 데이터를 SaveInputtedDetailGoalModel로 복사
                          testModel.testinputtedDetailGoal
                              .forEach((key, value) {
                            saveModel.updateDetailGoal(
                                key, value); // Save 모델에 값 저장
                          });
                          print(
                              'Updated Save Model: ${saveModel.inputtedDetailGoal}');

                          Navigator.pop(context);
                        }).button()
                      ])
                ],
              )),
        ));
  }
}
