class User {
  User({
    required this.badgeNumber,
    required this.createdAt,
    required this.deviceId,
    required this.deviceType,
    required this.email,
    required this.id,
    required this.isVerified,
    required this.name,
    required this.password,
    required this.updatedAt,
    required this.userType,
  });

  String? badgeNumber;
  DateTime? createdAt;
  String? deviceId;
  String? deviceType;
  String email;
  String id;
  bool isVerified;
  String name;
  String password;
  DateTime updatedAt;
  String userType;

  factory User.fromJson(Map<String, dynamic> json) => User(
        badgeNumber: json["badge_number"],
        createdAt: DateTime.parse(json["created_at"]),
        deviceId: json["device_id"],
        deviceType: json["device_type"],
        email: json["email"],
        id: json["id"],
        isVerified: json["is_verified"],
        name: json["name"],
        password: json["password"],
        updatedAt: DateTime.parse(json["updated_at"]),
        userType: json["user_type"],
      );
}
