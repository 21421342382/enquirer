import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/constants/app_constants.dart';
import 'package:arcopen_enquirer/core/models/profile.dart';
import 'package:arcopen_enquirer/core/models/user.dart';
import 'package:arcopen_enquirer/utils/helpers/k_storage.dart';
import 'package:okito/okito.dart';

class AuthService {
  late User user;
  late bool profileExists;
  Profile? profile;

  void logout() {
    this.profileExists = false;
    KStorage.remove(AppConstants.accessTokenKey);
    KStorage.remove(AppConstants.paymentMethodsKey);
    Okito.pushNamedAndRemoveUntil(KRoutes.loginRoute, predicate: (route) => route.isFirst);
  }
}
