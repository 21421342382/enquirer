class InvoiceDetails {
  InvoiceDetails({
    required this.applicationId,
    required this.businessName,
    required this.hours,
    required this.jobId,
    required this.memberName,
    required this.paymentStatus,
    required this.perHourRate,
    required this.profilePic,
    required this.shiftEndDate,
    required this.shiftStartDate,
    required this.stars,
    required this.totalInvoiceAmount,
    required this.transactionId,
  });

  int applicationId;
  String businessName;
  String hours;
  int jobId;
  String memberName;
  String paymentStatus;
  String perHourRate;
  String profilePic;
  String shiftEndDate;
  String shiftStartDate;
  String stars;
  String totalInvoiceAmount;
  String transactionId;

  factory InvoiceDetails.fromJson(Map<String, dynamic> json) {
    return InvoiceDetails(
      applicationId: json["application_id"],
      businessName: json["business_name"],
      hours: json["hours"],
      jobId: json["job_id"],
      memberName: json["member_name"],
      paymentStatus: json["payment_status"],
      perHourRate: json["per_hour_rate"],
      profilePic: json["profile_pic"],
      shiftEndDate: json["shift_end_date"],
      shiftStartDate: json["shift_start_date"],
      stars: json["stars"],
      totalInvoiceAmount: json["total_invoice_amount"],
      transactionId: json["transaction_id"],
    );
  }
}
