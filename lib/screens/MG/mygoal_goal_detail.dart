import 'package:domino/screens/MG/piechart.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data'; // Uint8List 사용을 위한 라이브러리 임포트
import 'package:domino/screens/MG/mygoal_goal_edit.dart';
import 'package:domino/apis/services/mg_services.dart';

class MyGoalDetail extends StatefulWidget {
  final String id;

  const MyGoalDetail({super.key, required this.id});

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
  String name = '';
  int dday = -8; // 추가: D-day
  int parsedId = 0;
  bool hasNoImages = false;
  Color color = const Color(0xffFCFF62);
  String description = "아시아부터 유럽, 아프리카까지 세계 곳곳을 뚜벅뚜벅 나홀로 여행하며 세상을 보는 눈을 넓히고 싶다! 일탈하고 싶다!";

  // GoalImage 리스트 정의
  List<GoalImage> goalImage = [
    GoalImage(image: 'assets/img/profile_smp1.png', name: 'Image 1'),
    GoalImage(image: 'assets/img/profile_smp2.png', name: 'Image 2'),
    GoalImage(image: 'assets/img/profile_smp3.png', name: 'Image 3'),
    GoalImage(image: 'assets/img/profile_smp4.png', name: 'Image 4'),
    GoalImage(image: 'assets/img/profile_smp5.png', name: 'Image 5'),
    GoalImage(image: 'assets/img/profile_smp6.png', name: 'Image 6'),
    GoalImage(image: 'assets/img/profile_smp7.png', name: 'Image 7'),
    GoalImage(image: 'assets/img/profile_smp8.png', name: 'Image 8'),
    // 추가 이미지...
  ];

  List<String> goalImage2 = [
    'assets/img/profile_smp1.png',
    'assets/img/profile_smp2.png',
    // 추가 이미지...
  ];

  void userMandaInfo(context, int mandalartId) async {
    final data = await UserMandaInfoService.userMandaInfo(context,
        mandalartId: mandalartId);
    if (data != null) {
      // 클래스 변수에 데이터를 저장
      setState(() {
        name = data['name'] ?? ''; // 이제 name이 클래스 변수에 저장됨
        String status = data['status'] ?? '';
        List<dynamic> photoList = data['photoList'] ?? [];
        int dday = -8; // 추가: D-day
        String ddayString = '-8';

        if (photoList.isNotEmpty) {
          goalImage = photoList.map((photo) {
            return GoalImage(image: photo['url'], name: photo['name']);
          }).toList();
          hasNoImages = false;
        } else {
          goalImage.clear(); // photoList가 비어있으면 goalImage를 비움
          hasNoImages = true;
        }

        print('목표 이름: $name');
        print('상태: $status');
        print('사진 리스트: $photoList');
        print('디데이: $dday');
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('만다라트 조회에 실패했습니다.')),
      );
    }
  }

  void _mandaBookmark(int id, String bookmark) async {
    final success = await MandaBookmarkService.MandaBookmark(
      id: id,
      bookmark: bookmark,
    );
    if (success) {
      print('성공');
    }
  }

  void _mandaProgress(int id, String status) async {
    final success = await MandaProgressService.MandaProgress(
      id: id,
      status: status,
    );
    if (success) {
      print('성공');
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedStatus = _status[0];
    int parsedId = int.parse(widget.id);
    userMandaInfo(context, parsedId);
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
          name,
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
                  MaterialPageRoute(builder: (context) => MygoalEdit(
                    dday: dday,
                    name: name,
                    description: description,
                    color: color,
                    goalImage: goalImage2,
                  )));
            },
            icon: const Icon(Icons.edit),
            color: Colors.grey,
          ),
        ],
      ), // Icon Theme 지정
      backgroundColor: const Color(0xff262626),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(38.0, 5.0, 40.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    dday.toString(),
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
                        height: 30,
                        width: 90,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white, width: 0.7), // White border
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
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
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
                        String bookmarkAction =
                            bookmark ? "BOOKMARK" : "UNBOOKMARK";
                        _mandaBookmark(parsedId, bookmarkAction);
                      });
                    },
                    icon: const Icon(
                      Icons.star,
                      size: 30,
                    ),
                    color: bookmark ? Colors.yellow : Colors.grey,
                    iconSize: 35,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (goalImage.isEmpty) ...[
                Image.asset('assets/img/if_no_img.png'),
              ] else ...[
                AspectRatio(
                  aspectRatio: 1 / 1, // 1:1 비율 유지
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(goalImage.length, (index) {
                      return Image.asset(
                        goalImage[index].image,
                        fit: BoxFit.cover,
                      );
                    }),
                  ),
                ),
              ],

              const SizedBox(
                height: 20,
              ),
               Text(
                description,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text('할 일 달성 통계',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff313131),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.circle_outlined,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            Text(
                              ' = $o개',
                              style: const TextStyle(
                                  color: Colors.yellow, fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.change_history_outlined,
                              color: Color(0xff888888),
                              size: 20,
                            ),
                            Text(
                              ' = $v개',
                              style: const TextStyle(
                                  color: Color(0xff888888), fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.clear_outlined,
                              color: Color(0xff626161),
                              size: 23,
                            ),
                            Text(
                              ' = $x개',
                              style: const TextStyle(
                                  color: Color(0xff626161), fontSize: 18),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  CustomPaint(
                    size: Size(
                        MediaQuery.of(context).size.width / 5,
                        MediaQuery.of(context).size.width /
                            5), // CustomPaint의 크기
                    painter: PieChart(
                      yellowPercentage: 60,
                      grayPercentage: 30,
                      blackPercentage: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30), // 아이콘과 다른 콘텐츠 사이의 간격 조정
              Center(
                  child: Column(
                children: [
                  const Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '전체 도미노',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            color: Colors.yellow),
                        width: 18, // 원하는 너비 설정
                        height: 45, // 원하는 높이 설정
                      ),
                      const Text(
                        '   x 75',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset('assets/img/domino_calculate.png'),
                ],
              )),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GoalImage {
  final String image; // 이미지 경로
  final String name; // 이미지 이름 (필요시 추가)

  GoalImage({required this.image, required this.name});
}


