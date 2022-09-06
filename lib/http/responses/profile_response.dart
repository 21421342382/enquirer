import 'package:arcopen_enquirer/core/models/profile.dart';

class ProfileResponse {
  ProfileResponse({
    required this.profile,
    required this.success,
  });

  Profile profile;
  String success;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      profile: Profile.fromJson(json["profile"]),
      success: json["success"],
    );
  }
}
