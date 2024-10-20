import 'package:domino/apis/services/mg_services.dart';
import 'package:domino/screens/MG/mygoal_goal_detail.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/MG/mygoal_profile_edit.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/screens/MG/mygoal_goal_add.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyGoal extends StatefulWidget {
  const MyGoal({super.key});

  @override
  State<MyGoal> createState() => _MyGoalState();
}

class _MyGoalState extends State<MyGoal> {
  final String message = "실패하는 것이 두려운 게 아니라\n노력하지 않는 것이 두렵다.";
  String nickname = '당신은 어떤 사람인가요?';
  String description = '프로필 편집을 통해 \n자신을 표현해주세요.';

  String status = '';
  late PageController _pageController; // PageController 추가
  int successNum = 0; // 추가: 성공한 목표 수
  int inProgressNum = 0; // 추가: 진행 중인 목표 수
  int failed = 0; // 추가: 실패한 목표 수
  int dday = 0; // 추가: D-day
  String ddayString = '0';
  List<String> failedNamesList = [];
  List<String> inProgressNamesList = [];
  List<String> successNamesList = [];
  List<String> photoList = [];
  String mandaDescription = '';
  bool bookmark = false;
  int parsedId = 0;

  List<Map<String, String>> mandalarts = [];
  List<int> ddayList = [];
  List<String> mandaDescriptionList = [];
  List<int> failedList = [];
  List<int> inProgressNumList = [];
  List<int> successNumList = [];

  void userInfo() async {
    final data = await UserInfoService.userInfo();
    if (data.isNotEmpty) {
      setState(() {
        nickname = data['nickname'] ?? '당신은 어떤 사람인가요?';
        description = data['description'] ?? '프로필 편집을 통해 \n자신을 표현해주세요.';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사용자 정보가 조회되었습니다.')),
      );
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사용자 정보가 조회되었습니다.')),
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
        if (status == "FAIL") {
          failedNamesList.add(name); // "FAIL" 상태의 name을 추가
        } else if (status == "IN_PROGRESS") {
          inProgressNamesList.add(name); // "IN_PROGRESS" 상태의 name을 추가
        } else if (status == "SUCCESS") {
          successNamesList.add(name); // "SUCCESS" 상태의 name을 추가
        }
        if (data['photolist'] is List) {
          photoList = List<String>.from(data['photolist']); // List<String>으로 변환
        } else {
          photoList = []; // 빈 리스트로 초기화
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('만다라트 조회에 실패했습니다.')),
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
      int successNum) {
    final String name = mandalart['name'] ?? 'Goal';
    final String id = mandalart['id'] ?? '';
    int parsedId = int.parse(id);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyGoalDetail(
                    id: id,
                    name: name,
                    dday: dday,
                    status: status,
                    photoList: photoList,
                    mandaDescription: mandaDescription,
                    failedNum: failed,
                    inProgressNum: inProgressNum,
                    successNum: successNum,
                  )),
        );
        //final int parsedId = int.tryParse(id) ?? 0; // 문자열을 정수로 변환, 실패 시 0으로 설정
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //const Icon(Icons.star, color: Colors.yellow),
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
                        //size: 30,
                      ),
                      color: bookmark ? Colors.yellow : Colors.grey,
                      iconSize: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
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
                //const SizedBox(height: 10),
                if (photoList.isEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 53, 53, 53),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    width: 250,
                    height: 80,
                    child: const Center(
                      child: Text(
                        '이미지를 추가해 주세요',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: 250, // 컨테이너의 너비를 지정
                    height: 80, // 컨테이너의 높이를 지정
                    child: CarouselSlider.builder(
                      itemCount: photoList.length,
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(photoList[index]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 80, // 슬라이더의 높이
                        autoPlay: true, // 자동 재생
                        viewportFraction: 0.9, // 뷰포트 비율
                        enlargeCenterPage: true, // 중심 페이지 확대
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
                    const SizedBox(width: 15),
                    Image.asset('assets/img/MG_domino.png'),
                  ],
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffFCFF62),
                borderRadius: BorderRadius.circular(3.0),
              ),
              width: 15,
              height: 170,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 4;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(
            '나의 목표',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xff262626),
      ),
      bottomNavigationBar: const NavBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35.0, 20, 35.0, 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xff5C5C5C), width: 1),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage('assets/img/profile_smp4.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nickname,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileEdit()),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    color: const Color(0xff5C5C5C),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(color: Color(0xff5C5C5C), thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '쓰러트릴 목표',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: inProgressNamesList.length,
                      itemBuilder: (context, index) {
                        final mandalart = mandalarts[index];
                        final dday = ddayList[index];
                        final failed = failedList[index];
                        final inProgressNum = inProgressNumList[index];
                        final successNum = successNumList[index];
                        final mandaDescription = mandaDescriptionList[index];
                        return _buildGoalCard(
                            mandalart,
                            index,
                            dday,
                            mandaDescription,
                            failed,
                            inProgressNum,
                            successNum);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: mandalarts.length, // 총 페이지 수
                    effect: const ColorTransitionEffect(
                      // 스타일 설정
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      activeDotColor: Color(0xffFF6767),
                      dotColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                '오늘의 응원',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: const Color(0xff5C5C5C), width: 1),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '쓰러트린 목표',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              if (successNamesList.isEmpty)
                Image.asset('assets/img/completed_goals.png')
              else
                Container(
                  decoration: const BoxDecoration(color: Colors.yellow),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.04,
                  child: const Text('쓰러트린 목표'),
                ),
              const SizedBox(height: 30),
              Text(
                '쓰러트리지 못한 목표',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              if (failedNamesList.isEmpty)
                Image.asset('assets/img/failed_goals.png')
              else
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.04,
                  child: const Text('쓰러트리지 못한 목표'),
                ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xff262626),
    );
  }
}
