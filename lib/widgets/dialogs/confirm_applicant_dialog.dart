import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/modules/jobs/job_application/job_application_controller.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/finances/detail_item.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class ConfirmApplicantDialog extends StatefulWidget {
  const ConfirmApplicantDialog({Key? key, this.applicant}) : super(key: key);

  final Applicant? applicant;

  @override
  _ConfirmApplicantDialogState createState() => _ConfirmApplicantDialogState();
}

class _ConfirmApplicantDialogState extends State<ConfirmApplicantDialog> {
  final JobApplicationController controller = JobApplicationController();

  @override
  void initState() {
    super.initState();
    controller.applicant = widget.applicant;
    if (controller.applicant!.applicationId != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        controller.loadFundDetails(controller.applicant!.applicationId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OkitoBuilder(
      controller: controller,
      builder: () => PageSkeleton(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  controller.applicant!.profilePic.toString(),
                  style: Okito.theme.textTheme.bodyText2!.copyWith(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.greenColor,
                  ),
                ),
              ),
              DetailItem(
                title: "Standard Pay per hour",
                value: "${controller.fundDetails?.payPerHour}",
                boldValue: true,
              ),
              DetailItem(
                title: "AOS Standard addition per hour",
                value: "${controller.fundDetails?.aosStandard}",
                boldValue: true,
              ),
              DetailItem(
                title: "AOS One of Misc Payment",
                value: "${controller.fundDetails?.aosOneOff}",
                boldValue: true,
              ),
              DetailItem(
                title: "Total Expected Hours",
                value: "${controller.fundDetails?.totalExpected}",
                boldTitle: true,
                boldValue: true,
              ),
              DetailItem(
                title: "Total Pay",
                value: "${controller.fundDetails?.totalPay}",
                boldTitle: true,
                boldValue: true,
              ),
              DetailItem(
                title: "Admin charge @ \$1.5/hr",
                value: "${controller.fundDetails?.adminCharges}",
              ),
              DetailItem(
                title: "Bidding Fees @ \$0.1/hr",
                value: "${controller.fundDetails?.biddingFees}",
              ),
              DetailItem(
                title: "Subtotal",
                value: "${controller.fundDetails?.subTotal}",
                boldValue: true,
              ),
              Text(
                "Additions",
                style: Okito.theme.textTheme.bodyText2!.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              DetailItem(
                title: "*AOS Account Refunds",
                value: "${controller.fundDetails?.aosAccountRefund}",
                boldValue: true,
              ),
              DetailItem(
                title: "VAT @ 20%",
                value: "${controller.fundDetails?.aosAccountRefund}",
                boldValue: true,
              ),
              DetailItem(
                title: "Net Pay",
                value: "${controller.fundDetails?.totalPay}",
                boldValue: true,
                boldTitle: true,
              ),
              KButton(
                onPressed: () {
                  Okito.pop();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                    builder: (context) {
                      return _PaymentMethod(controller: controller);
                    },
                  );
                },
                title: "FUND NOW",
                expanded: true,
                color: Okito.theme.primaryColor,
              ),
            ],
          ),
        ),
        controller: controller,
        retryCallback: () => controller.loadFundDetails(controller.applicant!.applicationId!),
      ),
    );
  }
}

class _PaymentMethod extends StatefulWidget {
  _PaymentMethod({Key? key, required this.controller}) : super(key: key);
  final JobApplicationController controller;

  @override
  State<_PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<_PaymentMethod> {
  final paymentMethods = ["stripe", "card"];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "Fund job with",
              style: Okito.theme.textTheme.bodyText2!.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Wrap(
            children: [
              ...paymentMethods.map<Widget>(
                (e) {
                  return RadioListTile<String>(
                    value: e,
                    groupValue: widget.controller.paymentMethod,
                    title: Text(e),
                    onChanged: (value) {
                      setState(() {
                        widget.controller.paymentMethod = value;
                      });
                    },
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: KButton(
              color: ColorConstants.greenColor,
              onPressed: () => widget.controller.paymentProceed(widget.controller.applicant!.applicationId!),
              expanded: true,
              title: "PROCEED",
            ),
          ),
        ],
      ),
    );
  }
}
