import 'package:domino/apis/services/mg_services.dart';
import 'package:domino/screens/MG/mygoal_main.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:domino/widgets/popup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:domino/apis/services/image_services.dart';

class MygoalEdit extends StatefulWidget {
  final String name;
  final int dday;
  final String description;
  final String color; // 색상 전달
  final List<String> goalImage;
  final String id;

  const MygoalEdit(
      {super.key,
      required this.id,
      required this.name,
      required this.dday,
      required this.description,
      required this.color,
      required this.goalImage});

  @override
  State<MygoalEdit> createState() => _MygoalEditState();
}

class _MygoalEditState extends State<MygoalEdit> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _descriptcontroller = TextEditingController();
  bool _isChecked = false;
  XFile? _pickedFile;
  late String _selectedColor;
  DateTime calculatedDate = DateTime.now();
  //List<String> _combinedImages = []; // Combined list of existing and new images
  final List<String> _imageFiles = [];

  @override
  void initState() {
    super.initState();

    // dday 계산
    calculatedDate = DateTime.now().add(Duration(days: widget.dday));

    // 전달받은 색상 설정
    _selectedColor = widget.color.toLowerCase();

    // 🔹 초깃값 설정
    _namecontroller.text = widget.name; // widget.name을 초깃값으로 설정
    _descriptcontroller.text = widget.description; // 목표 설명 초기값 설정

    print(widget.goalImage);
  }

  Future<void> _pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
        withData: kIsWeb, // 웹에서는 true, 모바일에서는 false
      );

      if (result != null) {
        // 파일 업로드 서비스 호출
        String uploadedUrl = await UploadFileService.uploadFiles(result.files);

        if (uploadedUrl.isNotEmpty) {
          print('업로드된 파일 URL: $uploadedUrl');
          setState(() {
            _imageFiles.add(uploadedUrl); // URL을 _imageFiles에 추가
          });
          print('_imageFiles=$_imageFiles');
        } else {
          print('파일 업로드 실패');
        }
      }
    } catch (e) {
      print('이미지 선택 오류: $e');
      Fluttertoast.showToast(
        msg: '오류 발생: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  /// 이미지 삭제 함수
  void _deleteImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  Future<bool> _editName(String name, int mandalartId) async {
    try {
      final success = await EditGoalNameService.editGoalName(
        name: name,
        mandalartId: mandalartId,
      );
      return success;
    } catch (e) {
      debugPrint('Error in _editName: $e');
      return false; // Return false if there's an error
    }
  }

  Future<bool> _editDate(String newDate, int mandalartId) async {
    try {
      final success = await EditGoalDateService.editGoalDate(
        newDate: newDate,
        mandalartId: mandalartId,
      );
      return success;
    } catch (e) {
      debugPrint('Error in _editDate: $e');
      return false; // Return false if there's an error
    }
  }

  Future<bool> _editDescript(String description, int mandalartId) async {
    try {
      final success = await EditGoalDescriptionService.editGoalDescription(
        description: description,
        mandalartId: mandalartId,
      );
      return success;
    } catch (e) {
      debugPrint('Error in _editDescription: $e');
      return false; // Return false if there's an error
    }
  }

  Future<bool> _editColor(String color, int mandalartId) async {
    try {
      final success = await EditGoalColorService.editGoalColor(
        color: color,
        mandalartId: mandalartId,
      );
      return success;
    } catch (e) {
      debugPrint('Error in _editColor: $e');
      return false; // Return false if there's an error
    }
  }

  // 날짜 형식을 변환하는 메서드
  String convertDateTimeDisplay(String date, String text) {
    final DateFormat displayFormatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormatter.parse(date);
    return serverFormatter.format(displayDate);
  }

  void _onColorSelected(String color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _descriptcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
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
                  '목표 편집',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          backgroundColor: backgroundColor),
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
                    const Text(
                      '* 어떤 목표인가요?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 13),
                    TextFormField(
                      controller: _namecontroller,
                      style: const TextStyle(
                        color: Colors.white, // 🔹 텍스트 색상을 흰색으로 설정
                        fontSize: 14, // 🔹 원하는 폰트 크기 (선택 사항)
                        fontWeight: FontWeight.w400, // 🔹 원하는 폰트 굵기 (선택 사항)
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
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
                    const SizedBox(height: 10),
                    Transform.scale(
                      alignment: Alignment.center,
                      scale: 0.9,
                      child: DatePicker(
                        initialDay: calculatedDate,
                        onDateChanged: (newDate) {
                          setState(() {
                            calculatedDate = newDate;
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
                      '목표에 대해서 더 알고 싶어요. ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 13),
                    SizedBox(
                      height: 80,
                      child: TextFormField(
                        controller: _descriptcontroller,
                        maxLines: 5,
                        style: const TextStyle(
                          color: Colors.white, // 🔹 텍스트 색상을 흰색으로 설정
                          fontSize: 14, // 🔹 원하는 폰트 크기 (선택 사항)
                          fontWeight: FontWeight.w400, // 🔹 원하는 폰트 굵기 (선택 사항)
                        ),
                        decoration: InputDecoration(
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
                    const Text(
                      '목표를 보여주는 사진이 있나요?',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // 🔹 기존 이미지 + 추가된 이미지 리스트 합쳐서 최대 3개까지만 표시
                                ...[...widget.goalImage, ..._imageFiles]
                                    .take(3)
                                    .toList()
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int index = entry.key;
                                  var imageData = entry.value;

                                  return Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(
                                              imageData), // 🔹 이미지 적용
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: GestureDetector(
                                          onTap: () => _deleteImage(
                                              index), // 🔹 삭제 기능 추가
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

                                // 🔹 최대 3개 미만일 때만 이미지 추가 버튼 표시
                                if ([...widget.goalImage, ..._imageFiles]
                                        .length <
                                    3)
                                  GestureDetector(
                                    onTap: _pickImages, // 🔹 이미지 선택 함수 호출
                                    child: const CircleAvatar(
                                      radius: 40,
                                      backgroundColor:
                                          Color.fromARGB(255, 79, 79, 79),
                                      child: Icon(Icons.add_a_photo,
                                          color: Color.fromARGB(
                                              255, 173, 173, 173)),
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
                      '목표를 색깔로 표현해주세요.',
                      style: TextStyle(
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
                          isSelected:
                              _selectedColor.toLowerCase() == '0xffff7a7a',
                          onTap: () => _onColorSelected('0xffff7a7a'),
                        ),
                        ColorOption(
                          colorCode: const Color(0xffFFB82D),
                          isSelected:
                              _selectedColor.toLowerCase() == '0xffb82d',
                          onTap: () => _onColorSelected('0xffb82d'),
                        ),
                        ColorOption(
                          colorCode: const Color(0xffFCFF62),
                          isSelected:
                              _selectedColor.toLowerCase() == '0xfffcff62',
                          onTap: () => _onColorSelected('0xfffcff62'),
                        ),
                        ColorOption(
                          colorCode: const Color(0xff72FF5B),
                          isSelected:
                              _selectedColor.toLowerCase() == '0xff72ff5b',
                          onTap: () => _onColorSelected('0xff72ff5b'),
                        ),
                        ColorOption(
                          colorCode: const Color(0xff5B8DFF),
                          isSelected:
                              _selectedColor.toLowerCase() == '0xff5b8dff',
                          onTap: () => _onColorSelected('0xff5b8dff'),
                        ),
                        ColorOption(
                          colorCode: const Color(0xffD09CFF),
                          isSelected:
                              _selectedColor.toLowerCase() == '0xffd09cff',
                          onTap: () => _onColorSelected('0xffd09cff'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
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
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print('calculatedDate=$calculatedDate');
                      PopupDialog.show(
                        context,
                        '이건 아니야.. \n정말 떠날거야...?',
                        true, // cancel
                        true, // delete
                        false, //signout
                        false, // success
                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                        onDelete: () async {
                          bool isDeleted =
                              await DeleteFirstGoalService.deleteFirstGoal(
                            context,
                            int.parse(widget.id),
                          );
                          if (isDeleted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyGoal(),
                              ),
                            );
                          }
                        },
                        onSignOut: () {},
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    child: const Text(
                      '삭제',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      // 모든 API 호출이 성공했는지 확인할 변수
                      bool isSuccess = true;

                      // 🔹 목표 이름 수정
                      bool nameSuccess = await _editName(
                          _namecontroller.text, int.parse(widget.id));
                      if (!nameSuccess) {
                        isSuccess = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('목표 이름 저장에 실패했습니다.')),
                        );
                      }

                      // 🔹 목표 설명 수정
                      bool descriptSuccess = await _editDescript(
                          _descriptcontroller.text, int.parse(widget.id));
                      if (!descriptSuccess) {
                        isSuccess = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('목표 설명 저장에 실패했습니다.')),
                        );
                      }

                      // 🔹 날짜 변환 후 목표 날짜 수정
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(calculatedDate);
                      bool dateSuccess =
                          await _editDate(formattedDate, int.parse(widget.id));
                      if (!dateSuccess) {
                        isSuccess = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('목표 날짜 저장에 실패했습니다.')),
                        );
                      }

                      // 🔹 목표 색상 수정
                      bool colorSuccess = await _editColor(
                          _selectedColor, int.parse(widget.id));
                      if (!colorSuccess) {
                        isSuccess = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('목표 색상 저장에 실패했습니다.')),
                        );
                      }

                      // 🔹 모든 API 호출이 성공했을 경우만 화면 닫기
                      if (isSuccess) {
                        Navigator.pop(context);
                      }
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
                        fontWeight: FontWeight.w500,
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
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: colorCode,
          borderRadius: BorderRadius.circular(6),
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.black, size: 24)
            : null,
      ),
    );
  }
}
