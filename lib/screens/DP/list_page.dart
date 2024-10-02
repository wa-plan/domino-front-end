//DP 메인 페이지 (사용자의 만다라트 리스트)
import 'package:domino/widgets/DP/mandalart.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/DP/create_select_page.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/screens/DP/detail_page.dart';

class DPlistPage extends StatefulWidget {
  const DPlistPage({super.key});

  @override
  State<DPlistPage> createState() => _DPlistPageState();
}

class _DPlistPageState extends State<DPlistPage> {
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
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              color: const Color(0xff5C5C5C),
              iconSize: 35.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DPcreateSelectPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
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
                          child: MandalartGrid(
                            mandalart: mandalart,
                            secondGoals: secondGoals,
                            mandalartId: int.parse(mandalartId),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
