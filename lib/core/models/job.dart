class Job {
  Job({
    this.budget,
    required this.businessName,
    required this.city,
    required this.companyName,
    required this.daysRemaining,
    required this.jobDescription,
    required this.jobId,
    required this.jobType,
    required this.shiftEndDate,
    required this.shiftEndTime,
    required this.shiftStartDate,
    required this.shiftStartTime,
  });

  String? budget;
  String businessName;
  String city;
  String? companyName;
  int daysRemaining;
  String jobDescription;
  dynamic jobId;
  String jobType;
  String shiftEndDate;
  String shiftEndTime;
  String shiftStartDate;
  String shiftStartTime;

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      budget: json["budget"],
      businessName: json["business_name"],
      city: json["city"],
      companyName: json["company_name"],
      daysRemaining: json["days_remaining"],
      jobDescription: json["job_description"],
      jobId: json["job_id"],
      jobType: json["job_type"],
      shiftEndDate: json["shift_end_date"],
      shiftEndTime: json["shift_end_time"],
      shiftStartDate: json["shift_start_date"],
      shiftStartTime: json["shift_start_time"],
    );
  }
}
