import 'dart:io';
import 'package:dio/dio.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:domino/screens/MG/profile_img_samplegallery.dart';
import 'package:domino/apis/services/mg_services.dart';
import 'package:domino/screens/MG/mygoal_main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:domino/apis/services/image_services.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

class ProfileEdit extends StatefulWidget {
  final String selectedImage;
  final String profileImage;

  const ProfileEdit(
      {super.key, required this.selectedImage, required this.profileImage});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController _nicknamecontroller = TextEditingController();
  final TextEditingController _explaincontroller = TextEditingController();
  XFile? _cameraFile;
  String defaultImage = 'assets/img/profile_smp4.png'; // 기본 이미지 경로
  String? nickname;
  String? description;
  String? profile;
  final List<String> _imageFiles = [];
  String? _selectedImage;
  String? _pickedFile;

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

  Future<void> _uploadSelectedImage() async {
    try {
      if (widget.selectedImage != "") {
        print('업로드할 selectedImage: ${widget.selectedImage}');

        // selectedImage를 File로 변환 (Flutter의 asset 이미지는 직접 File로 변환 불가하므로, ByteData로 변환 후 처리)
        ByteData byteData = await rootBundle.load(widget.selectedImage);
        Uint8List imageBytes = byteData.buffer.asUint8List();

// Uint8List를 PlatformFile로 변환
        PlatformFile selectedFile = PlatformFile(
          name: 'profile_image.png', // 파일 이름 지정
          bytes: imageBytes, // 파일 데이터
          size: imageBytes.length, // 파일 크기
        );

        List<PlatformFile> fileList = [selectedFile];
        String uploadedUrl = await UploadFileService.uploadFiles(fileList);

        if (uploadedUrl.isNotEmpty) {
          print('업로드된 selectedImage URL: $uploadedUrl');
          setState(() {
            _imageFiles.clear();
            _imageFiles.add(uploadedUrl); // 업로드된 URL을 _imageFiles에 추가
          });
        } else {
          print('selectedImage 업로드 실패');
        }
      } else {
        print('selectedImage가 비어 있습니다.');
      }
    } catch (e) {
      print('selectedImage 업로드 오류: $e');
      Fluttertoast.showToast(
        msg: '이미지 업로드 오류: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<bool> _editProfile(
      String nickname, String profile, String description) async {
    try {
      final success = await EditProfileService.editProfile(
        nickname: nickname,
        profile: profile,
        description: description,
      );
      return success;
    } catch (e) {
      debugPrint('Error in _editProfile: $e');
      return false;
    }
  }

  void userInfo() async {
    final data = await UserInfoService.userInfo();
    if (data.isNotEmpty) {
      setState(() {
        nickname = data['nickname'];
        description = data['description'];
        //profile = data['profile'];
        profile = widget.profileImage;
        _nicknamecontroller.text = nickname ?? '';
        _explaincontroller.text = description ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userInfo();
    print('전달받은 이미지=${widget.selectedImage}');
  }

  @override
  void dispose() {
    _nicknamecontroller.dispose();
    _explaincontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 2;

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyGoal(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xffD4D4D4),
                    size: 17,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '프로필 편집',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            )),
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: fullPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet();
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: imageSize / 1.2, // CircleAvatar의 전체 크기
                              height: imageSize / 1.2,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 147, 147, 147), // 원하는 테두리 색
                                  width: 0.5, // 테두리 두께
                                ),
                              ),
                              child: CircleAvatar(
                                radius: imageSize / 2.4,
                                backgroundImage: profile != ""
                                    ? NetworkImage(
                                        profile!) // _imageFiles의 첫 번째 이미지 사용
                                    : (widget.selectedImage != ""
                                        ? AssetImage(widget.selectedImage)
                                            as ImageProvider // selectedImage 사용
                                        : AssetImage(
                                            defaultImage)), // defaultImage 사용
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            const Positioned(
                                right: 20,
                                top: 135,
                                child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: mainRed,
                                    child: Icon(Icons.edit,
                                        size: 20, color: backgroundColor))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Question(number: '1', question: '닉네임을 만들어봐요'),
                    const SizedBox(height: 10),
                    SizedBox(
                        height: 40,
                        child: CustomTextField('Ex. 꿈꾸는 마이클',
                                _nicknamecontroller, (value) => null, false, 1)
                            .textField()),
                    const SizedBox(height: 40),
                    const Question(number: '2', question: '당신은 어떤 사람인가요?'),
                    const SizedBox(height: 10),
                    SizedBox(
                        height: 80,
                        child: CustomTextField('Ex. 명랑하면서 도전적인 사람!',
                                _explaincontroller, (value) => null, false, 3)
                            .textField()),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    Colors.black,
                    Colors.white,
                    '취소',
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyGoal(),
                        ),
                      );
                    },
                  ).button(),
                  Button(Colors.black, Colors.white, '완료', () async {
                    await _uploadSelectedImage(); // 🔹 이미지 업로드 완료까지 대기
                    if (_imageFiles.isNotEmpty) {
                      // 🔹 업로드된 이미지가 존재하는지 확인
                      bool isEdited = await _editProfile(
                        _nicknamecontroller.text,
                        _imageFiles[0], // 🔹 업로드된 이미지 URL 사용
                        _explaincontroller.text,
                      );

                      if (isEdited) {
                        // 🔹 프로필 수정이 성공했을 경우만 이동
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyGoal()),
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: '프로필 수정에 실패했습니다.',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: '이미지 업로드에 실패했습니다.',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                  }).button()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: backgroundColor.withOpacity(0.95),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(6),
        ),
      ),
      builder: (context) {
        return FractionallySizedBox(
          widthFactor: 0.85, // 화면 너비의 3/4
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '어디서 사진을 가져올까요?',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.3,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    //_getCameraImage();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white.withOpacity(0.03),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_camera,
                          color: Color(0xffD4D4D4),
                          size: 17,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '카메라로 찍기',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    _imageFiles.clear();
                    _selectedImage = "";
                    _pickImages();
                    //_getPhotoLibraryImage();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white.withOpacity(0.03),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insert_photo,
                          color: Color(0xffD4D4D4),
                          size: 17,
                        ),
                        SizedBox(width: 10),
                        Text('앨범에서 고르기',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileSampleGallery(
                          selectedImage: widget.selectedImage,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white.withOpacity(0.03),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.grade,
                          color: Color(0xffD4D4D4),
                          size: 17,
                        ),
                        SizedBox(width: 10),
                        Text('도민호씨 갤러리',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /*Future<void> _getCameraImage() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 75,
      maxWidth: 75,
      imageQuality: 30,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }*/

  /*Future<void> _getPhotoLibraryImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 75,
      maxWidth: 75,
      imageQuality: 30,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }*/
}
