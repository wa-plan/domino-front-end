import 'package:auto_size_text/auto_size_text.dart';
import 'package:domino/apis/services/mg_services.dart';
import 'package:domino/screens/DP/Create/create99_page.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/widgets/DP/Create/DP_dropdown_mandalart.dart';
import 'package:domino/apis/services/dp_services.dart';

class DPcreateSelectPage extends StatefulWidget {
  final List<Map<String, dynamic>> emptyMainGoals;
  const DPcreateSelectPage({super.key, required this.emptyMainGoals});

  @override
  State<DPcreateSelectPage> createState() => _DPcreateSelectPageState();
}

class _DPcreateSelectPageState extends State<DPcreateSelectPage> {
  String selectedGoalId = "";
  String selectedGoalName = '';
  List<Map<String, dynamic>> mainGoals = [];
  List<Map<String, dynamic>> emptyMainGoals = [];
  List<Map<String, dynamic>> secondGoals = [];
  String firstColor = "0xff000000";
  bool showGrid = false; // 그리드 표시 여부를 결정하는 변수
  bool isLoading = true; // 로딩 상태 관리

  @override
  void initState() {
    super.initState();
    _mainGoalList(); // 데이터 로딩 함수 호출
  }

  void _mainGoalList() async {
    List<Map<String, dynamic>>? goals =
        await MainGoalListService.mainGoalList(context);
    if (goals != null) {
      List<Map<String, dynamic>> filteredGoals = [];
      List<Map<String, dynamic>> emptySecondGoals = [];

      for (var goal in goals) {
        final mandalartId = goal['id'].toString();
        final data = await _fetchSecondGoals(mandalartId);
        if (data != null) {
          final secondGoals =
              data[0]['secondGoals'] as List<Map<String, dynamic>>?;

          // UserMandaInfoService를 호출하여 추가 조건 검사
          final userMandaInfo = await UserMandaInfoService.userMandaInfo(
              context,
              mandalartId: int.parse(mandalartId));

          if (secondGoals != null &&
              secondGoals.every((goal) => goal.isEmpty) &&
              userMandaInfo != null &&
              userMandaInfo['status'] == "IN_PROGRESS") {
            emptySecondGoals.add(goal);
          } else {
            filteredGoals.add(goal);
          }
        }
      }

      setState(() {
        mainGoals = filteredGoals;
        emptyMainGoals = emptySecondGoals;
        isLoading = false; // 데이터 로딩 완료 후 로딩 상태 해제
      });
    }
  }

  Future<List<Map<String, dynamic>>?> _fetchSecondGoals(
      String mandalartId) async {
    List<Map<String, dynamic>>? result =
        await SecondGoalListService.secondGoalList(context, mandalartId);

    if (result != null && result.isNotEmpty) {
      setState(() {
        secondGoals = result[0]['secondGoals'];
        firstColor = result[0]['color'];
      });
    }

    return result;
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
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
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
      body: Padding(
        padding: fullPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              
              children: [
                const Text(
                  "어떤 목표를 이루고 싶나요?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 4,
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            // 첫 번째 색상
                            Container(
                              decoration: BoxDecoration(
                                color: mainRed, // 첫 번째 색상
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              width: 6,
                              height: 13, // 첫 번째 높이 (6.0으로 고정)
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            // 두 번째 색상
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 86, 86, 86), // 두 번째 색상
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              width: 6,
                              height: 18, // 두 번째 높이 (예: 10 추가)
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            // 세 번째 색상
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 86, 86, 86),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              width: 6,
                              height: 23, // 세 번째 높이 (예: 20 추가)
                            ),
                  ],
                ),

              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: const Color.fromARGB(255, 147, 147, 147),
                  width: 0.5
                ),
              ),
              child: isLoading // 로딩 상태에 따라 표시 변경
                  ? const Center(child: CircularProgressIndicator(
                    color: mainRed,
                    strokeWidth: 4,
                    backgroundColor: Color.fromARGB(255, 79, 79, 79),
                    strokeCap: StrokeCap.round,
                  ))
                  : DropdownButton<String>(
                      value: isLoading || selectedGoalId.isEmpty
                          ? '0'
                          : selectedGoalId,
                      items: [
                        {'id': '0', 'name': '목표를 선택해 주세요.'},
                        ...emptyMainGoals,
                      ].map<DropdownMenuItem<String>>((goal) {
                        final goalName = goal['name'] ?? 'Unknown Goal';
                        return DropdownMenuItem<String>(
                          value: goal['id'].toString(),
                          child: Text(
                            goalName,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) async {
                        if (value != null) {
                          setState(() {
                            selectedGoalId = value;
                            showGrid = value != '0'; // 기본 옵션 선택 시 그리드 숨기기
                            if (value == '0') {
                              selectedGoalName = '';
                            }
                          });

                          if (value != '0') {
                            final selectedGoal = [
                              {'id': '0', 'name': '목표를 선택해 주세요.'},
                              ...emptyMainGoals
                            ].firstWhere(
                              (goal) => goal['id'].toString() == value,
                            );
                            selectedGoalName = selectedGoal['name'] ?? '';
                            context
                                .read<SelectFinalGoalModel>()
                                .selectFinalGoal(selectedGoalName);
                            context
                                .read<SelectFinalGoalId>()
                                .selectFinalGoalId(selectedGoalId);

                            await _fetchSecondGoals(selectedGoalId);
                          }
                        }
                      },
                      isExpanded: true,
                      dropdownColor: const Color.fromARGB(255, 28, 28, 28),
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: const Color.fromARGB(255, 147, 147, 147),
                      underline: Container(),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(7),
                    ),
            ),
            const SizedBox(height: 20),
            if (showGrid)
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  children: List.generate(9, (index) {
                    if (index == 4) {
                      return SizedBox(
                        width: 100,
                        child: GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          children: List.generate(9, (innerIndex) {
                            return Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: innerIndex == 4
                                    ? Color(int.parse(firstColor
                                        .replaceAll('Color(', '')
                                        .replaceAll(')', '')))
                                    : const Color(0xff929292),
                              ),
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(1.0),
                              child: innerIndex == 4
                                  ? Center(
                                      child: AutoSizeText(
              maxLines: 3, // 최대 줄 수 (필요에 따라 변경 가능)
              minFontSize: 6,
              maxFontSize: 13, // 최소 글씨 크기
              overflow: TextOverflow.ellipsis, // 내용이 너무 길 경우 생략 표시
              selectedGoalName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: backgroundColor,
                fontWeight: FontWeight.w600,
              ))
                                    )
                                  : const Text(""),
                            );
                          }),
                        ),
                      );
                    } else {
                      return const Smallgrid();
                    }
                  }),
                ),
              )
            else
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: const Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/Dominho_mono.png',
                            height: 100,
                          ),
                          const SizedBox(width: 15)
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '두근두근\n어떤 목표를 이뤄볼까?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 146, 146, 146),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(Colors.black, Colors.white, '취소', () {
                  Navigator.pop(context);
                }).button(),
                Button(Colors.black, Colors.white, '다음', () {
                  if (selectedGoalName != '') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DPcreate99Page(
                            mainGoalId: selectedGoalId, firstColor: firstColor),
                      ),
                    );
                  } else {
                    Message('목표를 선택해 주세요.', const Color(0xffFF6767),
                            const Color(0xff412C2C),
                            borderColor: const Color(0xffFF6767),
                            icon: Icons.priority_high)
                        .message(context);
                  }
                }).button(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
