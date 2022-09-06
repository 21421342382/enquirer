import 'package:arcopen_enquirer/core/models/wallet.dart';

class PaySubscriptionResponse {
  PaySubscriptionResponse({
    required this.status,
    required this.wallet,
  });

  String status;
  Wallet wallet;

  factory PaySubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return PaySubscriptionResponse(
      status: json["status"],
      wallet: Wallet.fromJson(json["wallet"]),
    );
  }
}
