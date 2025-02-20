import 'dart:io';

import 'package:domino/screens/MG/mygoal_profile_edit.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';

class ProfileSampleGallery extends StatefulWidget {
  final String selectedImage;
  final String profileImage;
  const ProfileSampleGallery(
      {super.key, required this.selectedImage, required this.profileImage});

  @override
  ProfileSampleGalleryState createState() => ProfileSampleGalleryState();
}

class ProfileSampleGalleryState extends State<ProfileSampleGallery> {
  final List<String> _imageUrls = [
    'assets/img/profile_smp1.png',
    'assets/img/profile_smp2.png',
    'assets/img/profile_smp3.png',
    'assets/img/profile_smp4.png',
    'assets/img/profile_smp5.png',
    'assets/img/profile_smp6.png',
    'assets/img/profile_smp7.png',
    'assets/img/profile_smp8.png',
    'assets/img/profile_smp9.png',
  ];

  String defaultImage = 'assets/img/profile_smp4.png'; // 기본 이미지 경로

  late String _selectedImage;
  late String _profileImage;
  ImageProvider getImageProvider(
      String? selectedImage, String? profileImage, String defaultImage) {
    // 1️⃣ 우선순위에 따라 사용할 이미지 선택
    String? imageToShow = selectedImage?.isNotEmpty == true
        ? selectedImage
        : (profileImage?.isNotEmpty == true ? profileImage : defaultImage);

    // 2️⃣ 기본 이미지 처리
    if (imageToShow == null || imageToShow.isEmpty) {
      return AssetImage(defaultImage); // 기본 이미지
    }

    // 3️⃣ 이미지 타입에 따라 적절한 Provider 반환
    if (imageToShow.startsWith('http')) {
      return NetworkImage(imageToShow);
    } else if (imageToShow.startsWith('file://')) {
      // 로컬 파일은 FileImage로 변환
      return FileImage(File(imageToShow.replaceFirst('file://', '')));
    } else {
      // Asset 이미지 사용 (경로 확인 필요)
      return AssetImage(imageToShow);
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.selectedImage;

    _profileImage = widget.profileImage;
    print("selectedImage: $_selectedImage");
    print("profileImage: ${widget.profileImage}");
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 3.5;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
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
                '프로필 이미지',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: fullPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(5),
                width: imageSize / 1.2, // CircleAvatar의 전체 크기
                height: imageSize / 1.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        const Color.fromARGB(255, 147, 147, 147), // 원하는 테두리 색
                    width: 0.5, // 테두리 두께
                  ),
                ),
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: getImageProvider(
                          _selectedImage, _profileImage, defaultImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff2A2A2A),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '도민호씨 갤러리',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.3,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 20.0,
                              crossAxisSpacing: 20.0,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            itemCount: _imageUrls.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedImage = _imageUrls[index];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _imageUrls[index].isNotEmpty
                                          ? AssetImage(_imageUrls[index])
                                              as ImageProvider
                                          : AssetImage(defaultImage),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(Colors.black, Colors.white, '완료', () {
                  print('갤러리선택이미지=$_selectedImage');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileEdit(
                          selectedImage: _selectedImage,
                          profileImage:
                              _selectedImage.isEmpty ? widget.profileImage : "",
                          cameraImage: ""),
                    ),
                  );
                }).button()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
