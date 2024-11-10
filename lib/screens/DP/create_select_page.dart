import 'package:domino/screens/DP/create99_page.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/widgets/DP/smallgrid.dart';
import 'package:domino/apis/services/dp_services.dart';

class DPcreateSelectPage extends StatefulWidget {
  List<Map<String, dynamic>> emptyMainGoals = [];
  DPcreateSelectPage({super.key, required this.emptyMainGoals});

  @override
  State<DPcreateSelectPage> createState() => _DPcreateSelectPageState();
}

class _DPcreateSelectPageState extends State<DPcreateSelectPage> {
  String? selectedGoalId;
  String selectedGoalName = '';
  List<Map<String, dynamic>> mainGoals = [];

  @override
  void initState() {
    super.initState();
    _mainGoalList();
  }

  void _mainGoalList() async {
    List<Map<String, dynamic>>? goals =
        await MainGoalListService.mainGoalList(context);
    if (goals != null) {
      setState(() {
        mainGoals = goals;
      });
    }
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
              height: 45,
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(3),
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
                    // emptyMainGoals를 사용하여 필터링
                    List<Map<String, dynamic>> emptyGoals =
                        widget.emptyMainGoals;
                    // filteredGoals에서 emptyGoals에 있는 목표 ID를 포함하는 목표만 필터링
                    List<dynamic> filteredGoals = snapshot.data!.where((goal) {
                      bool match = emptyGoals.any((emptyGoal) {
                        bool isMatch = emptyGoal['mandalartId'].toString() ==
                            goal['id'].toString();
                        print(
                            'Comparing mandalartId: ${emptyGoal['mandalartId']} with id: ${goal['id']} - Match: $isMatch');
                        return isMatch;
                      });
                      return match;
                    }).toList();

                    print('Filtered Goals: $filteredGoals');

                    if (filteredGoals.isEmpty) {
                      return const Center(
                        child: Text(
                          '만다라트를 생성할 목표가 없습니다.', // Message when no goal matches
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return DropdownButton<String>(
                      value: selectedGoalId,
                      items: [
                        const DropdownMenuItem<String>(
                          value: null, // 기본 선택 값은 null로 설정
                          child: Text(
                            '목표를 선택해 주세요.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ...filteredGoals.map<DropdownMenuItem<String>>((goal) {
                          final goalName = goal['name'] ?? 'Unknown Goal';
                          return DropdownMenuItem<String>(
                            value: goal['id'].toString(),
                            child: Text(
                              goalName,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }),
                      ],
                      onChanged: (String? value) {
                        if (value != null) {
                          final selectedGoal = snapshot.data!.firstWhere(
                            (goal) => goal['id'].toString() == value,
                          );
                          setState(() {
                            selectedGoalId = value;
                            selectedGoalName = selectedGoal['name'] ?? '';
                          });
                          context
                              .read<SelectFinalGoalModel>()
                              .selectFinalGoal(selectedGoalName);
                          context
                              .read<SelectFinalGoalId>()
                              .selectFinalGoalId(selectedGoalId!);
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: innerIndex == 4
                                  ? const Color(0xffFCFF62)
                                  : const Color(0xff929292),
                            ),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(1.0),
                            child: innerIndex == 4
                                ? Text(
                                    selectedGoalName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
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
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff131313),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  child: const Text(
                    '취소',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedGoalName != '') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DPcreate99Page(mainGoalId: selectedGoalId),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: '목표를 선택해 주세요.',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff131313),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  child: const Text(
                    "다음",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
