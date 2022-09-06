import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/modules/auth/reset_password/password_controller.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final PasswordController controller = PasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Okito.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: controller.resetPasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(aspectRatio: 10 / 2),
                  Container(
                    child: Image.asset("assets/images/keys.png"),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Enter your email and we'll send you instructions to set new password",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  KTextField(
                    controller: controller.resetPasswordEmailController,
                    hintText: "email",
                    icon: PhosphorIcons.envelope_fill,
                    validator: (String? email) {
                      return controller.validateEmail(fieldName: "email", email: email!);
                    },
                  ),
                  SizedBox(height: 20),
                  KButton(
                    onPressed: controller.sendResetPasswordRequest,
                    title: "RESET PASSWORD",
                    color: ColorConstants.greenColor,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
