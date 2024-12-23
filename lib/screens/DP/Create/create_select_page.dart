import 'package:auto_size_text/auto_size_text.dart';
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

  @override
  void initState() {
    super.initState();
    _mainGoalList();
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

          if (secondGoals != null && secondGoals.isNotEmpty) {
            filteredGoals.add(goal);
          } else {
            emptySecondGoals.add(goal);
          }
        }
      }

      setState(() {
        mainGoals = filteredGoals;
        emptyMainGoals = emptySecondGoals;
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
          child: Text(
            '플랜 만들기',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: fullPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Text(
              "어떤 목표를 이루고 싶나요?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 13),
            Container(
              padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: const Color(0xff5C5C5C),
                ),
              ),
              child: FutureBuilder(
                future: MainGoalListService.mainGoalList(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        '목표를 불러오는 데 실패했습니다.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    List<Map<String, dynamic>> goals = emptyMainGoals;
                    List<Map<String, dynamic>> options = [
                      {'id': '0', 'name': '목표를 선택해 주세요.'},
                      ...goals
                    ];

                    return DropdownButton<String>(
                      value: selectedGoalId.isNotEmpty ? selectedGoalId : '0',
                      items: options.map<DropdownMenuItem<String>>((goal) {
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
                            final selectedGoal = options.firstWhere(
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
                      dropdownColor: const Color(0xff262626),
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      underline: Container(),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        '목표가 없습니다.',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            if (showGrid) // showGrid가 true일 때만 그리드 표시
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
                                                            minFontSize: 6, // 최소 글씨 크기
                                                            overflow: TextOverflow.ellipsis, // 내용이 너무 길 경우 생략 표시
                                        selectedGoalName,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
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
              ),
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
                    Message('목표를 선택해 주세요.', Colors.black, Colors.white)
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
