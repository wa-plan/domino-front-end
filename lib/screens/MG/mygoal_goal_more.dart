import 'package:flutter/material.dart';
import 'package:flutter/mygoal_main.dart';
//import 'package:domino/mg_api_function.dart';


//프로필 사진 팝업
class MyApp extends StatelessWidget {
  const MyApp({super.key});

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('This is a typical dialog.'),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: const Text('Show Dialog'),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog.fullscreen(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('어디서 사진을 가져올까요?'),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.push(/* 카메라 불러오기*/);
                    },
                    child: const Text('카메라로 찍기'),
                    onPressed: () {
                      getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
                    },
                    },
                    child: const Text('내 갤러리'),
                    onPressed: () {
                      Navigator.push(/* 기본 이미지 팝업 */);
                    },
                    child: const Text('기본 이미지'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('닫기'),
                  ),
                ],
              ),
            ),
          ),
          child: const Text('Show Fullscreen Dialog'),
        ),
      ],
    );
  }
}
