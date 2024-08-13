import 'dart:convert';


class Goal {
    int id;
    String goal;
    int image;
}


    Goal({
        required this.id,
        required this.goal,
        required this.image,
    });

    factory Goal.fromJson(Map<String, dynamic> json) => Goal(
        id: json["id"],
        goal: json["goal"],
        content: json["image"],
        
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "goal": goal,
        "image": image,
       
    };
}
