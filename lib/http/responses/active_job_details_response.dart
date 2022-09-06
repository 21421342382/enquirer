class ActiveJobDetailsResponse {
  ActiveJobDetailsResponse({
    required this.activeMembers,
    required this.completedMembers,
    required this.inactiveMembers,
    required this.jobDetails,
  });

  List<JobMember> activeMembers;
  List<JobMember> completedMembers;
  List<JobMember> inactiveMembers;
  ActiveJob jobDetails;

  factory ActiveJobDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ActiveJobDetailsResponse(
      activeMembers: List<JobMember>.from(json["active_members"].map((x) => JobMember.fromJson(x))),
      completedMembers: List<JobMember>.from(json["completed_members"].map((x) => JobMember.fromJson(x))),
      inactiveMembers: List<JobMember>.from(json["inactive_members"].map((x) => JobMember.fromJson(x))),
      jobDetails: ActiveJob.fromJson(json["job_details"]),
    );
  }
}

class JobMember {
  JobMember({
    required this.applicationId,
    required this.memberId,
    required this.memberName,
    required this.memberStatus,
    required this.profilePic,
    required this.todayDate,
  });

  int applicationId;
  int memberId;
  String memberName;
  String memberStatus;
  String profilePic;
  String todayDate;

  factory JobMember.fromJson(Map<String, dynamic> json) {
    return JobMember(
      applicationId: json["application_id"],
      memberId: json["member_id"],
      memberName: json["member_name"],
      memberStatus: json["member_status"],
      profilePic: json["profile_pic"],
      todayDate: json["today_date"],
    );
  }
}

class ActiveJob {
  ActiveJob({
    required this.businessName,
    required this.companyName,
    required this.id,
    required this.jobDescription,
    required this.jobType,
    required this.shiftEndDate,
    required this.shiftStartDate,
  });

  String businessName;
  String companyName;
  String id;
  String jobDescription;
  String jobType;
  String shiftEndDate;
  String shiftStartDate;

  factory ActiveJob.fromJson(Map<String, dynamic> json) {
    return ActiveJob(
      businessName: json["business_name"],
      companyName: json["company_name"],
      id: json["id"],
      jobDescription: json["job_description"],
      jobType: json["job_type"],
      shiftEndDate: json["shift_end_date"],
      shiftStartDate: json["shift_start_date"],
    );
  }
}
