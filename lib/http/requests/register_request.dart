import 'package:arcopen_enquirer/http/requests/base_request.dart';

class RegisterRequest extends BaseRequest {
  RegisterRequest({
    required this.organisationName,
    required this.email,
    required this.password,
    required this.deviceType,
    required this.deviceId,
  });

  String organisationName;
  String email;
  String password;
  String deviceType;
  String deviceId;

  Map<String, dynamic> toJson() {
    return {
      "organisation_name": organisationName,
      "email": email,
      "password": password,
      "device_type": deviceType,
      "device_id": deviceId,
    };
  }
}
