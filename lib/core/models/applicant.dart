import 'package:arcopen_enquirer/core/models/member.dart';

class Applicant {
  Applicant({
    required this.applicantName,
    required this.applicationId,
    required this.hourlyRate,
    required this.memberId,
    required this.profilePic,
    required this.rating,
    bool saved = false,
  }) : saved = saved;

  String? applicantName;
  int? applicationId;
  String? hourlyRate;
  int? memberId;
  String? profilePic;
  double? rating;
  bool saved;

  factory Applicant.fromMember(Member member) {
    return Applicant(
      applicantName: member.memberName,
      applicationId: null,
      hourlyRate: member.perHourRate,
      memberId: member.memberId,
      profilePic: member.profilePic,
      rating: member.rating,
      saved: member.saved,
    );
  }

  factory Applicant.fromJson(Map<String, dynamic> json) {
    return Applicant(
      applicantName: json["applicant_name"] ?? json["name"],
      applicationId: json["application_id"],
      hourlyRate: json["hourly_rate"],
      memberId: json["member_id"],
      profilePic: json["profile_pic"],
      rating: double.tryParse(json["rating"].toString()),
    );
  }
}
