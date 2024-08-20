import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:domino/screens/MG/profile_img_samplegallery.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _nicknamecontroller = TextEditingController();
  final _explaincontroller = TextEditingController();
  XFile? _pickedFile;

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
          title: const Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Text(
                "프로필 편집하기",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff262626),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _showBottomSheet();
                    },
                    child: _pickedFile != null
                        ? Image.file(
                            File(_pickedFile!.path),
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: imageSize,
                            height: imageSize,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/img/profile_smp4.png'),
                                    fit: BoxFit.cover)),
                          ),
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
                decoration: InputDecoration(
                  labelText: 'ex) 일탈을 원하는 마이크',
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
                      Navigator.pop(context);
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
                  //_getSampleImage();ProfileSampleGallery
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
    } else {
      if (kDebugMode) {
        print('카메라 사진 선택 안 함');
      }
    }
  }

  Future<void> _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('갤러리 사진 선택 안 함');
      }
    }
  }

  Future<void> _getSampleImage() async {
    // 기본 이미지 선택 로직 구현
    if (kDebugMode) {
      print('기본 이미지 선택');
    }
  }
}
