import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/k_card.dart';
import 'package:arcopen_enquirer/http/requests/pay_subscription_request.dart';
import 'package:arcopen_enquirer/utils/mixins/dialog_mixin.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/subscriptions_repository.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/core/models/payment_card.dart';
import 'package:arcopen_enquirer/core/models/plan.dart';

class PaymentController extends BaseController with ToastMixin, DialogMixin {
  SubscriptionsRepository repository = SubscriptionsRepository();

  List<PaymentCard> paymentMethods = [];

  KCard? card;
  String? cvv;
  Plan? plan;
  String? billingCycle = "yearly";

  final List<String> billingCycles = ["monthly", "yearly"];

  @override
  initState() {
    plan = Okito.arguments["plan"];
    super.initState();
  }

  set setSelectedPaymentMethod(KCard card) {
    setState(() {
      this.card = card;
    });
  }

  set setSelectedBillingCycle(String cycle) {
    setState(() {
      this.billingCycle = cycle;
    });
  }

  void paySubscription() {
    if (this.card == null) {
      this.showErrorToast("You need to choose a payment method first.");
      return;
    }
    if (this.cvv == null || (this.cvv?.isEmpty ?? true)) {
      this.showErrorToast("Please enter the cvv");
      return;
    }
    if (!this.billingCycles.contains(this.billingCycle)) {
      this.showErrorToast("Unknown billing cycle");
      return;
    }

    final request = PaySubscriptionRequest(
      card: this.card!,
      plan: this.plan!,
      cycle: this.billingCycle!,
      cvv: this.cvv!,
    );
    KLoader().show();
    repository.cardSubscription(request: request).then((value) {
      KLoader.hide();
      Okito.pushNamed(KRoutes.subscriptionSuccessfulUpdate);
    }).catchError((e) {
      KLoader.hide();
      this.showErrorToast(e.message);
    });
  }
}
