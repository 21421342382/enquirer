import 'base_request.dart';

class LoginRequest extends BaseRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.password,
    required this.email,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}
