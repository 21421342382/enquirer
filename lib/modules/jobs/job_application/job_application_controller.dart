import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/core/models/fund_details.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/repositories/billing_repository.dart';
import 'package:arcopen_enquirer/utils/repositories/jobs_repository.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:okito/okito.dart';
import 'package:url_launcher/url_launcher.dart';

class JobApplicationController extends BaseController {
  static final JobApplicationController shared = JobApplicationController();
  final JobsRepository repository = JobsRepository();
  BillingRepository billingRepository = BillingRepository();

  FundDetails? fundDetails;
  String? paymentMethod;
  Applicant? applicant;

  rejectApplication(int id) {
    KLoader(message: "Decline in progress").show();
    repository.rejectApplication(id).then((value) {
      KLoader.hide();
    }).catchError((e) {
      KLoader.hide();
    });
  }

  void loadFundDetails(int id) {
    setState(() {
      state = LoadingState.loading;
    });
    repository.fundDetailsApplication(id).then((value) {
      setState(() {
        state = LoadingState.success;
      });
      fundDetails = value.fundDetails.first;
    }).catchError((e) {
      setState(() {
        state = LoadingState.failed;
      });
      print(e);
      this.showErrorToast(e ?? "failed to load data. please try later");
    });
  }

  Future<void> paymentProceed(int applicationId) async {
    if (paymentMethod == null) {
      this.showErrorToast("Please select a payment method first.");
      return;
    }

    if (paymentMethod == "stripe") {
      KLoader().show();
      await billingRepository.stripePayment(applicationId).then((value) {
        KLoader.hide();
        Okito.pop();
        _launchURL(value.url);
        Okito.pushNamed(KRoutes.homeRoute);
      }).catchError((e) {
        KLoader.hide();
        Okito.pop();
        this.showErrorToast(e.message);
      });
    } else {
      Okito.pushNamed(KRoutes.billingMethodsRoute, arguments: {"fund_details": fundDetails, "applicant": applicant});
    }
  }

  void _launchURL(String _url) async => await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
