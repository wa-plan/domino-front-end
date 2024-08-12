/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:domino/screens/MG/mygoal_main.dart';
import 'package:domino/widgets/profile_img_samplegallery.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
}

class ProfileEdit extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 4;   

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        title: Text("프로필 편집하기"),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
          ),
        backgroundColor: Colors.black,
        elevation: 0,
        ),
        body: Padding(
          children:[
            title: const Text('사진으로 자신을 표현해봐요')
          ]
            style: TextStyle(
            color: Colors.black,
          ),
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: _imageSize,
                minWidth: _imageSize,
              ),
              child: GestureDetector(
                onTap: () {
                  _showBottomSheet();
                },
                child: Padding(
                  child: Icon(
                    Icons.account_circle,
                    size: imageSize,
                  ),
                ),
              ),
              backgroundColor: const Color(0xff262626),
            ),
          ],
          children:[
          title: const Text('닉네임을 만들어봐요')
          child: Padding(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'ex) 일탈을 원하는 마이크'
          )
        ),
        backgroundColor: const Color(0xff262626),
      ),
          ]
          children:[
          title: const Text('당신은 어떤 사람인가요?')
          child: Padding(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'ex) 세상이 궁금한 소심하고 당당한 마이크'
          )
        ),
        backgroundColor: const Color(0xff262626),
      ),
          ]
    );
  }

  _showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 80,
            ),
            Card(
              child: Text('어디서 사진을 가져올까요?')
              
            ),
            ElevatedButton(
              onPressed: () {
              getCameraImage(ImageSource.camera); //getImage 함수를 호출해서 카메라 호출
              },
              child: const Text('카메라로 찍기'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
              getPhotoLibraryImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
               },
              child: Text("갤러리"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
              getSampleImage(widgets/profile_img_samplegallery.dart); //getImage 함수를 호출해서 기본 이미지 9종 가져오기
               },
              child: const Text('기본 이미지'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
          ],
        );
      },
    );
  }
}

_getCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
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

  _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = _pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('선택 안 함');
      }
    }
  } 

  _getSampleImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: widgets/profile_img_samplegallery.dart);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = _pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('선택 안 함');
      }
    }
  } 
  }
*/