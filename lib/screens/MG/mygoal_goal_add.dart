import 'package:domino/screens/MG/mygoal_main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:domino/apis/services/mg_services.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:domino/styles.dart';
import 'package:table_calendar/table_calendar.dart';

class MyGoalAdd extends StatefulWidget {
  const MyGoalAdd({super.key});

  @override
  State<MyGoalAdd> createState() => _MyGoalAddState();
}

class _MyGoalAddState extends State<MyGoalAdd> {
  bool _isChecked = false;
  XFile? _pickedFile;
  Color? _selectedColor;
  DateTime? selectedDate;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<image_picker.XFile?> selectedImages = [];
  final List<String> _combinedImages = [];
  String? uploadedImageResponse; // String? 타입으로 수정

  void _addGoal() async {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final color = _selectedColor.toString();
    final date = selectedDate;

    // 이미지 파일 경로 추출
    final picturePaths = [
      ...selectedImages.map((image) => image!.path),
      ..._combinedImages
    ];

    // 서버에 이미지 업로드
    uploadedImageResponse = (await AddProfileImage.addImage(image: picturePaths[0])) as String?; // 첫 번째 이미지 업로드
    if (uploadedImageResponse != null) {
      print('이미지 업로드 성공: $uploadedImageResponse');
    } else {
      print('이미지 업로드 실패');
    }

    // 서버에 보낼 데이터 출력
    print('Name: $name');
    print('Description: $description');
    print('Color: $color');
    print('Date: $date');
    print('Picture Paths: $picturePaths');

    final success = await AddGoalService.addGoal(
      name: name,
      description: description,
      color: color,
      date: date!,
      pictures: picturePaths,
    );

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyGoal(),
        ),
      );
    }
  }

  // 이미지 픽커로부터 이미지를 선택하는 메서드
  Future<void> _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
        _combinedImages.add(pickedFile.path);
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

  void _deleteImage(String imagePath) {
    setState(() {
      _combinedImages.remove(imagePath); // 이미지 리스트에서 제거
    });
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
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xffD4D4D4),
                  size: 17,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '목표 세우기',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: fullPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 목표 설명
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Question(number: '1', question: '어떤 목표인가요?'),
                      Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: const Color(0xff303030),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: const Color(0xff575757), width: 0.5), // 테두리 색상
                    ),
                    child: const Text(
                          '필수',
                          style:
                              TextStyle(color: Color(0xff979797), fontSize: 11),
                        )),
                  
                    ],
                  ),
                  const SizedBox(height: 13),
                  SizedBox(
                      height: 40,
                      child: CustomTextField('Ex. 환상적인 세계여행', _nameController,
                              (value) {
                        return null;
                      }, false, 1)
                          .textField()),
                ],
              ),

              const SizedBox(height: 40),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Question(number: '2', question: '언제까지 목표를 이루고 싶나요?'),
                      Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: const Color(0xff303030),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: const Color(0xff575757), width: 0.5), // 테두리 색상
                    ),
                    child: const Text(
                          '필수',
                          style:
                              TextStyle(color: Color(0xff979797), fontSize: 11),
                        )),
                      
                    ],
                  ),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: 280,
                        height: 40,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: const Color.fromARGB(255, 147, 147, 147),
                                width: 0.5)),
                        child: Text(
                          selectedDate != null
                              ? DateFormat('yyyy년 MM월 dd일')
                                  .format(selectedDate!)
                              // 날짜만 포맷팅
                              : '달력을 열어 날짜를 선택해주세요.', // null인 경우 출력
                          style: TextStyle(
                            color: selectedDate != null
                                ? Colors.white // 날짜만 포맷팅
                                : const Color.fromARGB(255, 113, 113, 113),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Button(Colors.black, Colors.white, '달력', () {
                        _showCalendarPopup(context);
                      }).button(),
                    ],
                  ),
                  const SizedBox(height: 13),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        checkColor: backgroundColor,
                        activeColor: mainRed,
                        visualDensity: VisualDensity.compact,
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                            if (_isChecked) {
                              selectedDate =
                                  DateTime.now(); //목표 날짜 확실하지 않은 경우, 오늘 날짜로 설정
                            } else {
                              selectedDate = null;
                            }
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
                            '그럼 오늘부터 날짜를 세어나갈게요\n예시 : D + 1',
                            style: TextStyle(
                                color: mainRed,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Question(number: '3', question: '목표에 대해서 더 알려주세요.'),
                  const SizedBox(height: 13),
                  SizedBox(
                      height: 80,
                      child: CustomTextField(
                              'Ex. 유럽, 아프리카, 아시아 등 전세계 구석구석을 배낭 하나로 여행하기!',
                              _descriptionController, (value) {
                        return null;
                      }, false, 5)
                          .textField()),
                ],
              ),

              const SizedBox(height: 40),

              // 목표 사진 선택
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Question(number: '4', question: '목표를 보여주는 사진이 있나요?'),
                  const SizedBox(height: 13),
                  Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ..._combinedImages.map((imagePath) {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: File(imagePath)
                                                .existsSync()
                                            ? FileImage(File(
                                                imagePath)) // For new images
                                            : AssetImage(imagePath)
                                                as ImageProvider, // For existing images
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () => _deleteImage(
                                            imagePath), // 이미지 삭제 함수 호출
                                        child: const CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.black,
                                          child: Icon(Icons.close,
                                              size: 15, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              if (_combinedImages.length <
                                  3) // 이미지가 3개 미만일 때만 CircleAvatar 버튼 표시
                                GestureDetector(
                                  onTap: _getPhotoLibraryImage,
                                  child: const CircleAvatar(
                                    radius: 40,
                                    backgroundColor:
                                        Color.fromARGB(255, 79, 79, 79),
                                    child: Icon(Icons.add_a_photo,
                                        color:
                                            Color.fromARGB(255, 173, 173, 173)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // 목표 색상 선택
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Question(number: '5', question: '목표를 색깔로 표현해주세요.'),
                      Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: const Color(0xff303030),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: const Color(0xff575757), width: 0.5), // 테두리 색상
                    ),
                    child: const Text(
                          '필수',
                          style:
                              TextStyle(color: Color(0xff979797), fontSize: 11),
                        )),
                    ],
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ColorOption2(
                        colorCode: const Color(0xffFF7A7A),
                        isSelected: _selectedColor == const Color(0xffFF7A7A),
                        onTap: () => _onColorSelected(const Color(0xffFF7A7A)),
                      ),
                      ColorOption2(
                        colorCode: const Color(0xffFFB82D),
                        isSelected: _selectedColor == const Color(0xffFFB82D),
                        onTap: () => _onColorSelected(const Color(0xffFFB82D)),
                      ),
                      ColorOption2(
                        colorCode: const Color(0xffFCFF62),
                        isSelected: _selectedColor == const Color(0xffFCFF62),
                        onTap: () => _onColorSelected(const Color(0xffFCFF62)),
                      ),
                      ColorOption2(
                        colorCode: const Color(0xff72FF5B),
                        isSelected: _selectedColor == const Color(0xff72FF5B),
                        onTap: () => _onColorSelected(const Color(0xff72FF5B)),
                      ),
                      ColorOption2(
                        colorCode: const Color(0xff5DD8FF),
                        isSelected: _selectedColor == const Color(0xff5DD8FF),
                        onTap: () => _onColorSelected(const Color(0xff5DD8FF)),
                      ),
                      ColorOption2(
                        colorCode: const Color(0xffffffff),
                        isSelected: _selectedColor == const Color(0xffffffff),
                        onTap: () => _onColorSelected(const Color(0xffffffff)),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //취소버튼
                  Button(Colors.black, Colors.white, '취소',
                      () => Navigator.pop(context)).button(),

                  //완료버튼
                  Button(
                    Colors.black,
                    Colors.white,
                    '완료',
                    () {
                      print('selectedDate=$selectedDate');
                      print('_isChecked=$_isChecked');
                      if (_nameController.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('목표를 입력해 주세요.')),
                        );
                      } else if (!_isChecked && selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('목표 날짜를 선택해 주세요.')),
                        );
                      } else if (_selectedColor == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('색상을 선택해 주세요.')),
                        );
                      } else {
                        _addGoal();
                      }
                    },
                  ).button(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCalendarPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        DateTime focusedDay = DateTime.now();
        DateTime? tempSelectedDate;

        return AlertDialog(
          backgroundColor: const Color(0xff262626),
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 350,
                child: TableCalendar(
                  locale: 'ko_KR',
                  firstDay: DateTime(2024),
                  lastDay: DateTime(2050),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) =>
                      isSameDay(tempSelectedDate, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      tempSelectedDate = selectedDay; // 임시 선택 날짜 업데이트
                      focusedDay = focusedDay; // 포커스된 날짜 업데이트
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    selectedTextStyle: TextStyle(
                      color: backgroundColor, // 선택된 날짜의 텍스트 색상
                      fontWeight: FontWeight.w600, // 텍스트 굵기
                    ),
                    selectedDecoration: BoxDecoration(
                      color: mainRed, // 선택된 날짜의 배경색
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: backgroundColor, // 선택된 날짜의 텍스트 색상
                      fontWeight: FontWeight.w600, // 텍스트 굵기
                    ),
                    todayDecoration: BoxDecoration(
                      color: Color(0xFF5B5B5B), // 오늘 날짜의 배경색
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle:
                        TextStyle(color: Colors.grey), // 주말 텍스트 색상
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false, // 주/월 변경 버튼 숨기기
                    titleCentered: true, // 헤더의 날짜 중앙 정렬
                    leftChevronIcon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xffD4D4D4),
                      size: 17,
                    ),
                    rightChevronIcon: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xffD4D4D4),
                      size: 17,
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.grey),
                    weekendStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(Colors.black, Colors.white, '취소', () {
                  Navigator.pop(context); // 팝업 닫기
                }).button(),
                Button(
                  Colors.black,
                  Colors.white,
                  '완료',
                  () {
                    if (tempSelectedDate != null) {
                      setState(() {
                        selectedDate = tempSelectedDate; // 상위 상태에 선택된 날짜 저장
                      });
                      print(selectedDate);
                    }
                    Navigator.pop(context); // 팝업 닫기
                  },
                ).button(),
              ],
            )
          ],
        );
      },
    );
  }
}
