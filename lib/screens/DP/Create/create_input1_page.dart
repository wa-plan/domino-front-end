import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_input2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/apis/services/openai_services.dart';

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
  //String Clicked = 'no';
  List<String> _subGoals = [];
  bool _isLoading = false;
  String goal = "운동";
  String prompt =
      "핵심목표 '운동'을(를) 달성하기 위한 13글자 이내의 세부 목표 6가지를 추천해 주세요. 각각 간결한 구 형태로 작성해 주세요.";

  Future<void> _fetchSubGoals() async {
    if (prompt.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('핵심목표를 입력해주세요.')),
      );
      return;
    }
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

  Future<dynamic> _aiPopup(BuildContext context, List<String> subgoals) {
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
                      if (_subGoals.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('데이터를 가져오지 못했습니다.')),
                        );
                      } else {
                        Navigator.pop(context);
                        _aiPopup(context, _subGoals);
                        print('_subGoals=$_subGoals');
                      }
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
                                  borderRadius:
                                      BorderRadius.circular(30), // 원형 모서리
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 43,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3)),
                        color: Color(int.parse(widget.firstColor
                            .replaceAll('Color(', '')
                            .replaceAll(')', ''))),
                      ),
                      child: Text(
                          context
                              .watch<SelectFinalGoalModel>()
                              .selectedFinalGoal,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
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
                  const SizedBox(
                    height: 10,
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
