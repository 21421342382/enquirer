import 'package:flutter/material.dart';
import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/utils/extensions/build_context.dart';

PreferredSize customAppBar(BuildContext context, {required String title, Widget? trailing}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(90),
    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            SizedBox(width: 10),
            GestureDetector(
              onTap: KRouter().pop,
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black54,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '$title',
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.headline3?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            trailing ?? Container()
          ],
        ),
      ),
    ),
  );
}

String month(int value) {
  List<String> months = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

  return months[value - 1];
}

String getTotalHours(String endTime, String startTime) {
  if (endTime.isEmpty || startTime.isEmpty) return "0";
  int diffNotTreated = int.parse(endTime.split(" ").first.split(":").join("")) - int.parse(startTime.split(" ").first.split(":").join(""));

  if (diffNotTreated < 100) {
    return (diffNotTreated / 60).toStringAsPrecision(1);
  } else if (diffNotTreated < 1000) {
    return (double.parse((diffNotTreated / 60).toString()) + 60 * int.parse(diffNotTreated.toString().split("").first)).toStringAsPrecision(4);
  } else {
    return (double.parse((diffNotTreated / 60).toString()) + 60 * int.parse((diffNotTreated.toString().split("")[0] + diffNotTreated.toString().split("")[1]))).toStringAsPrecision(4);
  }
}
