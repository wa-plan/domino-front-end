import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_input3.dart';
import 'package:domino/widgets/DP/Edit/Edit_Input23.dart';
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

  const EditInput2Page(
      {super.key,
      required this.firstColor,
      required this.mandalart,
      required this.mainGoalId});

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
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
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
              CustomIconButton(() {
                context.read<TestInputtedActionPlanModel>().resetActionPlans();
                Navigator.pop(context);
              }, Icons.keyboard_arrow_left_rounded, currentWidth)
                  .customIconButton(),
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
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                  backgroundColor: const Color(0xff303030),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator() // 로딩 중일 때 로딩 인디케이터 표시
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/img/AIIcon.png', height: 15),
                          const SizedBox(width: 5),
                          const Text(
                            'Ask AI',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
          padding: fullPadding,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const SizedBox(
                        height: 15,
                      ),
                    DPMainGoal(widget.mandalart,
                            ColorTransform(widget.firstColor).colorTransform(), currentHeight, currentWidth)
                        .dpMainGoal(),
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
                            Container(
                              width: 80,
                              color: const Color(0xff929292),
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
                    
                  ],
                ),
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
      
    );
  }
}
