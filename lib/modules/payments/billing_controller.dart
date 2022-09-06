import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/core/models/fund_details.dart';
import 'package:arcopen_enquirer/core/models/k_card.dart';
import 'package:arcopen_enquirer/http/requests/billing_request.dart';
import 'package:arcopen_enquirer/utils/mixins/dialog_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/billing_repository.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:okito/okito.dart';

class BillingController extends BaseController with DialogMixin {
  BillingController._internal();
  static final BillingController _singleton = BillingController._internal();

  factory BillingController() {
    return _singleton;
  }

  BillingRepository repository = BillingRepository();

  KCard? card;
  String? cvv;
  FundDetails? fundDetails;
  Applicant? applicant;

  @override
  void dispose() {
    card = null;
    cvv = "";
    super.dispose();
  }

  void fundJob() {
    if (this.card == null) {
      this.showErrorToast("You need to choose a payment method first.");
      return;
    } else if (this.cvv == null || (this.cvv?.isEmpty ?? true)) {
      this.showErrorToast("Please enter the cvv");
      return;
    } else {
      KLoader().show();
      repository
          .cardPayment(
              request: BillingRequest(
                  accountRefund: fundDetails!.aosAccountRefund,
                  additionPerHour: fundDetails!.payPerHour,
                  adminCharges: fundDetails!.adminCharges,
                  applicationId: applicant!.applicationId!,
                  biddingFees: fundDetails!.biddingFees,
                  cardNumber: card!.cardNumber,
                  cvv: cvv!,
                  expMonth: card!.expiryDate.split("/").first,
                  expYear: card!.expiryDate.split("/").last,
                  miscPayment: fundDetails!.aosOneOff.toString(),
                  netPayable: fundDetails!.netPayable,
                  totalPay: fundDetails!.totalPay))
          .then((value) {
        KLoader.hide();
        Okito.pushNamed(KRoutes.paymentSuccessfulRoute);
      }).catchError((e) {
        KLoader.hide();
        this.showErrorToast(e.message);
      });
    }
  }
}
