import 'package:arcopen_enquirer/core/models/project.dart';

class ActiveJobsResponse {
  ActiveJobsResponse({
    required this.activeProjects,
  });

  List<Project> activeProjects;

  factory ActiveJobsResponse.fromJson(Map<String, dynamic> json) {
    return ActiveJobsResponse(
      activeProjects: List<Project>.from(json["active_projects"].map((x) => Project.fromJson(x))),
    );
  }
}
