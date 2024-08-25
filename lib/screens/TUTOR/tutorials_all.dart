import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Tutorials extends StatefulWidget {
  const Tutorials({super.key});

  @override
  State<Tutorials> createState() => _TutorialsState();
}

class _TutorialsState extends State<Tutorials> {
  final List<String> _list = [
    'assets/img/tutor/tutor_1.png',
    'assets/img/tutor/tutor_2.png',
    'assets/img/tutor/tutor_3.png',
    'assets/img/tutor/tutor_4.png',
    'assets/img/tutor/tutor_5.png',
    'assets/img/tutor/tutor_6.png',
    'assets/img/tutor/tutor_7.png',
  ]; //이미지 리스트
  final CarouselController _controller = CarouselController();
  //CarouselController();
  int currentIndex = 0; //인덱스

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          //carouselController: _controller,
          options: CarouselOptions(
            height: double.infinity, // 최대 크기로 지정
            enableInfiniteScroll: false,
            viewportFraction: 0.8, // 이미지 100% 비율로 보여줌
            onPageChanged: ((index, reason) {
              // 페이지 슬라이드 시 index 변경
              setState(() {
                currentIndex = index;
              });
            }),
          ),
          items: _list.map((String item) {
            return Image.asset(item, fit: BoxFit.contain); // 이미지를 화면에 맞게 조절
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _list.asMap().entries.map((entry) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  // indicator에서 터치한 페이지로 이동
                  _controller.animateToPage(entry.key);
                },
                // indicator에 표시될 위젯
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 45.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 133, 133, 133)
                          .withOpacity(currentIndex == entry.key
                              ? 0.9
                              : 0.4)), // 현재 index 표시
                ),
              ),
            );
          }).toList(),
        ),
        Positioned(
            bottom: 80.0,
            left: 0,
            right: 0,
            child: Center(
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("시작하기",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black,
                        )))))
      ],
    );
  }
}

class CarouselController {}

extension on CarouselController {
  void animateToPage(int key) {}
}
