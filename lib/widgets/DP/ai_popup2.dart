import 'package:auto_size_text/auto_size_text.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/screens/DP/Create/create_input2_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart'; // FlutterToast import 추가

class AIPopup2 extends StatefulWidget {
  final List<String> subgoals;
  final VoidCallback onRefresh;
  final String firstColor;
  final String? mainGoalId;
  final int selectedDetailGoal;

  const AIPopup2({super.key, required this.selectedDetailGoal,  required this.subgoals, required this.onRefresh, required this.firstColor, required this.mainGoalId});

  @override
  _AIPopupState2 createState() => _AIPopupState2();
}

class _AIPopupState2 extends State<AIPopup2> {
  List<String> selectedGoals = [];
  late int howMany;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    howMany = Provider.of<TestInputtedActionPlanModel>(context, listen: false).countEmptyValues(widget.selectedDetailGoal)-1;
  }

  void _handleApply() {
  if (selectedGoals.length > howMany) {
    Fluttertoast.showToast(
      msg: "초과한 선택입니다. $howMany개만 선택할 수 있습니다.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  } else {
    // Provider를 listen: false로 호출하여 비어있는 key 리스트를 가져오고, key '4'는 제외
    final model = Provider.of<TestInputtedActionPlanModel>(context, listen: false);
    List<String> emptyKeys = model.getEmptyValueKeys(widget.selectedDetailGoal).where((key) => key != '4').toList();

    // 선택된 목표를 비어있는 key에 저장
    for (int i = 0; i < selectedGoals.length; i++) {
      if (i < emptyKeys.length) {
        model.updateTestActionPlan(widget.selectedDetailGoal, emptyKeys[i], selectedGoals[i]);
      } else {
        // 비어있는 key가 부족할 경우 경고를 표시하고 중단
        Fluttertoast.showToast(
          msg: "목표를 저장할 공간이 부족합니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        break;
      }
    }

    // 모든 작업이 완료되면 팝업 닫기
    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  DPcreateInput2Page(firstColor: widget.firstColor,
                                    mainGoalId: widget.mainGoalId),),
                              );
  }
}



  void _toggleGoal(String goal) {
    setState(() {
      if (selectedGoals.contains(goal)) {
        selectedGoals.remove(goal);
      } else {
        selectedGoals.add(goal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      elevation: 30.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      content: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          decoration: const BoxDecoration(
              color: Color(0xFFe0cbff),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                        height: 20,
                        child: Image.asset('assets/img/AI_icon.png')),
                    const SizedBox(width: 10),
                    const Text(
                      'AI 세부목표 추천',
                      style: TextStyle(
                          color: Color(0xFF4d00bb),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.close,
                    color: Color(0xFF4d00bb),
                    size: 17,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AICard(
                          goal: widget.subgoals[0],
                          isSelected: selectedGoals.contains(widget.subgoals[0]),
                          onTap: _toggleGoal,
                        ),
                        AICard(
                          goal: widget.subgoals[1],
                          isSelected: selectedGoals.contains(widget.subgoals[1]),
                          onTap: _toggleGoal,
                        ),
                        AICard(
                          goal: widget.subgoals[2],
                          isSelected: selectedGoals.contains(widget.subgoals[2]),
                          onTap: _toggleGoal,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AICard(
                          goal: widget.subgoals[3],
                          isSelected: selectedGoals.contains(widget.subgoals[3]),
                          onTap: _toggleGoal,
                        ),
                        AICard(
                          goal: widget.subgoals[4],
                          isSelected: selectedGoals.contains(widget.subgoals[4]),
                          onTap: _toggleGoal,
                        ),
                        AICard(
                          goal: widget.subgoals[5],
                          isSelected: selectedGoals.contains(widget.subgoals[5]),
                          onTap: _toggleGoal,
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: widget.onRefresh,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                        color: Color(0xFFCFADFF),
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '새로고침하기',
                        style: TextStyle(color: Color(0xFFCFADFF)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40,
                child: TextButton(
                  onPressed: _handleApply,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    backgroundColor: const Color(0xFF4D00BB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  child: const Text(
                    '지금 바로 적용하기',
                    style: TextStyle(color: Color(0xFFede0ff)),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}



class AICard extends StatefulWidget {
  final String goal;
  final bool isSelected; // 부모 위젯에서 상태를 관리하도록 추가
  final Function(String) onTap;

  const AICard({
    super.key,
    required this.goal,
    required this.isSelected,
    required this.onTap,
  });

  @override
  AICardState createState() => AICardState();
}

class AICardState extends State<AICard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 선택된 목표를 추가하거나 제거하는 로직
        widget.onTap(widget.goal);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.23,
              height: MediaQuery.of(context).size.width * 0.23,
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? const Color(0xFF4d00bb)
                    : const Color(0xFFe0cbff),
                border: Border.all(color: const Color(0xFFCFADFF)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: AutoSizeText(
                widget.goal,
                maxLines: 3,
                minFontSize: 6,
                maxFontSize: 13,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.isSelected
                      ? const Color(0xFFEDE0FF)
                      : const Color(0xFF4D00BB),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            top: 11,
            right: 11,
            child: Icon(
              widget.isSelected
                  ? Icons.circle
                  : Icons.circle_outlined, // 테두리가 있는 체크 아이콘
              color: const Color(0xFFCFADFF), // 체크 부분 색상
              size: 18, // 아이콘 크기
            ),
          ),
        ],
      ),
    );
  }
}


