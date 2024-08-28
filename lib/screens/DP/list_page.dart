import 'package:flutter/material.dart';
import 'package:domino/screens/DP/create_select_page.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/apis/services/dp_services.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PopupMenuButton(
                  iconColor: const Color(0xff5C5C5C),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '삭제하기',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '수정하기',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        print('edit');
                        break;
                      case 'delete':
                        print('delete');
                        break;
                    }
                  },
                ),
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
              ],
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
                        final secondGoals = data[0]['secondGoals'] as List;

                        Widget buildGrid(int secondGoalIndex, String type) {
                          return SizedBox(
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 3,
                                    mainAxisSpacing: 3,
                                  ),
                              itemCount: 9,
                              itemBuilder: (context, gridIndex) {
                                if (gridIndex == 4) {
                                  // Center of the grid
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: type == 'mandalart' ? Colors.yellow : const Color(0xff929292),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        type == 'mandalart'
                                            ? mandalart
                                            : secondGoals[secondGoalIndex]['secondGoal'],
                                        style: const TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                } else {
                                  final adjustedIndex = gridIndex < 4
                                      ? gridIndex
                                      : gridIndex - 1;
                                  if (adjustedIndex < secondGoals.length) {
                                    final secondGoalData = secondGoals[secondGoalIndex];
                                    final thirdGoals = (secondGoalData['thirdGoals'] as List?) ?? [];
                                    
                                    if (type == 'mandalart') {
                                      if (adjustedIndex < secondGoals.length) {
                                        final secondGoal = secondGoals[adjustedIndex]['secondGoal'];
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xff929292),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                          child: Center(
                                            child: Text(
                                              secondGoal,
                                              style: const TextStyle(color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xff929292),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                        );
                                      }
                                    } else {
                                      // Filter out empty third goals
                                      final validThirdGoals = thirdGoals.where(
                                        (goal) => goal['thirdGoal'] != null && goal['thirdGoal'].isNotEmpty
                                      ).toList();
                                      
                                      if (adjustedIndex < validThirdGoals.length) {
                                        final thirdGoal = validThirdGoals[adjustedIndex]['thirdGoal'];
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xff5C5C5C),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                          child: Center(
                                            child: Text(
                                              thirdGoal,
                                              style: const TextStyle(color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xff262626),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                        );
                                      }
                                    }
                                  } else {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xff262626),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          );
                        }

                        return GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3,
                              ),
                          children: [
                            buildGrid(0, 'secondGoal'), 
                            buildGrid(1, 'secondGoal'), 
                            buildGrid(2, 'secondGoal'), 
                            buildGrid(3, 'secondGoal'), 
                            buildGrid(4, 'mandalart'), 
                            buildGrid(5, 'secondGoal'), 
                            buildGrid(6, 'secondGoal'), 
                            buildGrid(7, 'secondGoal'), 
                            buildGrid(8, 'secondGoal'),  
                          ],
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
