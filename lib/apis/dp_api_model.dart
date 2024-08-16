import 'dart:convert';

// JSON 문자열을 Goal 객체 목록으로 변환하는 함수
List<Goal> goalFromJson(String str) =>
    List<Goal>.from(json.decode(str).map((x) => Goal.fromJson(x)));

// Goal 객체 목록을 JSON 문자열로 변환하는 함수
String goalToJson(List<Goal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Goal {
  int id;
  String goal;
  String content;

  Goal({
    required this.id,
    required this.goal,
    required this.content,
  });

  // JSON 데이터를 Goal 객체로 변환하는 팩토리 메서드
  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
        id: json["id"] ?? 0, // id가 null이면 기본값 0으로 처리
        goal: json["goal"] ?? '', // goal이 null이면 빈 문자열로 처리
        content: json["content"] ?? '', // content가 null이면 빈 문자열로 처리
      );

  // Goal 객체를 JSON 데이터로 변환하는 메서드
  Map<String, dynamic> toJson() => {
        "id": id,
        "goal": goal,
        "content": content,
      };
}
