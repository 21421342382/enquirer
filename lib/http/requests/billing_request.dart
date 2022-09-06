class BillingRequest {
  BillingRequest(
      {required this.accountRefund,
      required this.additionPerHour,
      required this.adminCharges,
      required this.applicationId,
      required this.biddingFees,
      required this.cardNumber,
      required this.cvv,
      required this.expMonth,
      required this.expYear,
      required this.miscPayment,
      required this.netPayable,
      required this.totalPay});

  final String cardNumber;
  final String expMonth;
  final String expYear;
  final String cvv;
  final int applicationId;
  final String totalPay;
  final String netPayable;
  final String adminCharges;
  final String biddingFees;
  final String accountRefund;
  final String miscPayment;
  final String additionPerHour;

  Map<String, dynamic> toJson() => {
        "card_number": cardNumber,
        "exp_month": expMonth,
        "exp_year": expYear,
        "cvv": cvv,
        "application_id": applicationId,
        "total_pay": totalPay,
        "net_payable": netPayable,
        "admin_charges": adminCharges,
        "bidding_fees": biddingFees,
        "AOS_Account_Refund": accountRefund,
        "AOS_One_Off_Misc_Payment": miscPayment,
        "AOS_Standard_Addition_Per_Hour": additionPerHour
      };
}
