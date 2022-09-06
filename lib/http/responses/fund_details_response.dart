import 'package:arcopen_enquirer/core/models/fund_details.dart';

class FundDetailsResponse {
  FundDetailsResponse({required this.fundDetails});

  List<FundDetails> fundDetails;

  factory FundDetailsResponse.fromJson(Map<String, dynamic> json) {
    return FundDetailsResponse(
      fundDetails: List<FundDetails>.from(
          json['fund_details'].map((e) => FundDetails.fromJson(e))),
    );
  }
}
