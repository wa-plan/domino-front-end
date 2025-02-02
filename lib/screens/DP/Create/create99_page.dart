import 'package:auto_size_text/auto_size_text.dart';
import 'package:domino/screens/DP/Create/create_color_page.dart';
import 'package:domino/screens/DP/Create/create_input1_page.dart';
import 'package:domino/screens/DP/dp_main.dart';
import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_99.dart';
import 'package:domino/widgets/DP/Create/Description.dart';
import 'package:domino/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class DPcreate99Page extends StatefulWidget {
  final String? mainGoalId;
  final String firstColor;
  const DPcreate99Page(
      {super.key, required this.firstColor, required this.mainGoalId});

  @override
  State<DPcreate99Page> createState() => _DPcreate99Page();
}

class _DPcreate99Page extends State<DPcreate99Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: appBarPadding,
            child: Row(
              children: [
                CustomIconButton(() {
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

                    // DP 메인 페이지로 이동
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DPMain()),
                              );
                  });
                }, Icons.keyboard_arrow_left_rounded)
                    .customIconButton(),
                const SizedBox(width: 10),
                Text(
                  '플랜 만들기',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff515151), // 첫 번째 색상
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      width: 8,
                      height: 8,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9), // 첫 번째 색상
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      width: 8,
                      height: 8,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff515151), // 첫 번째 색상
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      width: 8,
                      height: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: backgroundColor,
        ),
        body: Padding(
            padding: fullPadding,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '만다라트를 작성해 보아요.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DPMainGoal(
                                context
                                    .watch<SelectFinalGoalModel>()
                                    .selectedFinalGoal,
                                ColorTransform(widget.firstColor)
                                    .colorTransform())
                            .dpMainGoal(),
                        const SizedBox(
                          height: 20,
                        ),
                        GridView(
                          shrinkWrap: true, // GridView를 자식으로 설정
                          physics:
                              const NeverScrollableScrollPhysics(), // Grid 자체의 스크롤 비활성화
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 1),
                          children: [
                            Smallgridwithdata(
                              goalId: 0,
                              firstColor: widget.firstColor,
                            ),
                            Smallgridwithdata(
                                goalId: 1, firstColor: widget.firstColor),
                            Smallgridwithdata(
                                goalId: 2, firstColor: widget.firstColor),
                            Smallgridwithdata(
                                goalId: 3, firstColor: widget.firstColor),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DPcreateInput1Page(
                                        mainGoalId: widget.mainGoalId,
                                        firstColor: widget.firstColor,
                                      ),
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
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: ColorTransform(
                                                    widget.firstColor)
                                                .colorTransform()),
                                        margin: const EdgeInsets.all(1.0),
                                        child: Center(
                                            child: AutoSizeText(
                                          maxLines: 3, // 최대 줄 수 (필요에 따라 변경 가능)
                                          minFontSize: 6, // 최소 글씨 크기
                                          overflow: TextOverflow
                                              .ellipsis, // 내용이 너무 길 경우 생략 표시
                                          context
                                              .watch<SelectFinalGoalModel>()
                                              .selectedFinalGoal,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
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
                                          ? inputtedDetailGoals[
                                              index.toString()]
                                          : '';

                                      return Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            3, 3, 3, 3),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: const Color(0xff929292),
                                        ),
                                        margin: const EdgeInsets.all(1.0),
                                        child: Center(
                                            child: Text(
                                          maxLines: 2, // 두 줄로 제한
                                          overflow: TextOverflow.ellipsis,
                                          value!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        )),
                                      );
                                    }
                                  }),
                                ),
                              ),
                            ),
                            Smallgridwithdata(
                                goalId: 5, firstColor: widget.firstColor),
                            Smallgridwithdata(
                                goalId: 6, firstColor: widget.firstColor),
                            Smallgridwithdata(
                                goalId: 7, firstColor: widget.firstColor),
                            Smallgridwithdata(
                                goalId: 8, firstColor: widget.firstColor),
                          ],
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        Description(widget.firstColor).description(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          PopupDialog.show(
                            context,
                            '지금 돌아가면,\n작성한 내용이 사라져!',
                            true, // cancel
                            false, // delete
                            false, // signout
                            true, //success
                            onCancel: () {
                              // 취소 버튼을 눌렀을 때 실행할 코드
                              Navigator.pop(context);
                            },

                            onSuccess: () async {
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
                                      .updateTestActionPlan(
                                          i, j.toString(), "");
                                }
                              }

                              // 팝업 닫기
                              Navigator.pop(context);

                              // 이전 페이지로 이동
                              Navigator.pop(context);
                            },
                          );
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
                      Button(Colors.black, Colors.white, '다음', () {
                        // isAllEmpty 검사를 실행
                        final isAllEmpty = context
                            .read<SaveInputtedActionPlanModel>()
                            .isAllEmpty();

                        if (isAllEmpty) {
                          // true일 경우 메시지를 띄움
                          Message('제3목표를 입력하지 않으면 루틴을 만들 수 없어요.', const Color(0xffFF6767),
                            const Color(0xff412C2C),
                            borderColor: const Color(0xffFF6767),
                            icon: Icons.priority_high).message(context);
                          
                        } else {
                          // false일 경우 다음 페이지로 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DPcreateColorPage(
                                mainGoalId: widget.mainGoalId,
                                firstColor: widget.firstColor,
                              ),
                            ),
                          );
                        }
                      }).button(),
                    ]),
              ],
            )));
  }
}
