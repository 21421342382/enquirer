class RegisterResponse {
  RegisterResponse({
    required this.success,
  });

  String success;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json["success"],
    );
  }
}
