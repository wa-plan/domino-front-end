import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_input3.dart';
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
  String goal = "갓생살기";
  String prompt =
      "핵심목표 '갓생살기'을(를) 달성하기 위한 13글자 이내의 세부 목표 6가지를 추천해 주세요. 각각 간결한 구 형태로 작성해 주세요.";
  Future<void> _fetchSubGoals() async {
    setState(() {
      _isLoading = true; // 로딩 상태로 설정
    });

    try {
      List<String> subGoals = await generateSubGoals(prompt); // 변수 prompt 사용
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

  Future<dynamic> _aiPopup(BuildContext context, subgoals) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(
          child: Text(
            '세부목표 추천',
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: SizedBox(
          height: 200,
          child: Center(
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AICard(goal: subgoals[0]),
                        AICard(goal: subgoals[1]),
                        AICard(goal: subgoals[2])
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AICard(goal: subgoals[3]),
                        AICard(goal: subgoals[4]),
                        AICard(goal: subgoals[5])
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () async {
                      await _fetchSubGoals(); // 새로운 데이터를 받아옴
                      Navigator.pop(context);
                      _aiPopup(context, _subGoals); // 새로 받아온 데이터를 팝업에 전달
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.refresh,
                          size: 24,
                        ),
                        Text('새로고침'),
                      ],
                    ))
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('뒤로')),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('적용')),
            ],
          ),
        ],
        elevation: 10.0,
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
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
          child: Text(
            '플랜 만들기',
            style: Theme.of(context).textTheme.titleLarge,
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
                      prompt =
                          "핵심목표 '$goal'을(를) 달성하기 위한 13글자 이내의 세부 목표 6가지를 추천해 주세요. 각각 간결한 구 형태로 작성해 주세요.";
                      await _fetchSubGoals();
                      setState(() {
                        _isLoading = false; // 로딩 종료
                      });
                      _aiPopup(context, _subGoals);
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
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
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
                                color: const Color(0xff929292),
                                margin: const EdgeInsets.all(1.0),
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
                    const SizedBox(
                      height: 5,
                    ),
                    const Center(
                        child: Text(
                      '모든 칸을 다 채우지 않아도 괜찮아요:)',
                      style: TextStyle(
                          color: Color.fromARGB(255, 158, 158, 158),
                          fontWeight: FontWeight.w400,
                          fontSize: 13),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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

class AICard extends StatefulWidget {
  final String goal;
  const AICard({super.key, required this.goal});

  @override
  _AICardState createState() => _AICardState();
}

class _AICardState extends State<AICard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.1,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Text(
                  widget.goal,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ),
          if (isChecked)
            const Positioned(
              top: 5,
              right: 10,
              child: Icon(
                Icons.check, // 테두리가 있는 체크 아이콘
                color: Colors.red, // 체크 부분 색상
                size: 24, // 아이콘 크기
              ),
            ),
        ],
      ),
    );
  }
}
