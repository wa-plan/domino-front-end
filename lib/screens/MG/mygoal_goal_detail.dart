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
      backgroundColor: const Color(0xff262626),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff262626),
        title: const Text(
          "목표 제목",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
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
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Text(
                    "이 목표는 ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  DropdownButton<String>(
                    value: _selectedStatus,
                    items: _status
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value!;
                      });
                    },
                  ),
                ],
              ),
            ), // 목표 진행상황 변경
            Row(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        color: Colors.white,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
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
            ), // Percentage 표시
          ],
        ),
      ),
    );
  }
}
