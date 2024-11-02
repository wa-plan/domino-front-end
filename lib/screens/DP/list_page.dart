// DP 메인 페이지 (사용자의 만다라트 리스트)
import 'package:domino/provider/DP/model.dart';
import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/mandalart.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/DP/create_select_page.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/screens/DP/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // 추가

class DPlistPage extends StatefulWidget {
  const DPlistPage({super.key});

  @override
  State<DPlistPage> createState() => _DPlistPageState();
}

class _DPlistPageState extends State<DPlistPage> {
  List<Map<String, dynamic>> mainGoals = [];
  List<Map<String, dynamic>> emptyMainGoals = [];
  final PageController _pageController = PageController(); // PageController 추가

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

      for (var goal in goals) {
        final mandalartId = goal['id'].toString();
        final name = goal['name']; // 목표의 이름 가져오기

        // Fetch second goals to check their content
        final data = await _fetchSecondGoals(mandalartId);
        if (data != null) {
          final secondGoals =
              data[0]['secondGoals'] as List<Map<String, dynamic>>?;

          // Only add the goal if secondGoals is not null and not empty
          if (secondGoals != null && secondGoals.isNotEmpty) {
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
        emptyMainGoals = emptySecondGoals; // Update state with filtered goals
        // 필요에 따라 emptySecondGoals 리스트를 다른 상태 변수에 저장할 수 있습니다.
        // 예를 들어:
        // this.emptyGoals = emptySecondGoals;
      });
    }
  }

  Future<List<Map<String, dynamic>>?> _fetchSecondGoals(
      String mandalartId) async {
    return await SecondGoalListService.secondGoalList(context, mandalartId);
  }

  @override
  void dispose() {
    _pageController.dispose(); // PageController 해제
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
              child: PageView.builder(
                controller: _pageController, // PageController 연결
                itemCount: mainGoals.length,
                itemBuilder: (context, index) {
                  final goal = mainGoals[index];
                  final mandalartId = goal['id'].toString();

                  return FutureBuilder<List<Map<String, dynamic>>?>(
                    future: _fetchSecondGoals(mandalartId), // 새로 만든 함수 사용
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            '데이터를 불러오는 데 실패했습니다.',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            '목표가 없습니다.',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        final data = snapshot.data!;
                        final mandalart = data[0]['mandalart'];
                        final secondGoals = data[0]['secondGoals']
                            as List<Map<String, dynamic>>?;

                        // secondGoals가 null이거나 비어있는 경우 해당 항목을 건너뜀
                        if (secondGoals == null || secondGoals.isEmpty) {
                          return const SizedBox
                              .shrink(); // 빈 위젯 반환하여 해당 페이지를 스킵
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
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xff2A2A2A),
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
                dotColor: Colors.grey
              ),
            ),
            const SizedBox(height: 20), // 간격 조절
          ],
        ),
      ),
    );
  }
}
