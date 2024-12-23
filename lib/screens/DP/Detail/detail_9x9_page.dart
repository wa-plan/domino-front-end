//DP 만다라트 9X9 상세 페이지
import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/screens/DP/Edit/edit99_page.dart';
import 'package:domino/screens/DP/dp_main.dart';
import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Detail/Detail_99_mandalart.dart';
import 'package:domino/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DPdetailPage extends StatelessWidget {
  final String mandalart;
  final int mandalartId;
  final List<Map<String, dynamic>> secondGoals;
  final String firstColor;

  const DPdetailPage({
    super.key,
    required this.mandalart,
    required this.mandalartId,
    required this.secondGoals,
    required this.firstColor
  });

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
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: const Color(0xffD4D4D4),
                iconSize: 17,
              ),
              Text(
                '도미노 플랜',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: fullPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  iconColor: const Color(0xffD4D4D4),
                  iconSize: 28,
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value:
                            'delete', // Changed 'edit' to 'delete' for clarity
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '삭제하기',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'edit',
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '수정하기',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) async {
                    switch (value) {
                      case 'delete':
                        PopupDialog.show(
                          context,
                          '멋진 계획이었는데,\n이대로 보낼꺼야..?',
                          true, // cancel
                          true, // delete
                          false, // signout
                          false, //success
                          onCancel: () {
                            // 취소 버튼을 눌렀을 때 실행할 코드
                            Navigator.of(context).pop();
                          },

                          
                          onDelete:() async {
                            bool isDeleted =
                                await DeleteMandalartService.deleteMandalart(
                              context,
                              mandalartId,
                            );
                            context
                                .read<SaveMandalartCreatedGoal>()
                                .removeGoal(mandalartId.toString());
                            if (isDeleted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DPMain(),
                                ),
                              );
                            }
                          },
                        );
                        break;

                      case 'edit':
                        for (int i = 0; i < 9; i++) {
                          context
                              .read<SaveInputtedDetailGoalModel>()
                              .updateDetailGoal(
                                  i.toString(),
                                  secondGoals.isNotEmpty &&
                                          secondGoals[i]['secondGoal'] != ""
                                      ? secondGoals[i]['secondGoal']
                                      : "");
                        }

                        for (int i = 0; i < 9; i++) {
                          context
                              .read<SaveEditedDetailGoalIdModel>()
                              .editDetailGoalId(
                                  i.toString(),
                                  secondGoals.isNotEmpty
                                      ? secondGoals[i]['id']
                                      : 0);
                        }

                        for (int i = 0; i < 9; i++) {
                          context.read<GoalColor>().updateGoalColor(
                              i.toString(),
                              secondGoals.isNotEmpty &&
                                      secondGoals[i]['secondGoal'] != ""
                                  ? Color(int.parse(secondGoals[i]['color']
                                      .replaceAll('Color(', '')
                                      .replaceAll(')', '')))
                                  : Colors.transparent);
                        }

                        for (int i = 0; i < 9; i++) {
                          for (int j = 0; j < 9; j++) {
                            context
                                .read<SaveInputtedActionPlanModel>()
                                .updateActionPlan(
                                    i,
                                    j.toString(),
                                    secondGoals.isNotEmpty &&
                                            secondGoals[i]['thirdGoals']
                                                .isNotEmpty &&
                                            secondGoals[i]['thirdGoals']
                                                .asMap()
                                                .containsKey(j)
                                        ? secondGoals[i]['thirdGoals'][j]
                                            ['thirdGoal']
                                        : "");
                          }
                        }

                        for (int i = 0; i < 9; i++) {
                          for (int j = 0; j < 9; j++) {
                            context
                                .read<SaveEditedActionPlanIdModel>()
                                .editActionPlanId(
                                    i,
                                    j.toString(),
                                    secondGoals.isNotEmpty &&
                                            secondGoals[i]['thirdGoals']
                                                .isNotEmpty &&
                                            secondGoals[i]['thirdGoals']
                                                .asMap()
                                                .containsKey(j)
                                        ? secondGoals[i]['thirdGoals'][j]['id']
                                        : 0);
                          }
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Edit99Page(
                              mandalart: mandalart,
                              mandalartId: mandalartId,
                              firstColor: firstColor,
                            ),
                          ),
                        );
                        break;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              mandalart,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(3),
              ),
              height: 300,
              width: 300,
              child: Center(
                child: MandalartGrid3(
                  mandalart: mandalart,
                  secondGoals: secondGoals,
                  mandalartId: mandalartId,
                  firstColor : firstColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
