import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class MygoalEdit extends StatefulWidget {
  final String name;
  final int dday;
  final String description;
  final Color color; // 색상 전달
  final List<String> goalImage;

  const MygoalEdit(
      {super.key,
      required this.name,
      required this.dday,
      required this.description,
      required this.color,
      required this.goalImage});

  @override
  State<MygoalEdit> createState() => _MygoalEditState();
}

class _MygoalEditState extends State<MygoalEdit> {
  bool _isChecked = false;
  XFile? _pickedFile;
  Color? _selectedColor;
  DateTime calculatedDate = DateTime.now();
  List<String> _combinedImages = []; // Combined list of existing and new images

  @override
  void initState() {
    super.initState();

    // Initialize combinedImages with existing images
    _combinedImages = List.from(widget.goalImage);

    // dday 계산
    calculatedDate = DateTime.now().add(Duration(days: widget.dday));

    // 전달받은 색상 설정
    _selectedColor = widget.color;
  }

  // 이미지 픽커로부터 이미지를 선택하는 메서드
  Future<void> _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
        // Add the new image to the combined list
        _combinedImages.add(pickedFile.path); // Save path of the new image
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
        ),
        title: Text('목표 편집하기', style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: const Color(0xff262626),
      ),
      backgroundColor: const Color(0xff262626),
      body: SingleChildScrollView(
        child: Padding(
          padding: fullPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 목표 설명
              Text('어떤 목표인가요?', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 14),
              TextFormField(
                decoration: InputDecoration(
                  hintText: widget.name,
                ),
              ),
              const SizedBox(height: 40),

              Text('언제까지 목표를 이루고 싶나요?',
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 14),
              DatePicker(
                initialDay: calculatedDate,
                onDateChanged: (newDate) {
                  setState(() {
                    calculatedDate = newDate;
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
                          color: mainGold,
                          fontSize: 10,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: '목표에 대해서 더 알고 싶어요. ',
                        style: Theme.of(context).textTheme.titleSmall),
                    const TextSpan(
                      text: '(선택)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                decoration: InputDecoration(
                  hintText: widget.description,
                ),
              ),
              const SizedBox(height: 40),

              // 목표 사진 선택
              Text('목표를 보여주는 사진이 있나요?',
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 20),
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
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: File(imagePath)
                                            .existsSync()
                                        ? FileImage(
                                            File(imagePath)) // For new images
                                        : AssetImage(imagePath)
                                            as ImageProvider, // For existing images
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () =>
                                        _deleteImage(imagePath), // 이미지 삭제 함수 호출
                                    child: const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.black54,
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
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[300],
                                child: const Icon(Icons.add_a_photo,
                                    color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // 목표 색상 선택
              Text('목표를 색깔로 표현해주세요.',
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColorOption(
                    colorCode: const Color(0xffFF7A7A),
                    isSelected: _selectedColor == const Color(0xffFF7A7A) ||
                        widget.color == '0xffFF7A7A',
                    onTap: () => _onColorSelected(const Color(0xffFF7A7A)),
                  ),
                  ColorOption(
                    colorCode: const Color(0xffFFB82D),
                    isSelected: _selectedColor == const Color(0xffFFB82D) ||
                        widget.color == '0xffFFB82D',
                    onTap: () => _onColorSelected(const Color(0xffFFB82D)),
                  ),
                  ColorOption(
                    colorCode: const Color(0xffFCFF62),
                    isSelected: _selectedColor == const Color(0xffFCFF62) ||
                        widget.color == '0xffFCFF62',
                    onTap: () => _onColorSelected(const Color(0xffFCFF62)),
                  ),
                  ColorOption(
                    colorCode: const Color(0xff72FF5B),
                    isSelected: _selectedColor == const Color(0xff72FF5B) ||
                        widget.color == '0xff72FF5B',
                    onTap: () => _onColorSelected(const Color(0xff72FF5B)),
                  ),
                  ColorOption(
                    colorCode: const Color(0xff5B8DFF),
                    isSelected: _selectedColor == const Color(0xff5B8DFF) ||
                        widget.color == '0xff5B8DFF',
                    onTap: () => _onColorSelected(const Color(0xff5B8DFF)),
                  ),
                  ColorOption(
                    colorCode: const Color(0xffD09CFF),
                    isSelected: _selectedColor == const Color(0xffD09CFF) ||
                        widget.color == '0xffD09CFF',
                    onTap: () => _onColorSelected(const Color(0xffD09CFF)),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
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
    return GestureDetector(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDay,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          onDateChanged(pickedDate);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('yyyy-MM-dd').format(initialDay),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const Icon(Icons.calendar_today, color: Colors.white),
        ],
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
      child: CircleAvatar(
        radius: 24,
        backgroundColor: colorCode,
        child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}
