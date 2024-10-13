import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/apis/services/td_services.dart';
import 'package:domino/screens/TD/td_main.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/TD/add_page2.dart';
import 'package:domino/widgets/DP/mandalart2.dart';
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
  int secondGoalId = 0;

  @override
  void initState() {
    super.initState();
    secondGoalId = 0;
    _mainGoalList();
  }

  void mandalartInfo(context, int mandalartId) async {
    final success = await MandalartInfoService.mandalartInfo(context,
        mandalartId: mandalartId);
    if (success) {
      // 성공적으로 서버에 전송된 경우에 처리할 코드
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('도미노가 조회되었습니다.')),
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TdMain(),
          ));
    } else {
      // 실패한 경우에 처리할 코드
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
    // Fetch second goals based on the selected mandalartId
    List<Map<String, dynamic>>? result =
        await SecondGoalListService.secondGoalList(context, mandalartId);

    if (result != null && result.isNotEmpty) {
      setState(() {
        secondGoals = result[0]['secondGoals']; // 제2목표 정보
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int secondGoalId =
        int.tryParse(context.watch<SelectAPModel>().selectedAPID.toString()) ??
            0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(
            '도미노 만들기',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: const Color(0xff262626),
      ),
      backgroundColor: const Color(0xff262626),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '어떤 목표를 달성하기 위한 \n도미노인가요?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 43,
                  decoration: BoxDecoration(
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
                        List<Map<String, dynamic>> goals = snapshot.data!;

                        // Add a default option at the start
                        List<Map<String, dynamic>> options = [
                          {'id': '0', 'name': '선택 안됨'},
                          ...goals
                        ]; // Add goals after the default option

                        return DropdownButton<String>(
                          value: selectedGoalId.isNotEmpty
                              ? selectedGoalId
                              : '0', // Default to '선택 안됨'
                          items: options.map<DropdownMenuItem<String>>((goal) {
                            final goalName = goal['name'] ?? 'Unknown Goal';
                            return DropdownMenuItem<String>(
                              value: goal['id']
                                  .toString(), // Ensure the value is the id (string)
                              child: Text(
                                goalName,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              if (value == '0') {
                                setState(() {
                                  selectedGoalName =
                                      ''; // Clear if '선택 안됨' is selected
                                  selectedGoalId = '';
                                });
                              } else {
                                final selectedGoal = options.firstWhere(
                                    (goal) => goal['id'].toString() == value);
                                setState(() {
                                  selectedGoalName = selectedGoal['name'] ?? '';
                                  selectedGoalId = value;
                                });
                                _fetchSecondGoals(selectedGoalId);
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
                )
              ],
            ),
            if (selectedGoalName != "") ...[
              const SizedBox(height: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('어떤 플랜과 관련됐나요?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Center(
                        child: MandalartGrid2(
                          mandalart: selectedGoalName,
                          secondGoals: secondGoals,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              /*Text(
                context.watch<SelectAPModel>().selectedAPID.toString(),
                style: const TextStyle(color: Colors.white),
              ),*/
              Text(
                secondGoalId.toString(),
                style: const TextStyle(color: Colors.white),
              )
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TdMain(),
                        ));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff131313),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: const Text(
                    '취소',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ), //취소 버튼
                if (selectedGoalName != "")
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPage2(
                              secondGoalId: secondGoalId,
                            ),
                          ));
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff131313),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0))),
                    child: const Text(
                      '다음',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ), //다음 버튼
                TextButton(
                    onPressed: () {
                      mandalartInfo(context, 1);
                    },
                    child: const Text('test'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
