class Plan {
  Plan({
    required this.createdAt,
    required this.description,
    required this.discount,
    required this.monthlyPrice,
    required this.name,
    required this.planId,
    required this.planType,
    required this.updatedAt,
    required this.yearlyPrice,
  });

  String createdAt;
  String description;
  String discount;
  String? monthlyPrice;
  String name;
  int planId;
  String planType;
  String updatedAt;
  String yearlyPrice;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        createdAt: json["created_at"],
        description: json["description"],
        discount: json["discount"],
        monthlyPrice: json["monthly_price"] == null ? null : json["monthly_price"],
        name: json["name"],
        planId: json["plan_id"],
        planType: json["plan_type"],
        updatedAt: json["updated_at"],
        yearlyPrice: json["yearly_price"],
      );
}
