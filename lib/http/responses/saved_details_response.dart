import 'package:arcopen_enquirer/core/models/job.dart';
import 'package:arcopen_enquirer/core/models/saved_member.dart';

class SavedDetailsResponse {
  SavedDetailsResponse({
    required this.drafts,
    required this.savedMembers,
  });

  List<Job> drafts;
  List<SavedMember> savedMembers;

  factory SavedDetailsResponse.fromJson(Map<String, dynamic> json) {
    return SavedDetailsResponse(
      drafts: List<Job>.from(json["drafts"].map((x) => Job.fromJson(x))),
      savedMembers: List<SavedMember>.from(json["saved_members"].map((x) => SavedMember.fromJson(x))),
    );
  }
}
