import 'package:flutter/material.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key? key,
    this.stateType = StateType.job,
  }) : super(key: key);

  final StateType stateType;

  Widget _buildIllustration() {
    switch (stateType) {
      case StateType.job:
        return Image.asset("assets/images/11136.png");
      case StateType.message:
        return Image.asset("assets/images/inbox.png");
      case StateType.finance:
        return Image.asset("assets/images/11136-1.png");
      case StateType.misc:
        return Image.asset("assets/images/11136.png");
    }
  }

  Widget _buildTitle() {
    final style = Okito.theme.textTheme.headline2!.copyWith(
      fontSize: 16.0,
    );
    switch (stateType) {
      case StateType.job:
        return Text(
          "No jobs found",
          style: style,
        );
      case StateType.message:
        return Text(
          "No messages yet !",
          style: style,
        );
      case StateType.finance:
        return Text(
          "No Transactions found",
          style: style,
        );
      case StateType.misc:
        return Text(
          "No data found",
          style: style,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildIllustration(),
            SizedBox(height: 10),
            _buildTitle(),
            SizedBox(height: 10),
            Text(
              "We've found no data matching your request.",
              textAlign: TextAlign.center,
              style: Okito.theme.textTheme.bodyText2!.copyWith(
                color: ColorConstants.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum StateType {
  job,
  misc,
  message,
  finance,
}
