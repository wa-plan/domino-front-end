import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Create/DP_input2.dart';
import 'package:domino/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/apis/services/openai_services.dart';
import 'package:domino/widgets/DP/ai_popup.dart';

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
  String goal = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // context.watch를 통해 goal 업데이트
    final updatedGoal = context.watch<SelectFinalGoalModel>().selectedFinalGoal;

    print("Updated Goal: $updatedGoal");

    if (goal != updatedGoal) {
      setState(() {
        goal = updatedGoal; // goal 값을 업데이트
      });
    }
  }

  Future<void> _fetchSubGoals() async {
    setState(() {
      _isLoading = true; // 로딩 상태로 설정
    });

    try {
      List<String> subGoals = await generateSubGoals(goal); // 변수 prompt 사용
      setState(() {
        _subGoals = subGoals; // 새로운 세부 목표로 업데이트
        print('_subGoals=$_subGoals');
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

  /*Future<dynamic> _aiPopup(BuildContext context, List<String> subgoals) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                ImageIcon(
                  AssetImage('assets/img/AI_icon.png'),
                  color: Color(0xFF4d00bb),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'AI 세부목표 추천',
                  style: TextStyle(
                      color: Color(0xFF4d00bb), fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
              color: const Color(0xFF4d00bb),
            )
          ],
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
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
                          color: Color(0xFFCFADFF),
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '새로고침하기',
                          style: TextStyle(color: Color(0xFFCFADFF)),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
        actions: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6, // 화면 너비의 60%
              height: 40,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      const Color(0xFF4D00BB)), // MaterialStateProperty 사용
                ),
                child: const Text(
                  '지금 바로 적용하기',
                  style: TextStyle(color: Color(0xFFede0ff)),
                ),
              ),
            ),
          )
        ],
        elevation: 10.0,
        backgroundColor: const Color(0xFFe0cbff),
      ),
    );
  }*/

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
                          //_aiPopup(context, _subGoals);
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
                  DPMainGoal(
                          context
                              .watch<SelectFinalGoalModel>()
                              .selectedFinalGoal,
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
                                        borderRadius: BorderRadius.circular(3),
                                        color: Color(int.parse(widget.firstColor
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

/*class AICard extends StatefulWidget {
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
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  color: isChecked
                      ? const Color(0xFF4d00bb)
                      : const Color(0xFFe0cbff),
                  border: Border.all(color: const Color(0xFFCFADFF)),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                widget.goal,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isChecked
                        ? const Color(0xFFEDE0FF)
                        : const Color(0xFF4D00BB),
                    fontSize: 16),
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Icon(
              isChecked
                  ? Icons.circle
                  : Icons.circle_outlined, // 테두리가 있는 체크 아이콘
              color: const Color(0xFFede0ff), // 체크 부분 색상
              size: 18, // 아이콘 크기
            ),
          ),
        ],
      ),
    );
  }
}
*/
