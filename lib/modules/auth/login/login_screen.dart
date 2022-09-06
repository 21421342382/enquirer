import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/modules/auth/login/login_controller.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text("Hit back button again to close"),
        ),
        child: OkitoBuilder(
          controller: controller,
          builder: () {
            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Okito.isLandscape ? AspectRatio(aspectRatio: 15 / 1) : AspectRatio(aspectRatio: 10 / 4),
                          Container(
                            width: 200,
                            height: 80,
                            child: Image.asset("assets/images/logo.png"),
                          ),
                          Text("Log In and get things done"),
                          SizedBox(height: 50),
                          KTextField(
                            controller: controller.emailController,
                            hintText: "email",
                            icon: PhosphorIcons.envelope,
                            validator: (String? value) {
                              return controller.validateRequired(fieldName: "email", value: value);
                            },
                          ),
                          SizedBox(height: 20),
                          KTextField(
                            controller: controller.passwordController,
                            hintText: "password",
                            isPassword: true,
                            icon: PhosphorIcons.key_fill,
                            validator: (String? value) {
                              return controller.validateRequired(fieldName: "password", value: value);
                            },
                          ),
                          SizedBox(height: 20),
                          KButton(
                            onPressed: () {
                              controller.login();
                            },
                            title: "LOG IN",
                            color: ColorConstants.greenColor,
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              KRouter().push(KRoutes.resetPasswordRoute);
                            },
                            child: Text(
                              "Forgot password ?",
                              style: Okito.theme.textTheme.bodyText2!.copyWith(
                                color: ColorConstants.greyColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "- OR -",
                            style: Okito.theme.textTheme.bodyText2!.copyWith(
                              color: ColorConstants.greyColor,
                            ),
                          ),
                          SizedBox(height: 20),
                          KButton.outlined(
                            expanded: true,
                            onPressed: () {
                              KRouter().push(KRoutes.registerRoute);
                            },
                            title: "+ CREATE ACCOUNT",
                            color: Okito.theme.primaryColor,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
