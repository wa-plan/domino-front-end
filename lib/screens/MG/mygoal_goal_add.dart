import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:domino/apis/services/mg_services.dart';
import 'package:domino/screens/TD/td_main.dart';
import 'package:image_picker/image_picker.dart' as image_picker;

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
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 0.0),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            '목표 세우기',
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
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
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
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    //hintText: '목표를 입력하세요',
                    border: OutlineInputBorder(),
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
                          if (_isChecked) {
                            selectedDate =
                                DateTime.now(); //목표 날짜 확실하지 않은 경우, 오늘 날짜로 설정
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
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: '내용을 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

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
