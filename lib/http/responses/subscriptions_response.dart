import 'package:arcopen_enquirer/core/models/plan.dart';

class SubscriptionsResponse {
  SubscriptionsResponse({
    required this.employerPlans,
    required this.freePlans,
    required this.memberPlans,
  });

  List<Plan> employerPlans;
  List<Plan> freePlans;
  List<Plan> memberPlans;

  factory SubscriptionsResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionsResponse(
      employerPlans: List<Plan>.from(json["employer_plans"].map((x) => Plan.fromJson(x))),
      freePlans: List<Plan>.from(json["free_plans"].map((x) => Plan.fromJson(x))),
      memberPlans: List<Plan>.from(json["member_plans"].map((x) => Plan.fromJson(x))),
    );
  }
}
