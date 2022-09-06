class ChangePasswordRequest {
  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  String oldPassword;
  String newPassword;
  String confirmPassword;

  Map<String, dynamic> toJson() {
    return {
      "old_password": oldPassword,
      "new_password": newPassword,
      "confirm_password": confirmPassword,
    };
  }
}
