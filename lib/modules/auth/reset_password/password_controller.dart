import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/utils/repositories/auth_repository.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/config/routes/k_routes.dart';

class PasswordController extends BaseController {
  PasswordController._internal();
  static final PasswordController _singleton = PasswordController._internal();

  factory PasswordController() {
    return _singleton;
  }

  final AuthRepository _repository = AuthRepository();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController resetPasswordEmailController = TextEditingController();

  void sendResetPasswordRequest() {
    if (resetPasswordFormKey.currentState!.validate()) {
      final Map<String, dynamic> data = {
        "email": resetPasswordEmailController.text,
      };
      KLoader().show();
      _repository.sendForgotPasswordRequest(data).then((value) {
        KLoader.hide();
        Okito.pushNamed(KRoutes.resetPasswordSuccessRoute, arguments: data);
      }).catchError((e) {
        KLoader.hide();
        this.showErrorToast(e.message);
      });
    }
  }
}
