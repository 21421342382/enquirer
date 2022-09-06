import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/utils/mixins/logging_mixin.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:okito/okito.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Managing users subscriptions
class SubscriptionService extends OkitoController with LoggingMixin, ToastMixin {
  static final String revenueCatApiKey = dotenv.env["REVENUE_CAT_API_KEY"]!;
  String? activeSubscription ;
  Future<void> init() async {
    await Purchases.setDebugLogsEnabled(kDebugMode);
    await Purchases.setup(revenueCatApiKey, appUserId: Okito.use<AuthService>().user.id);
  }

  Future<bool> _purchaseProduct(Product product) async {
    try {
      await Purchases.purchaseProduct(product.identifier);
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future<Offering?> getCurrentSubscription() async {
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    if (purchaserInfo.activeSubscriptions.isNotEmpty) {
      final String sub = purchaserInfo.activeSubscriptions.first;
      if (sub.contains("gold")) {
        activeSubscription = "gold_enquirer";
      } else {
        activeSubscription = "enquirer";
      }
    }
  }

  Future<void> purchaseItem(Product product) async {
    try {
      if (await _purchaseProduct(product)) {
        activeSubscription = product.identifier;
        Okito.popUntil(KRoutes.homeRoute);
        showSuccessToast("🎉 Congrats ! You've successfully subscribed to the ${product.title} plan.");
      } else {
        showErrorToast("The purchase of the subscription failed. Please try again later.\nIf it persists, please contact support.");
      }
    } catch (e) {
      logger.d(e);
      showErrorToast("An unknown error prevents us from continuing. If it persists, please contact support.");
    }
  }
}

/// IAP Plan
class IapPlan {
  final String id, name;

  IapPlan({
    required this.id,
    required this.name,
  });
}

enum IapPlanPeriod { monthly, yearly }
