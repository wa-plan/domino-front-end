//DP 만다라트 9X9 상세 페이지
import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/screens/DP/edit99_page.dart';
import 'package:domino/screens/DP/list_page.dart';
import 'package:domino/widgets/DP/mandalart3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DPdetailPage extends StatelessWidget {
  final String mandalart;
  final int mandalartId;
  final List<Map<String, dynamic>> secondGoals;

  const DPdetailPage({
    super.key,
    required this.mandalart,
    required this.mandalartId,
    required this.secondGoals,
  });

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
            '도미노 플랜',
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: const Color(0xff5C5C5C),
                  iconSize: 30.0,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Navigator.pop(
                      context
                    );
                  },
                ),
                PopupMenuButton(
                  iconColor: const Color(0xff5C5C5C),
                  iconSize: 30,
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'delete', // Changed 'edit' to 'delete' for clarity
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
                        bool isDeleted =
                            await DeleteMandalartService.deleteMandalart(
                          context,
                          mandalartId,
                        );
                        if (isDeleted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DPlistPage(),
                            ),
                          );
                        }
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
                            context.read<SaveInputtedActionPlanModel>().updateActionPlan(i,j.toString(),
                            secondGoals.isNotEmpty &&
                          secondGoals[i]['thirdGoals'].isNotEmpty 
                          && secondGoals[i]['thirdGoals'].asMap().containsKey(j)  
                          ? secondGoals[i]['thirdGoals'][j]['thirdGoal']
                          : "");
                        }
                        }
                
                        for (int i = 0; i < 9; i++) {
                          for (int j = 0; j < 9; j++) {
                            context.read<SaveEditedActionPlanIdModel>().editActionPlanId(i,j.toString(),
                            secondGoals.isNotEmpty &&
                          secondGoals[i]['thirdGoals'].isNotEmpty 
                          && secondGoals[i]['thirdGoals'].asMap().containsKey(j)  
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
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: MandalartGrid3(
                  mandalart: mandalart,
                  secondGoals: secondGoals,
                  mandalartId: mandalartId,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
