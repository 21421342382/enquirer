import 'package:arcopen_enquirer/modules/partials/pay_body.dart';
import 'package:arcopen_enquirer/modules/payments/billing_controller.dart';
import 'package:arcopen_enquirer/utils/navigation/k_app_bar.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class BillingMethodsScreen extends StatefulWidget {
  const BillingMethodsScreen({Key? key}) : super(key: key);

  @override
  _BillingMethodsScreenState createState() => _BillingMethodsScreenState();
}

class _BillingMethodsScreenState extends State<BillingMethodsScreen> {
  BillingController _controller = BillingController();
  @override
  void initState() {
    super.initState();
    _controller.fundDetails = Okito.arguments["fund_details"];
    _controller.applicant = Okito.arguments["applicant"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: "Billing Methods",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Balance Due",
                        style: Okito.theme.textTheme.bodyText2!.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Balance amount due : ",
                              style: Okito.theme.textTheme.bodyText2!,
                              children: [
                                TextSpan(
                                  text: _controller.fundDetails?.totalPay ?? "£0.0",
                                  style: Okito.theme.textTheme.bodyText2!.copyWith(
                                    color: Okito.theme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          KButton(
                            onPressed: () {
                              _controller.fundJob();
                            },
                            title: "PAY NOW",
                            expanded: true,
                            color: Okito.theme.primaryColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              PayBody(
                onItemDeleted: (item) {},
                onItemSelected: (item) {
                  _controller.card = item!;
                },
                onItemAdded: (item) {},
                onCvvChanged: (cvv) {
                  _controller.cvv = cvv;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
