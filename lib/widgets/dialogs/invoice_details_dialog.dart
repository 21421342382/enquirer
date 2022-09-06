import 'package:arcopen_enquirer/core/models/finance.dart';
import 'package:arcopen_enquirer/modules/finances/finance_controller.dart';
import 'package:arcopen_enquirer/utils/helpers/asset_helper.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/finances/detail_item.dart';
import 'package:arcopen_enquirer/widgets/misc/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class InvoiceDetailsDialog extends StatefulWidget {
  const InvoiceDetailsDialog({
    Key? key,
    this.isPaid = false,
    required this.transactionId,
    required this.finance,
  }) : super(key: key);

  final bool isPaid;
  final int transactionId;
  final Finance finance;

  @override
  _InvoiceDetailsDialogState createState() => _InvoiceDetailsDialogState();
}

class _InvoiceDetailsDialogState extends State<InvoiceDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    ImageProvider userProfilePicture;
    if (widget.finance.profilePicture.isNotEmpty) {
      userProfilePicture = NetworkImage(AssetHelper.getMemberProfilePic(name: widget.finance.profilePicture));
    } else {
      userProfilePicture = AssetImage(AssetHelper.getAsset(name: "avatar.png"));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: userProfilePicture,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.finance.jobTitle,
                    style: Okito.theme.textTheme.bodyText2!.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  RatingStars(score: widget.finance.stars),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        if (widget.finance.paid) DetailItem(title: "Date Paid", value: widget.finance.date),
        DetailItem(title: "Job type", value: widget.finance.jobType),
        // DetailItem(title: "Total Hours", value: widget),
        // DetailItem(title: "Hourly Price", value: widget.finance.),
        // DetailItem(title: "Billing Period", value: "15th Jan - 16th Jan 2021"),
        DetailItem(
          title: "Total Invoice Amount",
          value: widget.finance.amount,
          boldTitle: true,
          boldValue: true,
        ),
        SizedBox(height: 20),
        // if (!widget.isPaid)
        //   KButton(
        //     expanded: true,
        //     onPressed: () {},
        //     title: "PAY NOW",
        //     color: ColorConstants.greenColor,
        //   ),
        // SizedBox(height: 10),
        if (widget.isPaid)
          KButton(
            expanded: true,
            onPressed: () {
              FinanceController().downloadInvoice(widget.transactionId);
            },
            title: "DOWNLOAD INVOICE",
            color: Okito.theme.primaryColor,
          ),
      ],
    );
  }
}
