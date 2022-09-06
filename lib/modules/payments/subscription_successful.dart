import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/utils/navigation/k_app_bar.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class SubscriptionSuccessfulScreen extends StatefulWidget {
  const SubscriptionSuccessfulScreen({Key? key}) : super(key: key);

  @override
  _SubscriptionSuccessfulScreenState createState() =>
      _SubscriptionSuccessfulScreenState();
}

class _SubscriptionSuccessfulScreenState
    extends State<SubscriptionSuccessfulScreen> {
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
                    "You have successfully update your subscription plan.",
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
          onPressed: () => Okito.pushNamed(KRoutes.homeRoute),
          expanded: true,
          title: "BACK HOME",
        ),
      ),
    );
  }
}
