import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/modules/auth/register/register_controller.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    KRouter().pop();
                  },
                  icon: Icon(PhosphorIcons.arrow_left_bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Sign Up",
                  style: Okito.theme.textTheme.headline2,
                ),
                SizedBox(height: 40),
                KTextField.soft(
                    label: "ORGANISATION NAME *",
                    controller: controller.businessNameController,
                    validator: (value) {
                      controller.validateRequired(fieldName: "Organisation name", value: value);
                    }),
                SizedBox(height: 20),
                KTextField.soft(
                  label: "EMAIL *",
                  keybordType: TextInputType.emailAddress,
                  controller: controller.emailController,
                  validator: (email) {
                    controller.validateEmail(fieldName: "Email", email: email!);
                  },
                ),
                SizedBox(height: 20),
                KTextField.soft(
                  label: "PASSWORD *",
                  isPassword: true,
                  controller: controller.passwordController,
                  validator: (String? value) {
                    return controller.validateMinlength(fieldName: "password", value: value!, min: 8);
                  },
                ),
                SizedBox(height: 20),
                KTextField.soft(
                  label: "CONFIRM PASSWORD",
                  isPassword: true,
                  controller: controller.passConfirmController,
                  validator: (String? value) {
                    if (controller.passConfirmController.text != controller.passwordController.text) {
                      return "The passwords does not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12.0),
        child: KButton.outlined(
          expanded: true,
          onPressed: () {
            controller.register();
          },
          title: "CREATE ACCOUNT",
          color: Okito.theme.primaryColor,
        ),
      ),
    );
  }
}
