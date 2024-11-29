import 'dart:io';

import 'package:domino/apis/services/mg_services.dart';
import 'package:domino/apis/services/td_services.dart';
import 'package:domino/screens/MG/mygoal_goal_detail.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/MG/mygoal_profile_edit.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/screens/MG/mygoal_goal_add.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:domino/widgets/MG/cheering_message.dart';

class MyGoal extends StatefulWidget {
  const MyGoal({super.key});

  @override
  State<MyGoal> createState() => _MyGoalState();
}

class _MyGoalState extends State<MyGoal> {
  final String message = "";
  String nickname = '';
  String description = '';
  String selectedImage = "assets/img/profile_smp4.png";

  late PageController _pageController; // PageController 추가
  int successNum = 0;
  String mandaDescription = '';
  bool bookmark = false;
  List<Map<String, String>> failedIDs = [];
  List<Map<String, String>> inProgressIDs = [];
  List<Map<String, String>> successIDs = [];
  List<Map<String, String>> nameList = [];
  List<Map<String, String>> statusList = [];
  List<Map<String, String>> ddayList = [];
  List<Map<String, String>> colorList = [];
  List<Map<dynamic, dynamic>> successNums = [];
  Map<String, List<Map<String, String>>> photos = {};

  List<Map<String, String>> mandalarts = [];

  void userInfo() async {
    final data = await UserInfoService.userInfo();
    if (data.isNotEmpty) {
      setState(() {
        nickname = data['nickname'] ?? '당신은 어떤 사람인가요?';
        description = data['description'] ?? '프로필 편집을 통해 \n자신을 표현해주세요.';
      });
    }
  }

  Future<void> userMandaIdInfo() async {
    if (mandalarts.isNotEmpty) return;

    try {
      final data = await UserMandaIdService.userManda();

      if (data.isNotEmpty) {
        setState(() {
          mandalarts = data;
        });

        // 비동기 작업 병렬 처리
        final tasks = mandalarts.map((mandalart) async {
          final String mandalartId = mandalart['id'] ?? '0';
          await userMandaInfo(mandalartId);
          await mandaColor(mandalartId);
        });

        await Future.wait(tasks); // 모든 작업 완료를 기다림
        print('모든 mandalart 데이터가 성공적으로 로드되었습니다.');

        // id 값을 기준으로 오름차순 정렬
        failedIDs.sort((a, b) {
          return int.parse(a["id"]!).compareTo(int.parse(b["id"]!));
        });
        inProgressIDs.sort((a, b) {
          return int.parse(a["id"]!).compareTo(int.parse(b["id"]!));
        });
        successIDs.sort((a, b) {
          return int.parse(a["id"]!).compareTo(int.parse(b["id"]!));
        });

        //print('리스트 출력');
        //print('failedIDs=$failedIDs');
        //print('inProgressIDs=$inProgressIDs');
        //print('successIDs=$successIDs');
        //print('nameList=$nameList');
        //print('statusList=$statusList');
        //print('ddayList=$ddayList');
        //print('successNums=$successNums');
      }
    } catch (e) {
      // 에러 발생 시 처리
      print('userMandaIdInfo 에러 발생: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('데이터 로드 중 오류가 발생했습니다: $e')),
      );
    }
  }

  Future<void> userMandaInfo(String mandalartId) async {
    if (nameList.any((item) => item['mandalartId'] == mandalartId)) return;

    try {
      final data = await UserMandaInfoService.userMandaInfo(context,
          mandalartId: int.parse(mandalartId));

      if (data != null) {
        String id = mandalartId;
        String name = data['name'] ?? '';
        String status = data['status']?.toString() ?? '';
        List<dynamic> photoList = data['photoList'] ?? [];
        String dday = data['dday']?.toString() ?? '0';
        int successNum = data['statusNum']?['successNum'] ?? 0;

        setState(() {
          if (status == "FAIL") failedIDs.add({"id": id, "name": name});
          if (status == "IN_PROGRESS") {
            inProgressIDs.add({"id": id, "name": name});
          }
          if (status == "SUCCESS") successIDs.add({"id": id, "name": name});

          nameList.add({'mandalartId': id, 'name': name});
          statusList.add({'mandalartId': id, 'status': status});
          //photoList.add({'mandalartId': id, 'photos': photos});
          ddayList.add({'mandalartId': id, 'dday': dday});
          successNums.add({'mandalartId': id, 'successNum': successNum});

          // 사진 리스트를 photos에 저장
          if (photoList.isNotEmpty) {
            photos[id] = [];
            for (var photo in photoList) {
              photos[id]?.add({
                'path': photo['path'] ?? '',
                'id': photo['id'].toString(),
              });
            }
          }
        });
        //print('userMandaInfo 성공: $name ($id)');
      } else {
        //print('userMandaInfo 실패: 데이터 없음 ($mandalartId)');
      }
    } catch (e) {
      print('userMandaInfo 에러 발생: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('데이터 로드 실패: $e')),
      );
    }
  }

  Future<void> mandaColor(String mandalartId) async {
// 중복 방지
    if (colorList.any((item) => item['id'] == mandalartId)) return;

    try {
      // 서버에서 데이터 가져오기
      final data = await MandalartInfoService.mandalartInfo(
          mandalartId: int.parse(mandalartId));
      if (data != null) {
        // 반환된 데이터를 colorList에 추가
        setState(() {
          colorList.add({"id": mandalartId, "color": data["color"]});
        });
        print('colorList=$colorList');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('만다라트 조회에 실패했습니다.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    }
  }

  void _mandaBookmark(String mandalartId, String bookmark) async {
    final success = await MandaBookmarkService.MandaBookmark(
      id: int.parse(mandalartId),
      bookmark: bookmark,
    );
    if (success) {
      print('성공');
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    userInfo();
    userMandaIdInfo();
  }

  @override
  void dispose() {
    _pageController.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  Widget _buildGoalCard(String manddalartId, String name, String status,
      List<String> photoList, String dday, String color, int successNum) {
    final colorValue =
        int.parse(color.replaceAll('Color(', '').replaceAll(')', ''));

    int ddayParsed = int.parse(dday);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyGoalDetail(
                    id: manddalartId,
                    name: name,
                    status: status,
                    photoList: photoList,
                    dday: ddayParsed,
                    color: color,
                  )),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          bookmark = !bookmark;
                          String bookmarkAction =
                              bookmark ? "BOOKMARK" : "UNBOOKMARK";
                          _mandaBookmark('1', bookmarkAction);
                        });
                      },
                      icon: const Icon(
                        Icons.star,
                      ),
                      color: bookmark ? mainGold : const Color(0xff5C5C5C),
                      iconSize: 25,
                      padding: EdgeInsets.zero, // 아이콘 내부 여백 제거
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      ddayParsed < 0 ? 'D+${ddayParsed * -1}' : 'D-$ddayParsed',
                      style: const TextStyle(
                        color: Color(0xff5C5C5C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (photoList.isEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 53, 53, 53),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    width: 250,
                    height: 85,
                    child: const Center(
                      child: Text(
                        '이미지를 추가해 주세요',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: 250,
                    height: 80,
                    child: CarouselSlider.builder(
                      itemCount: photoList.length.clamp(1, 3), // 최대 3개로 제한
                      itemBuilder: (context, index, realIndex) {
                        final imagePath = photoList[index];
                        ImageProvider imageProvider;

                        // 로컬 파일 이미지 처리
                        if (imagePath.startsWith('/data/user/')) {
                          imageProvider = FileImage(File(imagePath));
                        } else {
                          // 기본 이미지 처리 (예: 유효하지 않은 경로)
                          imageProvider =
                              const AssetImage('assets/img/default_image.png');
                        }

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 80,
                        autoPlay: true,
                        viewportFraction: photoList.length == 1
                            ? 1.0
                            : 0.9, // 사진이 1개일 때는 뷰포트 전체 사용
                        enlargeCenterPage: true,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          '나의 도미노',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '$successNum개',
                          style: const TextStyle(
                              color: Color(0xffFCFF62),
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(width: 25),
                    if (colorValue == 4284340479)
                      Image.asset('assets/img/MG_blue.png')
                    else if (colorValue == 4294933114)
                      Image.asset('assets/img/MG_red.png')
                    else if (colorValue == 4285726555)
                      Image.asset('assets/img/MG_green.png')
                    else if (colorValue == 4294948909)
                      Image.asset('assets/img/MG_orange.png')
                    else if (colorValue == 4294967295 ||
                        colorValue == 4294770530)
                      Image.asset('assets/img/MG_white_yellow.png')
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            //첫번째 목표 색깔 연결하기(아래 컨테이너)
            Container(
              decoration: BoxDecoration(
                color: Color(colorValue),
                borderRadius: BorderRadius.circular(3.0),
              ),
              width: 15,
              height: 135,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Padding(
          padding: appBarPadding,
          child: Text(
            '나의 목표',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      bottomNavigationBar: const NavBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: fullPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xff5C5C5C), width: 0.7),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(selectedImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nickname,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(height: 7),
                      Text(
                        description,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileEdit(
                                  selectedImage: selectedImage,
                                )),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    color: const Color(0xff5C5C5C),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Color(0xff5C5C5C), thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MGSubTitle('쓰러뜨릴 목표').mgSubTitle(context),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyGoalAdd()),
                      );
                    },
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  SizedBox(
                    height: 220,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: inProgressIDs.length,
                      itemBuilder: (context, index) {
                        String mandalartId =
                            inProgressIDs[index]['id'] ?? ''; // id 값

                        String name =
                            inProgressIDs[index]['name'] ?? ''; // name 값

                        String status = statusList.firstWhere(
                              (element) =>
                                  element['mandalartId'] ==
                                  mandalartId, // mandalartId와 비교
                              orElse: () =>
                                  {'status': ''}, // 일치하는 항목이 없을 경우 빈 문자열 반환
                            )['status'] ??
                            '';

                        String dday = ddayList.firstWhere(
                              (element) =>
                                  element['mandalartId'] ==
                                  mandalartId, // mandalartId와 비교
                              orElse: () =>
                                  {'dday': ''}, // 일치하는 항목이 없을 경우 빈 문자열 반환
                            )['dday'] ??
                            '0';

                        String color = colorList.firstWhere(
                              (element) =>
                                  element['id'] ==
                                  mandalartId, // mandalartId와 비교
                              orElse: () =>
                                  {'color': ''}, // 일치하는 항목이 없을 경우 빈 문자열 반환
                            )['color'] ??
                            '';

                        int successNum = successNums.firstWhere(
                              (element) =>
                                  element['mandalartId'] ==
                                  mandalartId, // mandalartId와 비교
                              orElse: () =>
                                  {'successNum': 0}, // 일치하는 항목이 없을 경우 빈 문자열 반환
                            )['successNum'] ??
                            0;

                        List<String> photoList = (photos[mandalartId] ?? [])
                            .map<String>((photo) => photo['path'].toString())
                            .toList();

                        return _buildGoalCard(mandalartId, name, status,
                            photoList, dday, color, successNum);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: inProgressIDs.length,
                      effect: const ColorTransitionEffect(
                        dotHeight: 7.0,
                        dotWidth: 7.0,
                        activeDotColor: Color(0xffFF6767),
                        dotColor: Color.fromARGB(255, 169, 169, 169),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              MGSubTitle('이번주의 응원!!').mgSubTitle(context),
              const SizedBox(height: 15),
              const CheeringMessage(),
              const SizedBox(height: 40),
              MGSubTitle('쓰러뜨린 목표').mgSubTitle(context),
              const SizedBox(height: 15),
              if (successIDs.isEmpty)
                Image.asset('assets/img/completed_goals.png')
              else
                Column(
                  children: [
                    ...successIDs.map((item) {
                      String status = statusList.firstWhere(
                            (element) =>
                                element['mandalartId'] ==
                                item['id'], // mandalartId와 비교
                            orElse: () =>
                                {'status': ''}, // 일치하는 항목이 없을 경우 빈 문자열 반환
                          )['status'] ??
                          '';

                      String dday = ddayList.firstWhere(
                            (element) =>
                                element['mandalartId'] ==
                                item['id'], // mandalartId와 비교
                            orElse: () =>
                                {'dday': ''}, // 일치하는 항목이 없을 경우 빈 문자열 반환
                          )['dday'] ??
                          '0';

                      List<String> photoList = (photos[item['id']] ?? [])
                          .map<String>((photo) => photo['path'].toString())
                          .toList();

                      // id에 맞는 색상을 찾아서 적용
                      final color = colorList.firstWhere(
                          (element) => element['id'] == item['id'],
                          orElse: () => {
                                'color': 'Color(0xff000000)'
                              } // 색상이 없을 경우 기본값 (검정색)
                          )['color'];

                      // Color로 변환 (문자열에서 'Color('와 ')'를 제거하고 int로 변환한 뒤 Color 객체로 감싸기)
                      final colorValue = Color(int.parse(
                          color!.replaceAll('Color(', '').replaceAll(')', '')));

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyGoalDetail(
                                      id: item['id']!,
                                      name: item['name']!,
                                      status: status,
                                      photoList: photoList,
                                      dday: int.parse(dday),
                                      color: color,
                                    )),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(color: colorValue),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.08,
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Center(
                            child: Text(
                              item['name']!,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              const SizedBox(height: 40),
              MGSubTitle('쓰러뜨리지 못한 목표').mgSubTitle(context),
              const SizedBox(height: 15),
              if (failedIDs.isEmpty)
                Image.asset('assets/img/failed_goals.png')
              else
                Column(
                  children: [
                    ...failedIDs.map((item) {
                      String status = statusList.firstWhere(
                            (element) =>
                                element['mandalartId'] ==
                                item['id'], // mandalartId와 비교
                            orElse: () =>
                                {'status': ''}, // 일치하는 항목이 없을 경우 빈 문자열 반환
                          )['status'] ??
                          '';

                      String dday = ddayList.firstWhere(
                            (element) =>
                                element['mandalartId'] ==
                                item['id'], // mandalartId와 비교
                            orElse: () =>
                                {'dday': ''}, // 일치하는 항목이 없을 경우 빈 문자열 반환
                          )['dday'] ??
                          '0';

                      List<String> photoList = (photos[item['id']] ?? [])
                          .map<String>((photo) => photo['path'].toString())
                          .toList();
                      // id에 맞는 색상을 찾아서 적용
                      final color = colorList.firstWhere(
                          (element) => element['id'] == item['id'],
                          orElse: () => {
                                'color': 'Color(0xff000000)'
                              } // 색상이 없을 경우 기본값 (검정색)
                          )['color'];

                      // Color로 변환 (문자열에서 'Color('와 ')'를 제거하고 int로 변환한 뒤 Color 객체로 감싸기)
                      final colorValue = Color(int.parse(
                          color!.replaceAll('Color(', '').replaceAll(')', '')));

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyGoalDetail(
                                      id: item['id']!,
                                      name: item['name']!,
                                      status: status,
                                      photoList: photoList,
                                      dday: int.parse(dday),
                                      color: color,
                                      //successNum: int.parse(successNum)
                                    )),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 13),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 0),
                          decoration: BoxDecoration(
                            color: colorValue,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.09,
                          child: Center(
                            child: Text(
                              item['name']!,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 40),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
