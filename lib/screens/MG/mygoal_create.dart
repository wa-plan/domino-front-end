import 'dart:io';
import 'package:domino/screens/TD/td_main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:domino/apis/services/mg_services.dart';

class MygoalCreate extends StatefulWidget {
  const MygoalCreate({super.key});

  @override
  State<MygoalCreate> createState() => _MyGoalCreateState();
}

class _MyGoalCreateState extends State<MygoalCreate> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<image_picker.XFile?> selectedImages = [];

  void _goalCreate() async {
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

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TdMain(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff262626),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff262626),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(
            '목표 세우기',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 38.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '어떤 목표인가요?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.1),
            ),
            const SizedBox(height: 14.0),
            SizedBox(
              height: 35,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Color(0xff5C5C5C),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              '언제까지 목표를 이루고 싶나요?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.1),
            ),
            const SizedBox(height: 14.0),
            DatePicker(
              initialDay: selectedDate,
              onDateChanged: (newDate) {
                setState(() {
                  selectedDate = newDate;
                });
              },
            ),
            const SizedBox(height: 20.0),
            const Text(
              '목표에 대해서 더 알려주세요.',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.1),
            ),
            const SizedBox(height: 14.0),
            SizedBox(
              height: 100,
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Color(0xff5C5C5C),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              '목표를 보여주는 사진이 있나요?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.1),
            ),
            const SizedBox(height: 14.0),
            CustomImagePicker(
              onImagesSelected: (images) {
                setState(() {
                  selectedImages = images;
                });
              },
            ),
            ElevatedButton(
              onPressed: _goalCreate,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffBDBDBD),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child: const Text(
                '목표 추가', // 버튼 텍스트 수정
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  final DateTime initialDay;
  final ValueChanged<DateTime> onDateChanged;

  const DatePicker({
    super.key,
    required this.initialDay,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${initialDay.year} . ${initialDay.month} . ${initialDay.day}',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () async {
            final DateTime? dateTime = await showDatePicker(
              context: context,
              initialDate: initialDay,
              firstDate: DateTime(2000),
              lastDate: DateTime(3000),
            );
            if (dateTime != null) {
              onDateChanged(dateTime);
            }
          },
        ),
      ],
    );
  }
}

class CustomImagePicker extends StatefulWidget {
  final ValueChanged<List<image_picker.XFile?>> onImagesSelected;

  const CustomImagePicker({super.key, required this.onImagesSelected});

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  List<image_picker.XFile?> selectedImages = [];
  final picker = image_picker.ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.add),
          color: Colors.white,
          onPressed: () async {
            final List<image_picker.XFile?> images =
                await picker.pickMultiImage();
            if (images.isNotEmpty) {
              setState(() {
                selectedImages = images;
              });
              widget.onImagesSelected(selectedImages);
            }
          },
        ),
        if (selectedImages.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(
                      File(selectedImages[index]!.path),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
