import 'package:arcopen_enquirer/core/models/project.dart';

class PostedJobsResponse {
  PostedJobsResponse({
    required this.postedProjects,
  });

  List<Project> postedProjects;

  factory PostedJobsResponse.fromJson(Map<String, dynamic> json) {
    return PostedJobsResponse(
      postedProjects: List<Project>.from(json["posted_projects"].map((x) => Project.fromJson(x))),
    );
  }
}
