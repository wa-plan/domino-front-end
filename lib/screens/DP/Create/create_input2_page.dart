import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_input3.dart';
import 'package:domino/widgets/DP/Create/SMART.dart';
import 'package:domino/widgets/DP/Create/ai_popup.dart';
import 'package:domino/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/apis/services/openai_services.dart';

class DPcreateInput2Page extends StatefulWidget {
  final String firstColor;
  const DPcreateInput2Page({
    super.key,
    required this.firstColor,
  });

  @override
  State<DPcreateInput2Page> createState() => _DPcreateInput2PageState();
}

class _DPcreateInput2PageState extends State<DPcreateInput2Page> {
  List<String> _subGoals = [];
  bool _isLoading = false;
  String goal = "자기관리하기";
  Future<void> _fetchSubGoals() async {
    setState(() {
      _isLoading = true; // 로딩 상태로 설정
    });

    try {
      List<String> subGoals = await generateThirdGoals(goal); // 변수 prompt 사용
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
    if (_subGoals.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('세부 목표가 없습니다.')),
      );
      return;
    }
    await showDialog(
      context: context,
      builder: (BuildContext context) => AIPopup(
        
        subgoals: _subGoals,
        onRefresh: () async {
          await _fetchSubGoals();
          Navigator.pop(context);
          _showAIPopup(context); // 새 팝업 표시
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
                        _isLoading = true; // 로딩 시작
                      });
                      await _fetchSubGoals();
                      setState(() {
                        _isLoading = false; // 로딩 종료
                      });
                      _showAIPopup(context);
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
              Container(
                height: 43,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                  color: Color(int.parse(widget.firstColor
                      .replaceAll('Color(', '')
                      .replaceAll(')', ''))),
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