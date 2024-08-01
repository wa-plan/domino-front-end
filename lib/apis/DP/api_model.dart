import 'dart:convert';

List<Goal> goalFromJson(String str) => List<Goal>.from(json.decode(str).map((x) => Goal.fromJson(x)));

String goalToJson(List<Goal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Goal {
    int id;
    String goal;
    String content;


    Goal({
        required this.id,
        required this.goal,
        required this.content,
        
    });

    factory Goal.fromJson(Map<String, dynamic> json) => Goal(
        id: json["id"],
        goal: json["goal"],
        content: json["content"],
        
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "goal": goal,
        "content": content,
       
    };
}




