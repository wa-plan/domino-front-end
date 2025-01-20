// DP 메인 페이지
import 'package:domino/provider/DP/model.dart';
import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/DP_main_mandalart.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/DP/Create/create_select_page.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/screens/DP/Detail/detail_9x9_page.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DPMain extends StatefulWidget {
  const DPMain({super.key});

  @override
  State<DPMain> createState() => _DPMainState();
}

class _DPMainState extends State<DPMain> {
  List<Map<String, dynamic>> mainGoals = [];
  List<Map<String, dynamic>> emptyMainGoals = [];
  final PageController _pageController = PageController();
  List<Map<String, String>> inProgressID = [];

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
      List<Map<String, dynamic>> emptySecondGoals =
          []; // 비어 있는 secondGoals를 위한 리스트 추가
      List<Map<String, String>> inProgressID =
          Provider.of<GoalOrder>(context, listen: false).goalOrder;

      print('inProgressIDs : $inProgressID'); //쓰러뜨릴목표
      print('goals : $goals'); //전체목표

      for (var goal in inProgressID) {
        final mandalartId = goal['id'].toString();
        final name = goal['name']; // 목표의 이름 가져오기

        // Fetch second goals to check their content
        final data = await _fetchSecondGoals(mandalartId);
        if (data != null) {
          final secondGoals =
              data[0]['secondGoals'] as List<Map<String, dynamic>>?;

          // Only add the goal if secondGoals is not null and not empty
          if (secondGoals != null &&
              secondGoals.isNotEmpty &&
              secondGoals != "") {
            filteredGoals.add(goal);
          } else {
            // secondGoals가 비어있을 경우 mandalartId와 name을 emptySecondGoals 리스트에 추가
            emptySecondGoals.add({
              'mandalartId': mandalartId,
              'name': name,
            });
            print('empty = $emptySecondGoals');
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
    return await SecondGoalListService.secondGoalList(context, mandalartId);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
          child: Text('도미노 플랜', style: Theme.of(context).textTheme.titleLarge),
        ),
        backgroundColor: backgroundColor,
      ),
      bottomNavigationBar: const NavBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 10, 25.0, 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  color: const Color(0xffD4D4D4),
                  iconSize: 30,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    //여기에 Provider 초기화 코드 삽입
                    //먼저 secondGoal 초기화 코드
                    for (int i = 0; i < 9; i++) {
                      context
                          .read<SaveInputtedDetailGoalModel>()
                          .updateDetailGoal("$i", "");
                    }
                    //다음 color 초기화 코드
                    for (int i = 0; i < 9; i++) {
                      context
                          .read<GoalColor>()
                          .updateGoalColor("$i", const Color(0xff929292));
                    }
                    //마지막으로 thirdGoal 초기화 코드
                    for (int i = 0; i < 9; i++) {
                      for (int j = 0; j < 9; j++) {
                        context
                            .read<SaveInputtedActionPlanModel>()
                            .updateActionPlan(i, "$j", "");
                      }
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DPcreateSelectPage(
                          emptyMainGoals: emptyMainGoals,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 5),
            Expanded(
              child: mainGoals.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff2A2A2A),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Center(
                        child: Text(
                          '목표를 달성하기 위한\n플랜을 만들어봐요.',
                          style: TextStyle(
                            color: Color.fromARGB(255, 146, 146, 146),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : PageView.builder(
                      controller: _pageController,
                      itemCount: mainGoals.length,
                      itemBuilder: (context, index) {
                        final goal = mainGoals[index];
                        final mandalartId = goal['id'].toString();

                        return FutureBuilder<List<Map<String, dynamic>>?>(
                          future: _fetchSecondGoals(mandalartId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text(
                                  '데이터를 불러오는 데 실패했습니다.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text(
                                  '목표가 없습니다.',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            } else {
                              final data = snapshot.data!;
                              final firstColor = data[0]['color'];
                              final mandalart = data[0]['mandalart'];
                              final secondGoals = data[0]['secondGoals']
                                  as List<Map<String, dynamic>>?;

                              if (secondGoals == null || secondGoals.isEmpty) {
                                return const SizedBox.shrink();
                              }

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DPdetailPage(
                                        mandalart: mandalart,
                                        secondGoals: secondGoals,
                                        mandalartId: int.parse(mandalartId),
                                        firstColor: firstColor,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 15),
                                      Text(
                                        mandalart,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      MandalartGrid(
                                        mandalart: mandalart,
                                        firstColor: firstColor,
                                        secondGoals: secondGoals,
                                        mandalartId: int.parse(mandalartId),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
            ),

            const SizedBox(height: 40),
            SmoothPageIndicator(
              // PageIndicator 추가
              controller: _pageController, // PageController 연결
              count: mainGoals.length, // 총 페이지 수
              effect: const ColorTransitionEffect(
                  // 스타일 설정
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  activeDotColor: Color(0xffFF6767),
                  dotColor: Colors.grey),
            ),
            const SizedBox(height: 20), // 간격 조절
          ],
        ),
      ),
    );
  }
}
