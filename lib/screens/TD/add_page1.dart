import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/apis/services/td_services.dart';
import 'package:domino/screens/TD/td_main.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/TD/add_page2.dart';
import 'package:domino/widgets/DP/mandalart2.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class AddPage1 extends StatefulWidget {
  const AddPage1({super.key});

  @override
  State<AddPage1> createState() => _AddPage1State();
}

class _AddPage1State extends State<AddPage1> {
  String selectedGoalName = "";
  String nextStage = '';
  List<Map<String, dynamic>> secondGoals = [];
  List<Map<String, dynamic>> mainGoals = []; // 데이터의 타입 변경
  int mandalartId = 1;
  String selectedGoalId = "";
  int thirdGoalId = 0;

  @override
  void initState() {
    super.initState();
    thirdGoalId = 0;
    _mainGoalList();
  }

  void mandalartInfo(context, int mandalartId) async {
    final success = await MandalartInfoService.mandalartInfo(context,
        mandalartId: mandalartId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('도미노가 조회되었습니다.')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TdMain(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('도미노 조회에 실패했습니다.')),
      );
    }
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

  void _fetchSecondGoals(String mandalartId) async {
    List<Map<String, dynamic>>? result =
        await SecondGoalListService.secondGoalList(context, mandalartId);

    if (result != null && result.isNotEmpty) {
      setState(() {
        secondGoals = result[0]['secondGoals'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> createdGoals = context.watch<SaveMandalartCreatedGoal>().mandalartCreatedGoal;
    int thirdGoalId =
        int.tryParse(context.watch<SelectAPModel>().selectedAPID.toString()) ?? 0;

    String thirdGoalName =
        context.watch<SelectAPModel>().selectedAPName.toString();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Padding(
          padding: appBarPadding,
          child: Text(
            '도미노 만들기',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: fullPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5),
                const Text(
                  '어떤 목표를 달성하고 싶나요?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
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
                        // createdGoals에 있는 목표만 필터링
                        List<Map<String, dynamic>> goals = snapshot.data!
                            .where((goal) => createdGoals.contains(goal['id'].toString()))
                            .toList();

                        // 기본 옵션을 시작으로 추가
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
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                selectedGoalId = value;
                                if (value == '0') {
                                  selectedGoalName = '';
                                } else {
                                  final selectedGoal = options.firstWhere(
                                    (goal) => goal['id'].toString() == value,
                                  );
                                  selectedGoalName = selectedGoal['name'] ?? '';
                                  _fetchSecondGoals(selectedGoalId);
                                }
                              });
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
              ],
            ),
            if (selectedGoalName != "") ...[
              const SizedBox(height: 28),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      '어떤 플랜과 관련됐나요?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: const Color(0xff2A2A2A),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: MandalartGrid2(
                            mandalart: selectedGoalName,
                            secondGoals: secondGoals,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //취소버튼
                Button(Colors.black, Colors.white, '취소', 
                () => Navigator.pop(context)).button(),

                //다음버튼
                Button(Colors.black, Colors.white, '다음', 
                (){
                  if (thirdGoalName != "플랜을 선택해주세요.") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPage2(
                            thirdGoalId: thirdGoalId,
                            thirdGoalName: thirdGoalName,
                          ),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: '플랜을 선택해주세요.',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.white,
                        textColor: backgroundColor,
                      );
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
