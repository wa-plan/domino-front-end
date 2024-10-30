import 'package:domino/screens/MG/mygoal_main.dart';
import 'package:domino/screens/MG/piechart.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data'; // Uint8List 사용을 위한 라이브러리 임포트
import 'package:domino/screens/MG/mygoal_goal_edit.dart';
import 'package:domino/apis/services/mg_services.dart';
import 'package:domino/widgets/popup.dart';

class MyGoalDetail extends StatefulWidget {
  final String id;
  final String name;
  final int dday;
  final String mandaDescription;
  final String status;
  final List<String> photoList;
  final int failedNum;
  final int inProgressNum;
  final int successNum;

  const MyGoalDetail(
      {super.key,
      required this.id,
      required this.name,
      required this.dday,
      required this.status,
      required this.photoList,
      required this.mandaDescription,
      required this.failedNum,
      required this.inProgressNum,
      required this.successNum});

  @override
  MyGoalDetailState createState() => MyGoalDetailState();
}

class MyGoalDetailState extends State<MyGoalDetail> {
  final _status = ['달성 실패', '진행 중', '달성 완료'];
  String? _selectedStatus;
  // 선택된 파일 리스트를 관리할 변수 추가
  List<Uint8List> selectedFiles = [];
  bool bookmark = false;
  String o = '0';
  String v = '0';
  String x = '0';
  String name = '';
  int dday = 0;
  int parsedId = 0;
  bool hasNoImages = false;
  Color color = const Color(0xffFCFF62);
  String mandaDescription = '';
  String status = '';
  int successNum = 0;
  int failedNum = 0;
  int inProgressNum = 0;
  List<String> goalImage = [];
  List<String> photoList = [];
  //double rate = 0.0;
  int total = 0;
  int successRate = 0;
  int inProgressRate = 0;
  int failedRate = 0;

  //List<String> goalImage = photoList.map((photo) => 'assets/img/$photo').toList();

  /*List<String> goalImage = [
    'assets/img/completed_goals.png',
    'assets/img/completed_goals.png',
    'assets/img/completed_goals.png'
    //'assets/img/profile_smp1.png',
    //'assets/img/profile_smp2.png',
    // 추가 이미지...
  ];*/

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
    _selectedStatus = _status[1];

    name = widget.name;
    dday = widget.dday;
    status = widget.status;
    photoList = widget.photoList;
    mandaDescription = widget.mandaDescription;
    failedNum = widget.failedNum;
    inProgressNum = widget.inProgressNum;
    successNum = widget.successNum;
    total = successNum + inProgressNum + failedNum;

    successRate = total == 0 ? 0 : (successNum / total * 100).toInt();
    inProgressRate = total == 0 ? 0 : (inProgressNum / total * 100).toInt();
    failedRate = 100 - successRate - inProgressRate;

    goalImage = photoList.map((photo) => 'assets/img/$photo').toList();
    print('goalImage=$goalImage');
    //failedRate = total == 0 ? 0 : (failedNum / total * 100).toInt();

    /*if (successRate == 0 && inProgressRate == 0 && failedRate == 0) {
      successRate = 1; // 기본값으로 1% 설정
      inProgressRate = 0; // 기본값으로 1% 설정
      failedRate = 0; // 기본값으로 1% 설정
    }*/
  }

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MygoalEdit(
                          dday: dday,
                          name: name,
                          description: mandaDescription,
                          color: color,
                          goalImage: goalImage)));
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
                    dday < 0 ? 'D+${dday * -1}' : 'D-$dday',
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
                              if (_selectedStatus == '달성 완료') {
                                PopupDialog.show(
                                  context,
                                  '대박! 이 목표 정말 \n달성 완료한거야?',
                                  true, // cancel
                                  false, // delete
                                  false, // signout
                                  true, //success
                                  onCancel: () {
                                    // 취소 버튼을 눌렀을 때 실행할 코드
                                    Navigator.of(context).pop();
                                  },

                                  onDelete: () {
                                    // 삭제 버튼을 눌렀을 때 실행할 코드
                                  },
                                  onSignOut: () {
                                    // 탈퇴 버튼을 눌렀을 때 실행할 코드
                                  },
                                  onSuccess: () {
                                    _mandaProgress(
                                        int.parse(widget.id), "SUCCESS");
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MyGoal(),
                                      ),
                                    );
                                  },
                                );
                              }
                              if (_selectedStatus == '달성 실패') {
                                PopupDialog.show(
                                  context,
                                  '아쉬워! 이 목표는 \n달성 실패인거야?',
                                  true, // cancel
                                  false, // delete
                                  false, // signout
                                  true, //success
                                  onCancel: () {
                                    // 취소 버튼을 눌렀을 때 실행할 코드
                                    Navigator.of(context).pop();
                                  },

                                  onDelete: () {
                                    // 삭제 버튼을 눌렀을 때 실행할 코드
                                  },
                                  onSignOut: () {
                                    // 탈퇴 버튼을 눌렀을 때 실행할 코드
                                  },
                                  onSuccess: () {
                                    _mandaProgress(
                                        int.parse(widget.id), "FAIL");
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MyGoal(),
                                      ),
                                    );
                                  },
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (goalImage.isEmpty) ...[
                Image.asset('assets/img/if_no_img.png'),
              ] else ...[
                SizedBox(
                  height: 140,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 이미지 개수에 맞춰 열 개수 조정
                      childAspectRatio: 1 / 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index < goalImage.length) {
                        return ClipRRect(
                          borderRadius:
                              BorderRadius.circular(15), // 둥근 네모 형태로 설정
                          child: Image.asset(
                            goalImage[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return Container(); // 빈 자리를 유지
                      }
                    },
                  ),
                ),
              ],

              const SizedBox(
                height: 20,
              ),
              Text(
                mandaDescription,
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
                height: 20,
              ),
              const Row(
                children: [
                  Text('나의 도미노',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    width: 80,
                  ),
                  Text('*동그라미로만 도미노를 만들 수 있어요.',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(
                height: 20,
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
                              ' = $successNum개',
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
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              ' = $inProgressNum개',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.clear_outlined,
                              color: Colors.white,
                              size: 23,
                            ),
                            Text(
                              ' = $failedNum개',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.grey,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/img/domino.png',
                            width: 50,
                          ),
                          Text(
                            ' x $successNum',
                            style: const TextStyle(
                                color: Colors.yellow, fontSize: 18),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 3, // 줄의 두께
                        height: 1, // 줄과 Row 사이의 간격 조절
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 60), // 아이콘과 다른 콘텐츠 사이의 간격 조정
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('할 일 달성 비율',
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomPaint(
                        size: Size(MediaQuery.of(context).size.width / 5,
                            MediaQuery.of(context).size.width / 5),
                        painter: PieChart(
                            successPercentage: successRate, // int로 변환
                            inProgressPercentage: inProgressRate, // int로 변환
                            failPercentage: failedRate),
                      ),
                      Column(
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
                                ' = $successRate%',
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
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                ' = $inProgressRate%',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
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
                                ' = ${failedRate == 100 ? 0 : failedRate}%',
                                style: const TextStyle(
                                    color: Color(0xff626161), fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  )
                  /*const Icon(
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
                  Text(
                    '   x ${successNum + inProgressNum * 1 / 2}',
                    style: const TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              //Image.asset('assets/img/domino_calculate.png'),*/
                ],
              ),
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
