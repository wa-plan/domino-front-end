import 'dart:io';
import 'package:domino/screens/MG/mygoal_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:domino/provider/mg_provider.dart';

class MyGoalProgress extends StatelessWidget {
  const MyGoalProgress({Key? key}) : super(key: key);

class _GoalsProgressState extends State<GoalsProgressState> {
  final List<String> _list = [
    '/*api/*',
  ]; //이미지 리스트
  final CarouselController _controller = CarouselController();
  //CarouselController();
  int currentIndex = 0; //인덱스
}

  void _goal() async {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final color = '#${Colors.red.value.toRadixString(16).padLeft(8, '0')}';
    final date = selectedDate;

    // 이미지 파일 경로 추출
    final picturePaths = selectedImages.map((image) => image!.path).toList();

    final success = await AddGoalService.addGoal(
      name: name,
      description: description,
      color: color, // 색상 문자열로 전달
      date: date,
      pictures: picturePaths,
    );

  @override
  Widget build(BuildContext context) {
    return SizedBox (
      child: Text(
        '쓰러트릴 목표',
        style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.03,
              fontWeight: FontWeight.w600),
          ),
          icon: Align(
            alignment: Alignment.topRight,
            child: Icon(
            Icons.star,
            color: Colors.grey,
            size: MediaQuery.of(context).size.width * 0.03,
            ),
            ),
      return Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image:
                DecorationImage(
                    fit: BoxFit.cover,  //
                    image: FileImage(File(images[index]!.path   // image api
                    ),
                    ),
                ),
            ),
            ),
        ]
      )//Mygoal 사진
      child: Text(
        '나의 도미노',
        style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.03,
              fontWeight: FontWeight.w600),
          ),
          
          Positioned(
            top: 20.0,
            child: Container(
              width: 80.0,
              height: 80.0,
              color: middleColor,
            ),
          ),
          return Stack(
          alignment: Alignment.centerRight,
          children: [
          return Center(
          child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
          // Bottom block
          Container(
            width: 80.0,
            height: 100.0,
            color: bottomColor,
          // Middle block
          Positioned(
            top: 20.0,
            child: Container(
              width: 80.0,
              height: 80.0,
              color: middleColor,
            ),
          ),
          // Top block
          Positioned(
            top: 40.0,
            child: Container(
              width: 80.0,
              height: 60.0,
              color: topColor,
            ),
          ),
          // Button to change colors
          Positioned(
            bottom: 20.0,
                  bottomColor = () {};
                  middleColor = () {};
                  topColor = () {};
                );
                },
                ),
}
