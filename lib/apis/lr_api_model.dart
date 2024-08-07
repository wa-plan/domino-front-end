
class User {
  final String userid;
  final String token;

  User({required this.userid, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json['userid'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'token': token,
    };
  }
}
