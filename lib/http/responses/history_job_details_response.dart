class HistoryJobDetailsResponse {
  HistoryJobDetailsResponse({
    required this.hiredMembers,
    required this.jobDetails,
    required this.totalAmount,
    required this.totalHours,
  });

  List<HiredMember> hiredMembers;
  HistoryJob jobDetails;
  String totalAmount;
  double totalHours;

  factory HistoryJobDetailsResponse.fromJson(Map<String, dynamic> json) {
    return HistoryJobDetailsResponse(
      hiredMembers: List<HiredMember>.from(json["hired_members"].map((x) => HiredMember.fromJson(x))),
      jobDetails: HistoryJob.fromJson(json["job_details"]),
      totalAmount: json["total_amount"],
      totalHours: double.parse(json["total_hours"].toString()),
    );
  }
}

class HiredMember {
  HiredMember({
    required this.amount,
    required this.applicationId,
    required this.hours,
    required this.memberId,
    required this.memberName,
    required this.perHourRate,
    required this.profilePic,
  });

  String amount;
  int applicationId;
  String hours;
  int memberId;
  String memberName;
  String perHourRate;
  String profilePic;

  factory HiredMember.fromJson(Map<String, dynamic> json) {
    return HiredMember(
      amount: json["amount"],
      applicationId: json["application_id"],
      hours: json["hours"],
      memberId: json["member_id"],
      memberName: json["member_name"],
      perHourRate: json["per_hour_rate"],
      profilePic: json["profile_pic"],
    );
  }
}

class HistoryJob {
  HistoryJob({
    required this.businessName,
    required this.companyName,
    required this.id,
    required this.jobType,
    required this.shiftEndDate,
    required this.shiftStartDate,
  });

  String businessName;
  String companyName;
  String id;
  String jobType;
  String shiftEndDate;
  String shiftStartDate;

  factory HistoryJob.fromJson(Map<String, dynamic> json) {
    return HistoryJob(
      businessName: json["business_name"],
      companyName: json["company_name"],
      id: json["id"],
      jobType: json["job_type"],
      shiftEndDate: json["shift_end_date"],
      shiftStartDate: json["shift_start_date"],
    );
  }
}
