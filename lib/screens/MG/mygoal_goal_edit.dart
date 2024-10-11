import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class MygoalEdit extends StatefulWidget {
  final String name;
  final String dday;

  const MygoalEdit({
    super.key,
    required this.name,
    required this.dday
    });

  @override
  State<MygoalEdit> createState() => _MygoalEditState();
}

class _MygoalEditState extends State<MygoalEdit> {
  bool _isChecked = false;
  XFile? _pickedFile;
  Color? _selectedColor;
  DateTime selectedDate = DateTime.now();
  

  // 이미지 픽커로부터 이미지를 선택하는 메서드
  Future<void> _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('선택 안 함');
      }
    }
  }

  // 날짜 형식을 변환하는 메서드
  String convertDateTimeDisplay(String date, String text) {
    final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormatter.parse(date);
    return serverFormatter.format(displayDate);
  }

  void _onColorSelected(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 0.0),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: Colors.white,
          ),
          title: Text(
            '목표 편집하기',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: const Color(0xff262626),
        ),
        backgroundColor: const Color(0xff262626),
        body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 40.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 목표 설명
              const Text(
                '어떤 목표인가요?',
                style: TextStyle(
                  
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 20),
               TextFormField(
                decoration: InputDecoration(
                  hintText: widget.name,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                '언제까지 목표를 이루고 싶나요?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                ),
              ),
              DatePicker(
                initialDay: selectedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "확실하지 않아요",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '이 경우에는 오늘부터 날짜를 세어나갈게요\n예시) D + 1',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '목표에 대해서 더 알고 싶어요. ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                      ),
                    ),
                    TextSpan(
                      text: '(선택)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  hintText: '내용을 입력하세요',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // 목표 사진 선택
              const Text(
                '목표를 보여주는 사진이 있나요?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _getPhotoLibraryImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _pickedFile != null
                      ? FileImage(File(_pickedFile!.path))
                      : null,
                  child: _pickedFile == null
                      ? const Icon(Icons.add_a_photo, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 20),

              // 목표 색상 선택
              const Text(
                '목표를 색깔로 표현해주세요.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColorOption(
                    colorCode: const Color(0xffFF7A7A),
                    isSelected: _selectedColor == const Color(0xffFF7A7A),
                    onTap: () => _onColorSelected(const Color(0xffFF7A7A)),
                  ),
                  ColorOption(
                    colorCode: const Color(0xffFFB82D),
                    isSelected: _selectedColor == const Color(0xffFFB82D),
                    onTap: () => _onColorSelected(const Color(0xffFFB82D)),
                  ),
                  ColorOption(
                    colorCode: const Color(0xffFCFF62),
                    isSelected: _selectedColor == const Color(0xffFCFF62),
                    onTap: () => _onColorSelected(const Color(0xffFCFF62)),
                  ),
                  ColorOption(
                    colorCode: const Color(0xff72FF5B),
                    isSelected: _selectedColor == const Color(0xff72FF5B),
                    onTap: () => _onColorSelected(const Color(0xff72FF5B)),
                  ),
                  ColorOption(
                    colorCode: const Color(0xff5DD8FF),
                    isSelected: _selectedColor == const Color(0xff5DD8FF),
                    onTap: () => _onColorSelected(const Color(0xff5DD8FF)),
                  ),
                  ColorOption(
                    colorCode: const Color(0xffffffff),
                    isSelected: _selectedColor == const Color(0xffffffff),
                    onTap: () => _onColorSelected(const Color(0xffffffff)),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff131313),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: const Text(
                    '취소',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ), //취소 버튼
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6767),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: const Text(
                    '삭제',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff131313),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: const Text(
                    '저장',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ],
          ),
        ),),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final Color colorCode;
  final bool isSelected;
  final VoidCallback onTap;

  const ColorOption({
    super.key,
    required this.colorCode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorCode,
          borderRadius: BorderRadius.circular(6),
        ),
        child: isSelected
            ? const Icon(
                Icons.check,
                color: Colors.black,
                size: 24,
              )
            : null,
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
