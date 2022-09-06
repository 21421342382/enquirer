class FundDetails {
  FundDetails({
    required this.aosAccountRefund,
    required this.aosOneOff,
    required this.aosStandard,
    required this.adminCharges,
    required this.biddingFees,
    required this.netPayable,
    required this.payPerHour,
    required this.subTotal,
    required this.totalExpected,
    required this.totalPay,
  });

  final String aosAccountRefund;
  final double aosOneOff;
  final double aosStandard;
  final String adminCharges;
  final String biddingFees;
  final String netPayable;
  final String payPerHour;
  final String subTotal;
  final int totalExpected;
  final String totalPay;

  factory FundDetails.fromJson(Map<String, dynamic> json) {
    return FundDetails(
      aosAccountRefund: json['AOS_Account_Refund_Vat_@20%'],
      aosOneOff: json['AOS_One_Off_Misc_Payment'],
      aosStandard: json['AOS_Standard_Addition_Per_Hour'],
      adminCharges: json['Admin_Charges_@£1.5_Per_Hour'],
      biddingFees: json['Bidding_Fees_@10P_Per_Hour'],
      netPayable: json['Net_Payable'],
      payPerHour: json['Pay_Per_Hour'],
      subTotal: json['Sub_Total'],
      totalExpected: json['Total_Expected_Hours_Worked'],
      totalPay: json['Total_Pay'],
    );
  }
}
