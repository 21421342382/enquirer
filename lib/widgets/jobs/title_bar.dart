import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class TitleBar extends StatelessWidget {
  TitleBar({
    Key? key,
    this.onNext,
    this.onBack,
    required this.activeIndex,
  }) : super(key: key);

  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final actionTextStyle = Okito.theme.textTheme.bodyText2!.copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: ColorConstants.greyColor,
    );

    final titleTextStyle = Okito.theme.textTheme.bodyText2!.copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: onBack,
              child: Text(
                activeIndex == 0 ? "Cancel" : "Back",
                style: actionTextStyle,
              ),
            ),
            Text(
              "Post a job",
              style: titleTextStyle,
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: onNext,
              child: Text(
                "Next",
                style: onNext == null
                    ? actionTextStyle
                    : actionTextStyle.copyWith(
                        color: Okito.theme.primaryColor,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
