import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:domino/apis/services/mg_services.dart';
import 'package:domino/screens/TD/td_main.dart';
import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:domino/styles.dart';

class MyGoalAdd extends StatefulWidget {
  const MyGoalAdd({super.key});

  @override
  State<MyGoalAdd> createState() => _MyGoalAddState();
}

class _MyGoalAddState extends State<MyGoalAdd> {
  bool _isChecked = false;
  XFile? _pickedFile;
  Color? _selectedColor;
  DateTime selectedDate = DateTime.now();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<image_picker.XFile?> selectedImages = [];
  final List<String> _combinedImages = [];

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

// 서버에 보낼 데이터들을 출력
    print('Name: $name');
    print('Description: $description');
    print('Color: $color');
    print('Date: $date');
    print('Picture Paths: $picturePaths');

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
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: const Color(0xffD4D4D4),
                  iconSize: 17,
                  
                ),
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
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('* 어떤 목표인가요?',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16)),
                    const SizedBox(height: 13),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: '예시 : 환상적인 세계여행',
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 128, 128, 128),
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: const BorderSide(
                                    color: Color(0xffBFBFBF), width: 0.5)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3),
                                borderSide: const BorderSide(
                                    color: Color(0xffBFBFBF), width: 0.5)),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '* 언제까지 목표를 이루고 싶나요?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Transform.scale(
                      alignment: Alignment.center,
                      scale: 0.9,
                      child: DatePicker(
                        initialDay: selectedDate,
                        onDateChanged: (newDate) {
                          setState(() {
                            selectedDate = newDate;
                          });
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: backgroundColor,
                          activeColor: mainRed,
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value!;
                              if (_isChecked) {
                                selectedDate = DateTime
                                    .now(); //목표 날짜 확실하지 않은 경우, 오늘 날짜로 설정
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
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '목표에 대해서 더 알고 싶어요.',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 13),
                    SizedBox(
                      height: 80,
                      child: TextFormField(
                        maxLines: 5,
                        controller: _descriptionController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText:
                              '예시 : 유럽, 아프리카, 아시아 등 전세계 구석구석을 배낭 하나로 여행하기!',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 128, 128, 128),
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: const BorderSide(
                                  color: Color(0xffBFBFBF), width: 0.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: const BorderSide(
                                  color: Color(0xffBFBFBF), width: 0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 목표 사진 선택
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('목표를 보여주는 사진이 있나요?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),),
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
                                      backgroundColor: Color.fromARGB(255, 79, 79, 79),
                                      child: Icon(Icons.add_a_photo,
                                          color: Color.fromARGB(255, 173, 173, 173)),
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
              ),
              /*GestureDetector(
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
                ),*/
              const SizedBox(height: 20),

              // 목표 색상 선택
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '* 목표를 색깔로 표현해주세요.',
                      style:TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 13,
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
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff131313),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // 완료 버튼 기능 구현

                      if (_nameController.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('목표를 입력해 주세요.')),
                        );
                      } else if (_selectedColor == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('색상을 선택해 주세요.')),
                        );
                      } else {
                        _addGoal();
                        Navigator.pop(context);
                      }

/*if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      DateTime? pickedDate =
                          context.read<DateProvider>().pickedDate;

                      if (pickedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('날짜를 선택해 주세요.')),
                        );
                      } else {
                        context
                            .read<DateListProvider>()
                            .setInterval(switchValue, pickedDate);
                        List<DateTime> dateList =
                            context.read<DateListProvider>().dateList;
                        repeatInfo =
                            context.read<DateListProvider>().repeatInfo();
                        print('repeatInfo=$repeatInfo');
                        addDomino(widget.thirdGoalId, dominoController.text,
                            dateList, repeatInfo);
                      }
                    }*/

                      //_addGoal();
                      //Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff131313),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    child: const Text(
                      '완료',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
