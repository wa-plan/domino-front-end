import 'package:domino/screens/DP/Create/create99_page.dart';
import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_input3.dart';
import 'package:domino/widgets/DP/Create/SMART.dart';
import 'package:domino/widgets/DP/ai_popup2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/apis/services/openai_services.dart';

class DPcreateInput2Page extends StatefulWidget {
  final String firstColor;
  final String? mainGoalId;

  const DPcreateInput2Page({
    super.key,
    required this.firstColor,
        required this.mainGoalId

  });

  @override
  State<DPcreateInput2Page> createState() => _DPcreateInput2PageState();
}

class _DPcreateInput2PageState extends State<DPcreateInput2Page> {
  List<String> _subGoals = [];
  bool _isLoading = false;
  String secondGoal = "";
  String coreGoal = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // context.watch를 통해 goal 업데이트
    final selectedDetailGoalString =
        context.watch<SelectDetailGoal>().selectedDetailGoal;
    final selectedDetailGoal = int.tryParse(selectedDetailGoalString) ?? 0;
    final updatedSecondGoal = context
        .watch<SaveInputtedDetailGoalModel>()
        .inputtedDetailGoal[selectedDetailGoal.toString()];

    final updatedCoreGoal = context
        .watch<SelectFinalGoalModel>()
        .selectedFinalGoal; // coreGoal 업데이트

    //print("Updated Goal: $updatedSecondGoal");

    if (secondGoal != updatedSecondGoal) {
      setState(() {
        secondGoal = updatedSecondGoal ?? ""; // goal 값을 업데이트
      });
    }

    if (coreGoal != updatedCoreGoal) {
      setState(() {
        coreGoal = updatedCoreGoal; // goal 값을 업데이트
      });
    }
  }

  Future<void> _fetchSubGoals() async {
    setState(() {
      _isLoading = true; // 로딩 상태로 설정
    });

    try {
      List<String> subGoals =
          await generateThirdGoals(coreGoal, secondGoal); // 변수 prompt 사용
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

  Future<void> _showAIPopup(BuildContext context, int selectedDetailGoal) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => AIPopup2(
      selectedDetailGoal: selectedDetailGoal,
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
          _showAIPopup(context, selectedDetailGoal);
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
        titleSpacing: 0.0,
        title: Padding(
          padding: appBarPadding,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  context
                                .read<TestInputtedDetailGoalModel>()
                                .resetDetailGoals();
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        int howMany = Provider.of<TestInputtedActionPlanModel>(context, listen: false).countEmptyValues(selectedDetailGoal)-1;
                            print(howMany);
                        _isLoading = true; // 로딩 시작
                      });
                      await _fetchSubGoals();
                      setState(() {
                        _isLoading = false; // 로딩 종료
                      });
                      _showAIPopup(context, selectedDetailGoal);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 9, horizontal: 16),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
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
                                  vertical: 9, horizontal: 16),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.lightbulb_outline, // AI 아이콘
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'AI 추천',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
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
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  DPcreate99Page(
                                      firstColor: widget.firstColor,
                                      mainGoalId: widget.mainGoalId ,)),
                              );
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

                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  DPcreate99Page(
                                      firstColor: widget.firstColor,
                                      mainGoalId: widget.mainGoalId ,)),
                              );
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

