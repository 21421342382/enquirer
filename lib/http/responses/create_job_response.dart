class CreateJobResponse {
  CreateJobResponse({
    required this.companyName,
    required this.jobDetails,
    required this.success,
  });

  String companyName;
  JobDetails jobDetails;
  String success;

  factory CreateJobResponse.fromJson(Map<String, dynamic> json) {
    return CreateJobResponse(
      companyName: json["company_name"],
      jobDetails: JobDetails.fromJson(json["job_details"]),
      success: json["success"],
    );
  }
}

class JobDetails {
  JobDetails({
    required this.address,
    required this.biddingStarted,
    required this.budget,
    required this.businessName,
    required this.city,
    required this.contract,
    required this.createdAt,
    required this.emergencyRate,
    required this.id,
    required this.interestedCount,
    required this.isDraft,
    required this.jobCategory,
    required this.jobDescription,
    required this.jobType,
    required this.postedBy,
    required this.shiftEndDate,
    required this.shiftEndTime,
    required this.shiftStartDate,
    required this.shiftStartTime,
    required this.shiftType,
    required this.updatedAt,
    required this.vacancies,
  });

  String address;
  bool biddingStarted;
  String budget;
  String businessName;
  String city;
  String contract;
  DateTime createdAt;
  String emergencyRate;
  String id;
  dynamic interestedCount;
  bool isDraft;
  String jobCategory;
  String jobDescription;
  String jobType;
  int postedBy;
  DateTime shiftEndDate;
  String shiftEndTime;
  DateTime shiftStartDate;
  String shiftStartTime;
  String shiftType;
  DateTime updatedAt;
  String vacancies;

  factory JobDetails.fromJson(Map<String, dynamic> json) {
    return JobDetails(
      address: json["address"],
      biddingStarted: json["bidding_started"],
      budget: json["budget"],
      businessName: json["business_name"],
      city: json["city"],
      contract: json["contract"],
      createdAt: DateTime.parse(json["created_at"]),
      emergencyRate: json["emergency_rate"],
      id: json["id"],
      interestedCount: json["interested_count"],
      isDraft: json["is_draft"],
      jobCategory: json["job_category"],
      jobDescription: json["job_description"],
      jobType: json["job_type"],
      postedBy: json["posted_by"],
      shiftEndDate: DateTime.parse(json["shift_end_date"]),
      shiftEndTime: json["shift_end_time"],
      shiftStartDate: DateTime.parse(json["shift_start_date"]),
      shiftStartTime: json["shift_start_time"],
      shiftType: json["shift_type"],
      updatedAt: DateTime.parse(json["updated_at"]),
      vacancies: json["vacancies"],
    );
  }
}
