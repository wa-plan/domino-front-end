//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:domino/screens/MG/profile_img_samplegallery.dart';
import 'package:domino/apis/services/mg_services.dart';

class ProfileEdit extends StatefulWidget {
  final String? selectedImage;
  const ProfileEdit({super.key, this.selectedImage});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController _nicknamecontroller = TextEditingController();
  final TextEditingController _explaincontroller = TextEditingController();
  XFile? _pickedFile;
  final String _selectedProfileImage =
      'assets/img/profile_smp4.png'; // 기본 이미지 경로
  String? nickname;
  String? description;

  @override
  void initState() {
    super.initState();
    userInfo();
  }

  void _editProfile(String nickname, String profile, String description) async {
    print('프로필 수정 요청 시작');
    print('닉네임: $nickname, 프로필 경로: $profile, 설명: $description');
    final success = await EditProfileService.editProfile(
      nickname: nickname,
      profile: profile,
      description: description,
    );

    if (success) {
      Navigator.pop(context, true); // 성공적으로 프로필을 수정한 후, true를 반환
    }
  }

  void userInfo() async {
    final data = await UserInfoService.userInfo();
    if (data.isNotEmpty) {
      setState(() {
        nickname = data['nickname'];
        description = data['description'];
        _nicknamecontroller.text = nickname ?? '';
        _explaincontroller.text = description ?? '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('사용자 정보가 조회되었습니다.')),
      );
    }
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: Colors.white,
          ),
          title: const Text(
            "프로필 편집하기",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0xff262626),
        ),
        backgroundColor: const Color(0xff262626),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '사진으로 자신을 표현해봐요',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showBottomSheet();
                  },
                  child: CircleAvatar(
                    radius: imageSize / 2,
                    backgroundImage: _pickedFile != null
                        ? FileImage(File(_pickedFile!.path))
                        : (widget.selectedImage != null
                                ? FileImage(File(widget.selectedImage!))
                                : AssetImage(_selectedProfileImage))
                            as ImageProvider,
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '닉네임을 만들어봐요',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nicknamecontroller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'ex) 일탈을 원하는 마이크',
                  //labelStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '당신은 어떤 사람인가요?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _explaincontroller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'ex) 세상이 궁금한 소심하고 당당한 마이크',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // 완료 버튼 기능 구현

                      if (_pickedFile != null) {
                        // 파일이 선택되었을 때만 프로필 수정 요청
                        _editProfile(
                          _nicknamecontroller.text,
                          _pickedFile!.path, // 여기서 null 확인이 이미 되었으므로 ! 사용
                          _explaincontroller.text,
                        );
                      } else {
                        // 파일이 선택되지 않은 경우 기본 이미지로 처리하거나 오류 메시지 처리
                        _editProfile(
                          _nicknamecontroller.text,
                          _selectedProfileImage, // 기본 이미지 경로 사용
                          _explaincontroller.text,
                        );
                      }
                      //Navigator.pop(context);

                      //Navigator.push(
                      //  context,
                      //  MaterialPageRoute(
                      //    builder: (context) => const MyGoal(),
                      //  ),
                      //);
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

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '어디서 사진을 가져올까요?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _getCameraImage();
                  Navigator.pop(context);
                },
                child: const Text('카메라로 찍기'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _getPhotoLibraryImage();
                  Navigator.pop(context);
                },
                child: const Text('갤러리에서 선택하기'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileSampleGallery(),
                    ),
                  );
                },
                child: const Text('기본 이미지 선택'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  Future<void> _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }
}
