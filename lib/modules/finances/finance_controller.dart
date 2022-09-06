import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/http/responses/finance_response.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/finance_repository.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:url_launcher/url_launcher.dart';

class FinanceController extends BaseController with ToastMixin {
  final FinanceRepository repository = FinanceRepository();
  String funded = "£0";
  List<PaidTransaction> paidTransactions = [];
  String totalJobs = "";
  String totalPaid = "£0";
  List<UnpaidTransaction> unpaidTransactions = [];

  void loadFinanceDetails() {
    setState(() {
      state = LoadingState.loading;
    });
    repository.loadFinances().then((value) {
      setState(() {
        state = LoadingState.success;
        funded = value.funded;
        paidTransactions = value.paidTransactions;
        totalJobs = value.totalJobs;
        totalPaid = value.totalPaid;
        unpaidTransactions = value.unpaidTransactions;
      });
    }).catchError((e) {
      setState(() {
        state = LoadingState.failed;
      });
    });
  }

  void downloadInvoice(int transactionId) {
    KLoader().show();
    repository.downloadInvoice(transactionId).then((value) async {
      KLoader.hide();
      if (await canLaunch(value.fileLink)) {
        launch(value.fileLink);
      } else {
        this.showErrorToast("Failed to download invoice.");
      }
    }).catchError((e) {
      KLoader.hide();
      this.showErrorToast("Failed to download invoice.");
    });
  }
}
