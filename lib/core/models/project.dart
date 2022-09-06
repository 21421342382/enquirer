import 'package:arcopen_enquirer/core/models/applicant.dart';

class Project {
  Project({
    required this.applicants,
    required this.applicantsArray,
    required this.budget,
    required this.businessName,
    required this.city,
    required this.companyName,
    required this.daysRemaining,
    required this.jobId,
  });

  dynamic applicants;
  List<Applicant> applicantsArray;
  String? budget;
  String businessName;
  String city;
  String companyName;
  int? daysRemaining;
  int jobId;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      applicants: json["applicants"],
      applicantsArray:  json['applicants_array'] == null ? [] : List<Applicant>.from(json["applicants_array"].map((x) => Applicant.fromJson(x))),
      budget: json["budget"],
      businessName: json["business_name"],
      city: json["city"],
      companyName: json["company_name"],
      daysRemaining: json["days_remaining"],
      jobId: json["job_id"],
    );
  }
}
