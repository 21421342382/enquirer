import 'dart:io';

import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/http/requests/register_request.dart';
import 'package:arcopen_enquirer/utils/repositories/auth_repository.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class RegisterController extends BaseController {
  RegisterController._internal();
  static final RegisterController _singleton = RegisterController._internal();

  factory RegisterController() {
    return _singleton;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthRepository _repository = AuthRepository();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();

  void register() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    late String deviceType;
    late String deviceId;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceType = "android";
      deviceId = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceType = "ios";
      deviceId = iosInfo.identifierForVendor;
    } else {
      deviceType = "unknown";
      deviceId = "unknown";
    }
    if (passwordController.text == passConfirmController.text) {
      KLoader().show();
      _repository
          .register(
        request: RegisterRequest(
          deviceId: deviceId,
          deviceType: deviceType,
          email: emailController.text,
          organisationName: businessNameController.text,
          password: passwordController.text,
        ),
      )
          .then((value) {
        this.showSuccessToast(value.success);
        KLoader.hide();
        KRouter().pop();
      }).catchError((e) {
        KLoader.hide();
        this.showErrorToast("User with same email already exists as enquirer");
        //this.showErrorToast(e.message);
      });
    } else {
      this.showErrorToast("password doesn't match");
    }
  }
}
