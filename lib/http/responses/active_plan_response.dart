import 'package:arcopen_enquirer/core/models/subscription.dart';

class ActivePlanResponse {
  ActivePlanResponse({
    required this.subscription,
  });

  List<Subscription> subscription;

  factory ActivePlanResponse.fromJson(Map<String, dynamic> json) {
    return ActivePlanResponse(
      subscription: List<Subscription>.from(json["subscription"].map((x) => Subscription.fromJson(x))),
    );
  }
}
