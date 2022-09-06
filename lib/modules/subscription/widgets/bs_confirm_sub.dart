import 'package:arcopen_enquirer/constants/app_constants.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:flutter/gestures.dart';
import 'package:okito/okito.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BSConfirmSub extends StatefulWidget {
  const BSConfirmSub({
    Key? key,
    required this.duration,
    required this.product,
  }) : super(key: key);

  final Product product;
  final PackageType duration;

  @override
  _BSConfirmSubState createState() => _BSConfirmSubState();
}

class _BSConfirmSubState extends State<BSConfirmSub> {
  late bool _hasAcceptedTerms;
  late bool _formSubmitted;

  @override
  void initState() {
    _hasAcceptedTerms = false;
    _formSubmitted = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "Purchase confirmation",
              style: Okito.theme.textTheme.headline2!.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Divider(height: 1.0),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: "You are about to subscribe to the ",
                style: Theme.of(context).textTheme.bodyText2,
                children: [
                  TextSpan(text: widget.product.title, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: " plan. This subscription "),
                  TextSpan(text: widget.duration.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: " subscription and it is automatically renewed. This operation will cost you "),
                  TextSpan(text: widget.product.priceString, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "You can cancel the subscription at any time.",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            CheckboxListTile(
              value: _hasAcceptedTerms,
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  _hasAcceptedTerms = value ?? false;
                });
              },
              contentPadding: EdgeInsets.zero,
              title: RichText(
                text: TextSpan(
                  text: "Accept ",
                  style: Theme.of(context).textTheme.bodyText2,
                  children: [
                    TextSpan(
                        text: "terms and services",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (await canLaunch(AppConstants.tosUrl)) {
                              launch(AppConstants.tosUrl);
                            }
                          }),
                  ],
                ),
              ),
            ),
            if (!_hasAcceptedTerms && _formSubmitted)
              Text(
                "You need to accept the terms of service.",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: ColorConstants.red,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            const SizedBox(height: 10),
            KButton(
              expanded: true,
              onPressed: () {
                if (!_hasAcceptedTerms) {
                  setState(() {
                    _formSubmitted = true;
                  });
                } else {
                  Okito.pop(result: true);
                }
              },
              title: "Accept",
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 10),
            KButton(
              expanded: true,
              onPressed: () {
                Okito.pop(result: false);
              },
              title: "No, i don't wish to continue",
              color: ColorConstants.greyColor,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
