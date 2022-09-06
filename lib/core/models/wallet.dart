class Wallet {
  Wallet({
    required this.balance,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.userId,
  });

  String balance;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  int userId;

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      balance: json["balance"],
      createdAt: DateTime.parse(json["created_at"]),
      id: json["id"],
      updatedAt: DateTime.parse(json["updated_at"]),
      userId: json["user_id"],
    );
  }
}
