class FinanceResponse {
  FinanceResponse({
    required this.funded,
    required this.paidTransactions,
    required this.totalJobs,
    required this.totalPaid,
    required this.unpaidTransactions,
  });

  String funded;
  List<PaidTransaction> paidTransactions;
  String totalJobs;
  String totalPaid;
  List<UnpaidTransaction> unpaidTransactions;

  factory FinanceResponse.fromJson(Map<String, dynamic> json) => FinanceResponse(
        funded: json["funded"],
        paidTransactions: List<PaidTransaction>.from(json["paid_transactions"].map((x) => PaidTransaction.fromJson(x))),
        totalJobs: json["total_jobs"],
        totalPaid: json["total_paid"],
        unpaidTransactions: List<UnpaidTransaction>.from(json["unpaid_transactions"].map((x) => UnpaidTransaction.fromJson(x))),
      );
}

class PaidTransaction {
  PaidTransaction({
    required this.amountPaid,
    required this.applicationId,
    required this.businessName,
    required this.jobId,
    required this.jobType,
    required this.memberName,
    required this.month,
    required this.paymentDate,
    required this.paymentStatus,
    required this.profilePic,
    required this.stars,
    required this.transactionId,
  });

  String amountPaid;
  int applicationId;
  String businessName;
  int jobId;
  String jobType;
  String memberName;
  String month;
  String paymentDate;
  String paymentStatus;
  String profilePic;
  double stars;
  int transactionId;

  factory PaidTransaction.fromJson(Map<String, dynamic> json) => PaidTransaction(
        amountPaid: json["amount_paid"],
        applicationId: json["application_id"],
        businessName: json["business_name"],
        jobId: json["job_id"],
        jobType: json["job_type"],
        memberName: json["member_name"],
        month: json["month"],
        paymentDate: json["payment_date"],
        paymentStatus: json["payment_status"],
        profilePic: json["profile_pic"],
        stars: double.parse(json["stars"].toString()),
        transactionId: json["transaction_id"],
      );
}

class UnpaidTransaction {
  UnpaidTransaction({
    required this.amountPaid,
    required this.applicationId,
    required this.businessName,
    required this.jobId,
    required this.jobType,
    required this.memberName,
    required this.month,
    required this.paymentStatus,
    required this.profilePic,
    required this.stars,
    required this.transactionId,
  });

  String amountPaid;
  int applicationId;
  String businessName;
  int jobId;
  String jobType;
  String memberName;
  String month;
  String paymentStatus;
  String profilePic;
  double stars;
  int transactionId;

  factory UnpaidTransaction.fromJson(Map<String, dynamic> json) => UnpaidTransaction(
        amountPaid: json["amount_paid"],
        applicationId: json["application_id"],
        businessName: json["business_name"],
        jobId: json["job_id"],
        jobType: json["job_type"],
        memberName: json["member_name"],
        month: json["month"],
        paymentStatus: json["payment_status"],
        profilePic: json["profile_pic"],
        stars: double.parse(json["stars"].toString()),
        transactionId: json["transaction_id"],
      );
}
