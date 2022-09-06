import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/constants/app_constants.dart';
import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/profile.dart';
import 'package:arcopen_enquirer/http/requests/login_request.dart';
import 'package:arcopen_enquirer/utils/helpers/k_storage.dart';
import 'package:arcopen_enquirer/utils/repositories/auth_repository.dart';
import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:okito/okito.dart';
import 'package:flutter/material.dart';
import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/mixins/validation_mixin.dart';

class LoginController extends BaseController with ValidationMixin, ToastMixin {
  LoginController._internal();
  static final LoginController _singleton = LoginController._internal();

  factory LoginController() {
    return _singleton;
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (kDebugMode) {
        emailController.text = "koh.lanta@yopmail.com";
        passwordController.text = "12345678";
        setState(() {});
      }
    });
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRepository _repository = AuthRepository();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    if (formKey.currentState!.validate()) {
      KLoader().show();
      _repository.login(request: LoginRequest(email: emailController.text, password: passwordController.text)).then((value) async {
        KLoader.hide();
        if (value.user.userType != "enquirer") {
          this.showErrorToast("This app is reserved for users with enquirer profile. Please consider using the member application.");
          return;
        }
        KStorage.write(key: AppConstants.accessTokenKey, value: value.accessToken);

        Okito.use<AuthService>().profileExists = value.profileExists;
        Okito.use<AuthService>().user = value.user;
        if (value.profileExists) {
          final Profile profile = await _repository.readEnquirerProfile();
          Okito.use<AuthService>().profile = profile;
          KRouter().push(KRoutes.homeRoute, replace: true);
        } else {
          KRouter().push(KRoutes.userProfileRoute, replace: true);
        }
      }).catchError((e) {
        KLoader.hide();
        this.showErrorToast(e.message);
      });
    }
  }
}
