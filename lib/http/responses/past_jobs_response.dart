import 'package:arcopen_enquirer/core/models/project.dart';

class PastJobsResponse {
  PastJobsResponse({
    required this.pastProjects,
  });

  List<Project> pastProjects;

  factory PastJobsResponse.fromJson(Map<String, dynamic> json) {
    return PastJobsResponse(
      pastProjects: List<Project>.from(json["past_projects"].map((x) => Project.fromJson(x))),
    );
  }
}
