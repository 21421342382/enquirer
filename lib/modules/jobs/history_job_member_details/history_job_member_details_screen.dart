import 'package:arcopen_enquirer/widgets/jobs/history_job_member_card.dart';
import 'package:arcopen_enquirer/widgets/misc/rating_stars.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class HistoryJobMemberDetailsScreen extends StatefulWidget {
  const HistoryJobMemberDetailsScreen({Key? key}) : super(key: key);

  @override
  _HistoryJobMemberDetailsScreenState createState() => _HistoryJobMemberDetailsScreenState();
}

class _HistoryJobMemberDetailsScreenState extends State<HistoryJobMemberDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            PhosphorIcons.caret_left,
            color: Colors.black,
          ),
          onPressed: () {
            Okito.pop();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Harry Sahir",
              style: Okito.theme.textTheme.bodyText1!.copyWith(
                color: Colors.black,
              ),
            ),
            const RatingStars(score: 3),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                SectionTitle(title: "JOBS"),
                SizedBox(height: 10),
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return HistoryJobMemberCard();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
