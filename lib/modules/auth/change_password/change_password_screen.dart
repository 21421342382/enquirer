import 'package:arcopen_enquirer/modules/auth/change_password/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/utils/navigation/k_app_bar.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordController controller = ChangePasswordController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: "Change Password",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Change Password",
                          style: Okito.theme.textTheme.headline2!
                              .copyWith(fontSize: 14.0),
                        ),
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            KTextField.exposed(
                              controller: controller.oldPasswordController,
                              hintText: "Old password",
                              isPassword: true,
                              validator: (String? value) {
                                return controller.validateMinlength(
                                    fieldName: "password",
                                    value: value!,
                                    min: 8);
                              },
                            ),
                            SizedBox(height: 20),
                            KTextField.exposed(
                              controller: controller.newPasswordController,
                              hintText: "New password",
                              isPassword: true,
                              validator: (String? value) {
                                return controller.validateMinlength(
                                    fieldName: "password",
                                    value: value!,
                                    min: 8);
                              },
                            ),
                            SizedBox(height: 20),
                            KTextField.exposed(
                              controller: controller.confirmPasswordController,
                              hintText: "Confirm new password",
                              isPassword: true,
                              validator: (String? value) {
                                if (value !=
                                    controller.newPasswordController.text) {
                                  return "The passwords does not match";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            KButton(
                              expanded: true,
                              onPressed: controller.changePassword,
                              title: "CHANGE PASSWORD",
                              color: Okito.theme.primaryColor,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
