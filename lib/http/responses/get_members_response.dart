import 'package:arcopen_enquirer/core/models/member.dart';

class GetMembersResponse {
  GetMembersResponse({
    required this.allMembers,
    required this.highRated,
  });

  List<Member> allMembers;
  List<Member> highRated;

  factory GetMembersResponse.fromJson(Map<String, dynamic> json) => GetMembersResponse(
        allMembers: List<Member>.from(json["all_members"].map((x) => Member.fromJson(x))),
        highRated: List<Member>.from(json["high_rated"].map((x) => Member.fromJson(x))),
      );
}
