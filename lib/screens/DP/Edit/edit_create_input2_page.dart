import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_input3.dart';
import 'package:domino/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/apis/services/openai_services.dart';
import 'package:domino/widgets/DP/ai_popup.dart';

class EditInput2Page extends StatefulWidget {
  final String mandalart;
  final String firstColor;
  final String? mainGoalId;

  const EditInput2Page({
    super.key,
    required this.firstColor,
    required this.mandalart,
    required this.mainGoalId
  });

  @override
  State<EditInput2Page> createState() => _EditInput2PageState();
}

class _EditInput2PageState extends State<EditInput2Page> {
  List<String> _subGoals = [];
  bool _isLoading = false;
  String goal = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // context.watch를 통해 goal 업데이트
    final selectedDetailGoalString =
        context.watch<SelectDetailGoal>().selectedDetailGoal;
    final selectedDetailGoal = int.tryParse(selectedDetailGoalString) ?? 0;
    final updatedGoal = context
        .watch<SaveInputtedDetailGoalModel>()
        .inputtedDetailGoal[selectedDetailGoal.toString()];

    print("Updated Goal: $updatedGoal");

    if (goal != updatedGoal) {
      setState(() {
        goal = updatedGoal ?? ""; // goal 값을 업데이트
      });
    }
  }

  Future<void> _fetchSubGoals() async {
    setState(() {
      _isLoading = true; // 로딩 상태로 설정
    });

    try {
      final coreGoal = widget.mandalart; // coreGoal 업데이트
      List<String> subGoals =
          await generateThirdGoals(coreGoal, goal); // 변수 prompt 사용
      setState(() {
        _subGoals = subGoals; // 새로운 세부 목표로 업데이트
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false; // 로딩 상태 해제
      });
    }
  }

  Future<void> _showAIPopup(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AIPopup(
        mainGoalId: widget.mainGoalId,
        firstColor: widget.firstColor,
        subgoals: _subGoals,
        onRefresh: () async {
          await _fetchSubGoals();
          if (_subGoals.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('데이터를 가져오지 못했습니다.')),
            );
          } else {
            Navigator.pop(context);
            _showAIPopup(context);
          }
        },
      ),
    );
  }

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
        backgroundColor: backgroundColor,
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
                  '플랜 수정하기',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                TextButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true; // 로딩 시작
                      });
                      await _fetchSubGoals();
                      setState(() {
                        _isLoading = false; // 로딩 종료
                      });
                      _showAIPopup(context);
                    },
                     style: TextButton.styleFrom(padding: EdgeInsets.zero), // Remove default padding
                    
                    child: _isLoading
                        ? const CircularProgressIndicator() // 로딩 중일 때 로딩 인디케이터 표시
                        : Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.blueAccent,
                                  Colors.purpleAccent
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30), // 원형 모서리
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 13),
                              child:  const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                          Icons.lightbulb_outline, // AI 아이콘
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                  SizedBox(width: 5),
                                  Text(
                                    'AI 추천받기',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
              DPMainGoal(widget.mandalart,
              ColorTransform(widget.firstColor).colorTransform()).dpMainGoal(),
              
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
                        color: context
                                    .watch<GoalColor>()
                                    .selectedGoalColor['$selectedDetailGoal'] ==
                                Colors.transparent
                            ? const Color(0xff929292)
                            : context
                                .watch<GoalColor>()
                                .selectedGoalColor['$selectedDetailGoal'],
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
                        actionPlanId: 5,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 6
                      Input2(
                        actionPlanId: 6,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 7
                      Input2(
                        actionPlanId: 7,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                      // Index 8
                      Input2(
                        actionPlanId: 8,
                        selectedDetailGoalId: selectedDetailGoal,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 70),
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
