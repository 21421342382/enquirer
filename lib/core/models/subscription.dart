class Subscription {
  Subscription({
    required this.endDate,
    required this.isActive,
    required this.isCancelled,
    required this.paymentStatus,
    required this.startDate,
    required this.user,
  });

  String endDate;
  bool isActive;
  bool isCancelled;
  String paymentStatus;
  String startDate;
  int user;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      endDate: json["end_date"],
      isActive: json["is_active"],
      isCancelled: json["is_cancelled"],
      paymentStatus: json["payment_status"],
      startDate: json["start_date"],
      user: json["user"],
    );
  }
}
