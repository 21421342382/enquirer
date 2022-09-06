import 'package:arcopen_enquirer/core/models/saved_member.dart';

class RemoveSavedMemberResponse {
  RemoveSavedMemberResponse({
    required this.savedMembers,
    required this.success,
  });

  List<SavedMember> savedMembers;
  String success;

  factory RemoveSavedMemberResponse.fromJson(Map<String, dynamic> json) {
    return RemoveSavedMemberResponse(
      savedMembers: List<SavedMember>.from(json["saved_members"].map((x) => SavedMember.fromJson(x))),
      success: json["success"],
    );
  }
}
