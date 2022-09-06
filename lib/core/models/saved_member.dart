class SavedMember {
  SavedMember({
    required this.memberId,
    required this.memberName,
    required this.profilePic,
    required this.rating,
    required this.saveInstanceId,
  });

  int memberId;
  String memberName;
  String profilePic;
  double rating;
  int saveInstanceId;

  factory SavedMember.fromJson(Map<String, dynamic> json) {
    return SavedMember(
      memberId: json["member_id"],
      memberName: json["member_name"],
      profilePic: json["profile_pic"],
      rating: double.tryParse(json["rating"].toString()) ?? 0.0,
      saveInstanceId: json["save_instance_id"],
    );
  }
}
