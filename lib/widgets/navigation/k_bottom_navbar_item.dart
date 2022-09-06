import 'package:flutter/material.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';

class KBottomNavBarItem extends StatelessWidget {
  const KBottomNavBarItem({
    Key? key,
    required this.title,
    required this.icon,
    this.isActive = false,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? Okito.theme.primaryColor : ColorConstants.greyColor,
        ),
        SizedBox(height: 5),
        Text(
          "$title",
          style: Okito.theme.textTheme.bodyText2!.copyWith(
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
            color: isActive ? Okito.theme.primaryColor : ColorConstants.greyColor,
          ),
        ),
      ],
    );
  }
}
