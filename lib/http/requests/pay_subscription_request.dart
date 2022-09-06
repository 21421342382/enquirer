import 'package:arcopen_enquirer/core/models/k_card.dart';
import 'package:arcopen_enquirer/core/models/plan.dart';
import 'package:arcopen_enquirer/http/requests/base_request.dart';
import 'package:dio/dio.dart';

class PaySubscriptionRequest extends BaseRequest {
  PaySubscriptionRequest({
    required this.card,
    required this.plan,
    required this.cycle,
    required this.cvv,
  });

  final KCard card;
  final Plan plan;
  final String cycle;
  final String cvv;

  Map<String, dynamic> toJson() {
    print(card.cardNumber);
    return {
      "plan_id": plan.planId.toString(),
      "billing_cycle": cycle,
      "card_number": card.cardNumber.split(" ").join(""),
      "exp_month": card.expiryDate.split("/").first,
      "exp_year": card.expiryDate.split("/").last,
      "cvv": cvv,
    };
  }

  FormData toFormData() {
    final data = FormData.fromMap(this.toJson());
    return data;
  }
}
