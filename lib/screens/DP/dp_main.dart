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
      body: SingleChildScrollView(
        child: Padding(
          padding: fullPadding,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //만다라트 추가 버튼
                  CustomIconButton(() {
                    //기존 Create 기능에 저장된 secondGoal 초기화
                    for (int i = 0; i < 9; i++) {
                      context
                          .read<SaveInputtedDetailGoalModel>()
                          .updateDetailGoal("$i", "");
                    }
                    //color 초기화
                    for (int i = 0; i < 9; i++) {
                      context
                          .read<GoalColor>()
                          .updateGoalColor("$i", const Color(0xff929292));
                    }
                    //thirdGoal 초기화
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
                  }, Icons.add)
                      .customIconButton(),
                ],
              ),
              const SizedBox(height: 10),
              mainGoals.isEmpty
                  ? Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xff2D2D2D),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          // 텍스트: 좌측 상단 정렬
                          Positioned(
                            top: 30, // 텍스트의 상단 여백
                            left: 30, // 텍스트의 좌측 여백
                            child: Text(
                              '아직 플랜이 없어요.\n목표를 이루려면\n철저한 계획은 필수!',
                              style: TextStyle(
                                  color: const Color(0xff464646),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.w700,
                                  height: 1.7),
                            ),
                          ),
                          // 이미지: 우측 하단 정렬
                          Positioned(
                            bottom: 0, // 이미지의 하단 여백
                            right: 0, // 이미지의 우측 여백
                            child: Image.asset(
                              'assets/img/emptyDominho.png',
                              height: 230, // 이미지 크기 유지
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 800,
                      child: PageView.builder(
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

                                if (secondGoals == null ||
                                    secondGoals.isEmpty) {
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
                                        vertical: 10, horizontal: 0),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 7, 0, 7),
                                          decoration: BoxDecoration(
                                            color: const Color(0xff2B2B2B),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 7,
                                                height: 18,
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorTransform(firstColor).colorTransform(),
                                                  borderRadius:
                                                      BorderRadius.circular(1),
                                                ),
                                              ),
                                              Text(
                                                mandalart,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Container(
                                                width: 7,
                                                height: 18,
                                                decoration: BoxDecoration(
                                                  color:
                                                      Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(1),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 20, 40, 40),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: MandalartGrid(
                                            mandalart: mandalart,
                                            firstColor: firstColor,
                                            secondGoals: secondGoals,
                                            mandalartId: int.parse(mandalartId),
                                          ),
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
              if (mainGoals.length != 1)
                PageIndicator(_pageController, mainGoals).pageIndicator(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
