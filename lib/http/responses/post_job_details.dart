import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/core/models/job.dart';

class PostedJobDetailsResponse {
  PostedJobDetailsResponse({
    required this.applicants,
    required this.jobDetails,
  });

  List<Applicant> applicants;
  List<Job> jobDetails;

  factory PostedJobDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PostedJobDetailsResponse(
      applicants: List<Applicant>.from(json["applicants"].map((x) => Applicant.fromJson(x))),
      jobDetails: List<Job>.from(json['job_details'].map((x) => Job.fromJson(x))),
    );
  }
}
