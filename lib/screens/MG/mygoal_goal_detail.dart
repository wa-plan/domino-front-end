import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:typed_data'; // Uint8List 사용을 위한 라이브러리 임포트
import 'package:domino/screens/MG/mygoal_goal_edit.dart';

class MyGoalDetail extends StatefulWidget {
  const MyGoalDetail({super.key});

  @override
  MyGoalDetailState createState() => MyGoalDetailState();
}

class MyGoalDetailState extends State<MyGoalDetail> {
  final _status = ['진행 중', '달성 완료', '달성 실패'];
  String? _selectedStatus;
  // 선택된 파일 리스트를 관리할 변수 추가
  List<Uint8List> selectedFiles = [];
  bool bookmark = false;
  String o = '60';
  String v = '30';
  String x = '10';

  @override
  void initState() {
    super.initState();
    _selectedStatus = _status[0];
  } // 목표 진행 상황 드랍다운 리스트 초기화

  void _onFileSelected() {
    // 파일 선택 로직 (예시로 빈 리스트를 추가)
    setState(() {
      selectedFiles.add(Uint8List.fromList([])); // 빈 바이트 리스트 추가
    });
  }

  void _removeFile(int index) {
    setState(() {
      selectedFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '환상적인 세계여행',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.06,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff262626),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MygoalEdit()));
            },
            icon: const Icon(Icons.edit),
            color: Colors.grey,
          ),
        ],
      ), // Icon Theme 지정
      backgroundColor: const Color(0xff262626),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  "D-100",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "이 목표는   ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white, width: 0.5), // White border
                        borderRadius: BorderRadius.circular(
                            5), // Optional: rounded corners
                      ),
                      child: DropdownButton<String>(
                        underline: const SizedBox.shrink(),
                        dropdownColor: const Color(0xff262626),
                        iconEnabledColor: Colors.white,
                        value: _selectedStatus,
                        items: _status
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e,
                                child: Center(
                                  child: Text(e),
                                ),
                              ),
                            )
                            .toList(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        onChanged: (value) {
                          setState(() {
                            _selectedStatus = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      bookmark = !bookmark;
                    });
                  },
                  icon: const Icon(Icons.star),
                  color: bookmark ? Colors.yellow : Colors.grey,
                  iconSize: 35,
                )
              ],
            ),
            const Flexible(
              child: Text(
                "아시아부터 유럽, 아프리카까지 세계 곳곳을 뚜벅뚜벅 나홀로 여행하며 세상을 보는 눈을 넓히고 싶다! 일탈하고 싶다!",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const Text('할 일 달성 통계',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.grey),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.circle_outlined),
                          Text(
                            '=$o개',
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.change_history_outlined),
                          Text(
                            '=$v개',
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.clear_outlined),
                          Text(
                            '=$x개',
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )

            /*Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_a_photo, color: Colors.white),
                  onPressed: _onFileSelected, // 파일 선택 로직 추가
                ),
                const SizedBox(width: 16),
                selectedFiles.isNotEmpty
                    ? Expanded(
                        child: SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: selectedFiles.length,
                            itemBuilder: (context, i) {
                              final imageBytes = selectedFiles[i];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        color: Colors.white,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(4),
                                        child: Image.memory(
                                          imageBytes,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey,
                                              alignment: Alignment.center,
                                              child: const Text('not found'),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: () => _removeFile(i),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : const SizedBox(width: 80, height: 80),
              ],
            ), // Goal 업로드한 이미지 불러오기
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                percent: 0.67, // 목표 진행률
                barRadius: const Radius.circular(10),
                progressColor: Colors.red,
              ),
            ), // Percentage 표시  */
          ],
        ),
      ),
    );
  }
}
