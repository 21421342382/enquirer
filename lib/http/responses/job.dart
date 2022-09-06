import 'package:arcopen_enquirer/core/models/job.dart';

class JobResponse {
  JobResponse({
    required this.job,
  });

  Job job;

  factory JobResponse.fromJson(Map<String, dynamic> json) =>
      JobResponse(job: Job.fromJson(json["job_details"]));
}
