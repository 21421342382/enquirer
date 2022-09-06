import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/profile.dart';
import 'package:arcopen_enquirer/http/exceptions/auth_exception.dart';
import 'package:arcopen_enquirer/http/responses/login_response.dart';
import 'package:arcopen_enquirer/utils/repositories/auth_repository.dart';
import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/constants/app_constants.dart';
import 'package:arcopen_enquirer/utils/helpers/k_storage.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';

class SplashScreenController extends BaseController with ToastMixin {
  SplashScreenController._internal();
  static final SplashScreenController _singleton = SplashScreenController._internal();

  factory SplashScreenController() {
    return _singleton;
  }

  bool initDataFailed = false;
  final AuthRepository _repository = AuthRepository();

  Future<void> initialize() async {
    setState(() {
      initDataFailed = false;
    });

    await Future.delayed(Duration(seconds: 1));
    if (KStorage.read(key: AppConstants.firstAppOpeningKey) == null) {
      KRouter().push(KRoutes.stepperRoute, replace: true);
      return;
    }
    if (KStorage.contains(AppConstants.accessTokenKey)) {
      try {
        bool result = await _loadMemberProfile();
        if (result)
          KRouter().push(KRoutes.homeRoute, replace: true);
        else
          KRouter().push(KRoutes.userProfileRoute, replace: true);
      } catch (e) {
        if (e.toString().contains("422")) {
          KRouter().push(KRoutes.loginRoute, replace: true);
        } else {
          setState(() {
            initDataFailed = true;
          });
          this.showErrorToast("Failed to load data. Please try again later.");
        }
      }
      return;
    }
    KRouter().push(KRoutes.loginRoute, replace: true);
  }

  Future<bool> _loadMemberProfile() async {
    bool _result = false;
    try {
      final LoginResponse loginResponse = await _repository.getLoggedUser();
      Okito.use<AuthService>().user = loginResponse.user;
      Okito.use<AuthService>().profileExists = loginResponse.profileExists;
      if (loginResponse.profileExists) {
        final Profile profile = await _repository.readEnquirerProfile();
        Okito.use<AuthService>().profile = profile;
      }
      _result = loginResponse.profileExists;
    } on DioError catch (e) {
      throw new AuthException(message: "Auth failed", code: e.response?.statusCode);
    }
    return _result;
  }
}
