import 'package:domino/apis/services/mg_services.dart';
import 'package:domino/screens/MG/mygoal_goal_detail.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/MG/mygoal_profile_edit.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/screens/MG/mygoal_goal_add.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // 추가

class MyGoal extends StatefulWidget {
  const MyGoal({super.key});

  @override
  State<MyGoal> createState() => _MyGoalState();
}

class _MyGoalState extends State<MyGoal> {
  final String message = "실패하는 것이 두려운 게 아니라\n노력하지 않는 것이 두렵다.";
  String nickname = '당신은 어떤 사람인가요?';
  String description = '프로필 편집을 통해 \n자신을 표현해주세요.';
  List<Map<String, String>> mandalarts = [];
  List<int> ddayList = [];

  late PageController _pageController; // PageController 추가
  int successNum = 0; // 추가: 성공한 목표 수
  int inProgressNum = 0; // 추가: 진행 중인 목표 수
  int failedNum = 0; // 추가: 실패한 목표 수
  int dday = 0; // 추가: D-day
  String ddayString = '0';

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

  void userMandaInfo(context, int mandalartId, int pageIndex) async {
    final data = await UserMandaInfoService.userMandaInfo(context,
        mandalartId: mandalartId);
    if (data != null) {
      setState(() {
        if (pageIndex < ddayList.length) {
          // 페이지 인덱스 범위 체크
          ddayList[pageIndex] = data['dday'] ?? 0; // dday를 페이지 인덱스에 맞게 저장
        }
        successNum = data['statusNum']['successNum'] ?? 0;
        inProgressNum = data['statusNum']['inProgressNum'] ?? 0;
        failedNum = data['statusNum']['failed'] ?? 0;
        dday = data['dday'] ?? 0;
        ddayString = dday.toString();
        print('ddayString: $ddayString');
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

  Widget _buildGoalCard(Map<String, String> mandalart, int mandalartId) {
    final String name = mandalart['name'] ?? 'Goal';
    final String id = mandalart['id'] ?? '';
    //final int dday = ddayList[mandalartId];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyGoalDetail(id: id)),
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
                    const Icon(Icons.star, color: Colors.yellow),
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
                      dday.toString(),
                      style: const TextStyle(
                        color: Color(0xff5C5C5C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        Text(
                          '나의 도미노',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '80개',
                          style: TextStyle(
                            color: Color(0xffFCFF62),
                            fontWeight: FontWeight.w700,
                          ),
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
                    height: 170,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: mandalarts.length,
                      itemBuilder: (context, index) {
                        final mandalart = mandalarts[index];
                        return _buildGoalCard(mandalart, index);
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
              Image.asset('assets/img/completed_goals.png'),
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
              Image.asset('assets/img/failed_goals.png'),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xff262626),
    );
  }
}
