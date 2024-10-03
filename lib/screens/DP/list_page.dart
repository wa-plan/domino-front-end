//DP 메인 페이지 (사용자의 만다라트 리스트)
import 'package:domino/widgets/DP/mandalart.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/DP/create_select_page.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/screens/DP/detail_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // 추가


class DPlistPage extends StatefulWidget {
  const DPlistPage({super.key});

  @override
  State<DPlistPage> createState() => _DPlistPageState();
}

class _DPlistPageState extends State<DPlistPage> {
  List<Map<String, dynamic>> mainGoals = [];
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
      setState(() {
        mainGoals = goals;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose(); // PageController 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff262626),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff262626),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(
            '도미노 플랜',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  color: const Color(0xff5C5C5C),
                  iconSize: 35.0,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DPcreateSelectPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                controller: _pageController, // PageController 연결
                itemCount: mainGoals.length,
                itemBuilder: (context, index) {
                  final goal = mainGoals[index];
                  final mandalartId = goal['id'].toString();
                  return FutureBuilder<List<Map<String, dynamic>>?>(
                    future: SecondGoalListService.secondGoalList(
                        context, mandalartId),
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
                        
                        as List<Map<String, dynamic>>;

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
                          child: Column(
                            children: [
                              Text(
                                mandalart,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20),
                              MandalartGrid(
                                mandalart: mandalart,
                                secondGoals: secondGoals,
                                mandalartId: int.parse(mandalartId),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SmoothPageIndicator(  // PageIndicator 추가
              controller: _pageController,  // PageController 연결
              count: mainGoals.length,  // 총 페이지 수
              effect: const ColorTransitionEffect(  // 스타일 설정
                dotHeight: 10.0,
                dotWidth: 10.0,
                activeDotColor: Color(0xffFF6767),
                dotColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20), // 간격 조절
          ],
        ),
      ),
    );
  }
}