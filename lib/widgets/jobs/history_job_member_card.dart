import 'package:arcopen_enquirer/widgets/misc/active_ts_item.dart';
import 'package:arcopen_enquirer/widgets/misc/rating_stars.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class HistoryJobMemberCard extends StatefulWidget {
  const HistoryJobMemberCard({Key? key}) : super(key: key);

  @override
  _HistoryJobMemberCardState createState() => _HistoryJobMemberCardState();
}

class _HistoryJobMemberCardState extends State<HistoryJobMemberCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Talwar's Residency",
                  style: Okito.theme.textTheme.headline2!.copyWith(fontSize: 14.0),
                ),
                Spacer(),
                Text(
                  "Jan 16th, 2021",
                  textAlign: TextAlign.end,
                  style: Okito.theme.textTheme.headline2!.copyWith(fontSize: 14.0),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SectionTitle(
                      title: "START TIME",
                      hasBoldTitle: true,
                    ),
                    SizedBox(height: 5),
                    ActiveTSItem(title: "22 PM")
                  ],
                ),
                Column(
                  children: [
                    SectionTitle(
                      title: "END TIME",
                      hasBoldTitle: true,
                    ),
                    SizedBox(height: 5),
                    ActiveTSItem(title: "9 AM")
                  ],
                ),
                Column(
                  children: [
                    SectionTitle(
                      title: "TOTAL HOURS",
                      hasBoldTitle: true,
                    ),
                    SizedBox(height: 5),
                    ActiveTSItem(title: "10 hrs")
                  ],
                ),
                Column(
                  children: [
                    SectionTitle(
                      title: "EXTRA HOURS",
                      hasBoldTitle: true,
                    ),
                    SizedBox(height: 5),
                    ActiveTSItem(title: "9 hrs")
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("He was punctual and well behaved"),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: RatingStars(
                score: 3,
                iconSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
