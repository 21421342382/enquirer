import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';
import 'package:arcopen_enquirer/widgets/misc/active_ts_item.dart';
import 'package:arcopen_enquirer/widgets/misc/circle.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';
import 'package:okito/okito.dart';

class JobDetailsCard extends StatefulWidget {
  const JobDetailsCard({
    Key? key,
    required this.username,
    required this.startTime,
    required this.endTime,
    this.totalHours,
    this.expandable = false,
    required this.date,
    required this.onTrailingPressed,
  }) : super(key: key);

  final String username;
  final String startTime;
  final String endTime;
  final String? totalHours;
  final String date;
  final bool expandable;
  final VoidCallback? onTrailingPressed;

  @override
  _JobDetailsCardState createState() => _JobDetailsCardState();
}

class _JobDetailsCardState extends State<JobDetailsCard> {
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black.withOpacity(0.6),
      elevation: 2.0,
      child: ExpansionTile(
        trailing: widget.onTrailingPressed == null
            ? SizedBox()
            : IconButton(
                icon: Icon(PhosphorIcons.map_pin_fill),
                color: Okito.theme.primaryColor,
                onPressed: widget.onTrailingPressed,
              ),
        tilePadding: EdgeInsets.all(12.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(
              title: widget.date,
              hasBoldTitle: true,
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(),
                    Positioned(
                      right: 0,
                      bottom: 2.5,
                      child: Circle(color: ColorConstants.greenColor, diameter: 10),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.username}",
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        text: "Clock in: ",
                        style: Okito.theme.textTheme.bodyText2!.copyWith(
                          fontSize: 10.0,
                          color: ColorConstants.greyColor,
                        ),
                        children: [
                          TextSpan(
                            text: "${DateTime.now().hour}:${DateTime.now().minute}",
                            style: Okito.theme.textTheme.bodyText2!.copyWith(
                              color: ColorConstants.greyColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        childrenPadding: !widget.expandable ? EdgeInsets.zero : const EdgeInsets.all(18.0),
        children: !widget.expandable
            ? []
            : [
                SizedBox(height: 10),
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
                        ActiveTSItem(title: "$startTime")
                      ],
                    ),
                    Column(
                      children: [
                        SectionTitle(
                          title: "END TIME",
                          hasBoldTitle: true,
                        ),
                        SizedBox(height: 5),
                        ActiveTSItem(title: "$endTime")
                      ],
                    ),
                    Column(
                      children: [
                        SectionTitle(
                          title: "TOTAL HOURS",
                          hasBoldTitle: true,
                        ),
                        SizedBox(height: 5),
                        ActiveTSItem(title: "${widget.totalHours ?? '0'}")
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Card(
                  color: ColorConstants.lightBlue,
                  child: KTextField(
                    hintText: "How was your experience ?",
                    controller: feedbackController,
                    minLines: 3,
                    maxLines: 3,
                    borderVisible: false,
                  ),
                ),
                SizedBox(height: 10),
                RatingBar(
                  rating: 3.5,
                  icon: Icon(
                    PhosphorIcons.star_fill,
                    size: 25,
                    color: ColorConstants.greyColor,
                  ),
                  starCount: 5,
                  spacing: 5.0,
                  size: 25,
                  allowHalfRating: true,
                  color: Colors.amber,
                  onRatingCallback: (value, isIndicator) {},
                ),
                SizedBox(height: 10),
                KButton(
                  onPressed: () {},
                  expanded: true,
                  title: "SUBMIT",
                  color: Okito.theme.primaryColor,
                ),
              ],
      ),
    );
  }

  String get startTime => widget.startTime.split(" ").take(4).join(" ");
  String get endTime => widget.endTime.split(" ").take(4).join(" ");
}
