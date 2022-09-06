import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:arcopen_enquirer/utils/services/subscription_service.dart';
import 'package:okito/okito.dart';

class KService {
  void registerServices() {
    Okito.inject<AuthService>(AuthService());
    Okito.inject<SubscriptionService>(SubscriptionService());
  }
}
