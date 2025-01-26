import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart'; // kIsWeb을 사용하기 위한 import

class UploadFileService {
  // 반환 타입을 List<String>에서 String으로 수정
  static Future<String> uploadFiles(List<PlatformFile> files) async {
    String uploadedUrl = ''; // 업로드된 파일의 URL을 저장할 변수

    try {
      // SharedPreferences에서 토큰 가져오기
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');
      print('저장된 토큰: $token');

      if (token == null || token.isEmpty) {
        Fluttertoast.showToast(
          msg: '로그인 토큰이 없습니다. 다시 로그인해 주세요.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return ''; // 토큰이 없으면 빈 문자열 반환
      }

      var uri = Uri.parse("http://43.203.5.183:8080/s3/upload"); // 업로드할 서버 URL
      var request = http.MultipartRequest('POST', uri);

      // Authorization 헤더에 토큰 추가
      request.headers['Authorization'] = 'Bearer $token';

      // 파일 처리
      for (var file in files) {
        if (kIsWeb) {
          // 웹에서 처리
          var byteData = file.bytes!;
          var multipartFile = http.MultipartFile.fromBytes(
            'image',
            byteData,
            filename: file.name,
          );
          request.files.add(multipartFile);
        } else {
          // 모바일에서 처리
          var filePath = file.path!;
          var fileStream = File(filePath).openRead();
          var multipartFile = http.MultipartFile(
            'image',
            fileStream,
            await File(filePath).length(),
            filename: file.name,
          );
          request.files.add(multipartFile);
        }
      }

      // 요청 보내기
      var response = await request.send();

      // 서버 응답 상태 코드 출력
      print('서버 응답 상태 코드: ${response.statusCode}');

      // 서버 응답 본문 읽기
      var responseBody = await response.stream.bytesToString();
      print('서버 응답 본문: $responseBody');

      if (response.statusCode == 200) {
        // 서버 응답 본문은 URL이므로 해당 URL을 변수에 저장
        uploadedUrl = responseBody;
        print('업로드된 파일 URL: $uploadedUrl');
      } else {
        print('파일 업로드 실패: ${response.statusCode}');
        Fluttertoast.showToast(
          msg: '파일 업로드 실패: ${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return ''; // 업로드 실패 시 빈 문자열 반환
      }
    } catch (e) {
      print('파일 업로드 오류: $e');
      Fluttertoast.showToast(
        msg: '오류 발생: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return ''; // 오류 발생 시 빈 문자열 반환
    }

    return uploadedUrl; // 업로드된 파일 URL 반환
  }
}

/*class UploadFileService {
  static Future<List<String>> uploadFiles(List<String> imagePaths) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null || token.isEmpty) {
      Fluttertoast.showToast(
        msg: '로그인 토큰이 없습니다. 다시 로그인해 주세요.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return [];
    }

    const String s3ApiUrl = 'http://43.203.5.183:8080/s3/upload';
    Dio dio = Dio();

    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    List<String> uploadedUrls = [];

    try {
      for (String imagePath in imagePaths) {
        // 파일 확장자 체크하여 이미지 파일만 처리
        String extension = imagePath.split('.').last.toLowerCase();
        if (!['jpg', 'jpeg', 'png', 'gif'].contains(extension)) {
          Fluttertoast.showToast(
            msg: '지원되지 않는 파일 형식입니다.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          continue; // 이미지 파일이 아니면 건너뛰기
        }

        // 웹과 모바일에서 파일을 다루는 방식이 다름
        FormData formData;

        if (kIsWeb) {
          // 웹에서 처리할 때: 파일 경로를 사용하지 않고 직접 파일을 포함
          formData = FormData.fromMap({
            "file": await MultipartFile.fromFile(imagePath,
                filename: imagePath.split('/').last), // 파일 경로는 그대로 사용
          });
        } else {
          // 안드로이드에서는 Uint8List 형식으로 데이터를 처리
          formData = FormData.fromMap({
            "file": await MultipartFile.fromFile(imagePath,
                filename: imagePath.split('/').last),
          });
        }

        Response response = await dio.post(s3ApiUrl, data: formData);

        if (response.statusCode == 200) {
          uploadedUrls.add(response.data['url']);
          print('파일 업로드 성공: ${response.data['url']}');
        } else {
          Fluttertoast.showToast(
            msg: '파일 업로드 실패: ${response.statusCode}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      }

      return uploadedUrls;
    } catch (e) {
      Fluttertoast.showToast(
        msg: '파일 업로드 오류: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return [];
    }
  }
}*/
