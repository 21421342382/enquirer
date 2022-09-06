import 'package:arcopen_enquirer/core/models/dispute.dart';

class DisputeResponse {
  DisputeResponse({
    required this.disputes,
  });

  List<Dispute> disputes;

  factory DisputeResponse.fromJson(Map<String, dynamic> json) =>
      DisputeResponse(
          disputes: List<Dispute>.from(
              json["complaints"].map((e) => Dispute.fromJson(e))));
}
