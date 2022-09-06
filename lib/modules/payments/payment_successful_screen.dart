import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/utils/navigation/k_app_bar.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class PaymentSuccessfulScreen extends StatefulWidget {
  const PaymentSuccessfulScreen({Key? key}) : super(key: key);

  @override
  _PaymentSuccessfulScreenState createState() => _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: "",
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Spacer(),
                Image.asset("assets/images/tick.png"),
                SizedBox(height: 20),
                Text(
                  "Fantastic",
                  style: Okito.theme.textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    "You have successfully funded the job. A notification has been sent to the member. You can always contact the member and discuss the job with him/her.",
                    textAlign: TextAlign.center,
                    style: Okito.theme.textTheme.bodyText2!.copyWith(
                      color: ColorConstants.greyColor,
                    ),
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: KButton(
          color: Okito.theme.primaryColor,
          onPressed: () {},
          expanded: true,
          title: "CONTACT MEMBER",
        ),
      ),
    );
  }
}
