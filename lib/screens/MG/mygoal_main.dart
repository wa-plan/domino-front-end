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

  String status = '';
  late PageController _pageController; // PageController 추가
  int successNum = 0; // 추가: 성공한 목표 수
  int inProgressNum = 0; // 추가: 진행 중인 목표 수
  int failed = 0; // 추가: 실패한 목표 수
  int dday = 0; // 추가: D-day
  String ddayString = '0';
  List<Map<String, String>> failedIDList = [];
  List<Map<String, String>> inProgressIDList = [];
  List<Map<String, String>> successIDList = [];
  List<Map<String, dynamic>> photoList = [];
  String mandaDescription = '';
  bool bookmark = false;
  int parsedId = 0;

  List<Map<String, String>> mandalarts = [];
  List<int> ddayList = [];
  List<String> mandaDescriptionList = [];
  List<int> failedList = [];
  List<int> inProgressNumList = [];
  List<int> successNumList = [];

  List<Map<String, String>> colorList = [];

  void userInfo() async {
    final data = await UserInfoService.userInfo();
    if (data.isNotEmpty) {
      setState(() {
        nickname = data['nickname'] ?? '당신은 어떤 사람인가요?';
        description = data['description'] ?? '프로필 편집을 통해 \n자신을 표현해주세요.';
      });
      /*ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사용자 정보가 조회되었습니다.')),
      );*/
    }
  }

  void userMandaIdInfo() async {
    final data = await UserMandaIdService.userManda();

    if (data.isNotEmpty) {
      setState(() {
        mandalarts = data;
        ddayList = List.filled(mandalarts.length, 0); // dday 리스트 초기화
        failedList = List.filled(mandalarts.length, 0);
        inProgressNumList = List.filled(mandalarts.length, 0);
        successNumList = List.filled(mandalarts.length, 0);
        mandaDescriptionList = List.filled(mandalarts.length, '');
      });

      // mandalarts가 로드된 후에 userMandaInfo 호출
      for (int i = 0; i < mandalarts.length; i++) {
        final int mandalartId = int.tryParse(mandalarts[i]['id'] ?? '0') ?? 0;
        userMandaInfo(context, mandalartId, i);
      }

      // mandalarts가 로드된 후에 mandalartInfo 호출
      for (var mandalart in mandalarts) {
        final String mandalartId = mandalart["id"]!;
        mandalartInfo(mandalartId); // id값 전달
      }
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

  void userMandaInfo(context, int mandalartId, int pageIndex) async {
    final data = await UserMandaInfoService.userMandaInfo(context,
        mandalartId: mandalartId);
    if (data != null) {
      setState(() {
        if (pageIndex < ddayList.length) {
          // 페이지 인덱스 범위 체크
          ddayList[pageIndex] = data['dday'] ?? 0; // dday를 페이지 인덱스에 맞게 저장
          failedList[pageIndex] = data['statusNum']['failed'] ?? 0;
          inProgressNumList[pageIndex] =
              data['statusNum']['inProgressNum'] ?? 0;
          successNumList[pageIndex] = data['statusNum']['successNum'] ?? 0;
          mandaDescriptionList[pageIndex] = data['description'];
          status = data['status'];
        }

        String name = data['name']; // name을 가져오기
        int id = data['id'];

        if (status == "FAIL") {
          failedIDList
              .add({"id": id.toString(), "name": name}); // "FAIL" 상태의 name을 추가
        } else if (status == "IN_PROGRESS") {
          inProgressIDList.add({
            "id": id.toString(),
            "name": name
          }); // "IN_PROGRESS" 상태의 name을 추가
        } else if (status == "SUCCESS") {
          successIDList.add({"id": id.toString(), "name": name});
        }
        if (data['photoList'] is List) {
          photoList = List<Map<String, dynamic>>.from(data['photoList']);
        } else {
          photoList = [];
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('만다라트 조회에 실패했습니다.')),
      );
    }
  }

  void notInProgressInfo(context, int mandalartId) async {
    final data = await UserMandaInfoService.userMandaInfo(context,
        mandalartId: mandalartId);
    if (data != null) {
      setState(() {
        // 페이지 인덱스 범위 체크
        int plusId = data['id'];
        String plusName = data['name'];
        int plusDday = data['dday'];
        String plusStatus = data['status'];
        List<Map<String, dynamic>> plusPhotoList;
        String plusMandaDescription = data['description'];
        int plusFailedNum = data['statusNum']['failed'];
        int plusInProgressNum = data['statusNum']['inProgressNum'];
        int plusSuccessNum = data['statusNum']['successNum'];

        if (data['photoList'] is List) {
          plusPhotoList = List<Map<String, dynamic>>.from(data['photoList']);
        } else {
          plusPhotoList = [];
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyGoalDetail(
              id: plusId.toString(),
              name: plusName,
              dday: plusDday,
              status: plusStatus,
              photoList: plusPhotoList
                  .map((photo) => photo['path'] as String)
                  .toList(),
              mandaDescription: plusMandaDescription,
              failedNum: plusFailedNum,
              inProgressNum: plusInProgressNum,
              successNum: plusSuccessNum,
            ),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('만다라트 조회에 실패했습니다.')),
      );
    }
  }

  void mandalartInfo(String mandalartId) async {
    try {
      // 서버에서 데이터 가져오기
      int id = int.parse(mandalartId);
      final data = await MandalartInfoService.mandalartInfo(mandalartId: id);
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

  Widget _buildGoalCard(
      Map<String, String> mandalart,
      int mandalartId,
      int dday,
      String mandaDescription,
      int failed,
      int inProgressNum,
      int successNum,
      String color) {
    final String name = mandalart['name'] ?? 'Goal';
    final String id = mandalart['id'] ?? '';
    int parsedId = int.parse(id);
    final colorValue =
        int.parse(color.replaceAll('Color(', '').replaceAll(')', ''));

    return GestureDetector(
      onTap: () {
        print('failedIDList=$failedIDList');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyGoalDetail(
                    id: id,
                    name: name,
                    dday: dday,
                    status: status,
                    photoList: photoList
                        .map((photo) => photo['path'] as String)
                        .toList(),
                    mandaDescription: mandaDescription,
                    failedNum: failed,
                    inProgressNum: inProgressNum,
                    successNum: successNum,
                  )),
        );
        //final int parsedId = int.tryParse(id) ?? 0; // 문자열을 정수로 변환, 실패 시 0으로 설정
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
                          _mandaBookmark(parsedId, bookmarkAction);
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
                      dday < 0 ? 'D+${dday * -1}' : 'D-$dday',
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
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(photoList[index]['path']),
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
                          '${successNumList[mandalartId]}개',
                          style: const TextStyle(
                              color: Color(0xffFCFF62),
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(width: 25),
                    Image.asset('assets/img/MG_domino.png'),
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
              height: 150,
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
                      itemCount: inProgressIDList.length,
                      itemBuilder: (context, index) {
                        final mandalart = inProgressIDList[index];
                        final dday = ddayList[index];
                        final failed = failedList[index];
                        final inProgressNum = inProgressNumList[index];
                        final successNum = successNumList[index];
                        final mandaDescription = mandaDescriptionList[index];
                        final color = colorList[index]["color"];
                        return _buildGoalCard(
                            mandalart,
                            index,
                            dday,
                            mandaDescription,
                            failed,
                            inProgressNum,
                            successNum,
                            color!);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: inProgressIDList.length,
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
              if (successIDList.isEmpty)
                Image.asset('assets/img/completed_goals.png')
              else
                Column(
                  children: [
                    ...successIDList.map((item) {
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
                          notInProgressInfo(context, int.parse(item['id']!));
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
              if (failedIDList.isEmpty)
                Image.asset('assets/img/failed_goals.png')
              else
                Column(
                  children: [
                    ...failedIDList.map((item) {
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
                          print('colorValue=$colorValue');
                          notInProgressInfo(context, int.parse(item['id']!));
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
