import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/widgets/misc/k_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class DraftJobCard extends StatelessWidget {
  const DraftJobCard({
    Key? key,
    required this.businessName,
    required this.location,
    required this.contractType,
    required this.payRate,
  }) : super(key: key);

  final String businessName;
  final String location;
  final String contractType;
  final String payRate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 2.0,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$businessName",
                  style: Okito.theme.textTheme.bodyText1!.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "$contractType",
                  style: Okito.theme.textTheme.bodyText2!.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.greyColor,
                  ),
                ),
                SizedBox(height: 10),
                KChip(
                  title: location,
                  boldText: true,
                  icon: PhosphorIcons.map_pin,
                  circularCorners: true,
                  hasShadow: false,
                  color: Okito.theme.primaryColor.withOpacity(0.3),
                  textColor: Okito.theme.primaryColor,
                  onTap: () {},
                ),
              ],
            ),
            Spacer(),
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: payRate,
                    style: Okito.theme.textTheme.bodyText2!.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Okito.theme.primaryColor,
                    ),
                    children: [
                      TextSpan(
                        text: "/hr",
                        style: Okito.theme.textTheme.bodyText2!.copyWith(
                          color: ColorConstants.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
