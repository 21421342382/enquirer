import 'package:arcopen_enquirer/core/models/user.dart';

class LoginResponse {
  LoginResponse({
    required this.accessToken,
    required this.profileExists,
    required this.user,
  });

  String? accessToken;
  bool profileExists;
  User user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json["access_token"],
      profileExists: json["profile_exists"],
      user: User.fromJson(json["user"]),
    );
  }
}
