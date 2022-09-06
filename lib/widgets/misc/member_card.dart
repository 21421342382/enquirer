import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/modules/explore/explore_screen_controller.dart';
import 'package:arcopen_enquirer/utils/helpers/asset_helper.dart';
import 'package:arcopen_enquirer/widgets/misc/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({
    Key? key,
    this.jobId,
    required this.memberId,
    this.saved = false,
    required this.username,
    this.clickable = true,
    required this.onTap,
    this.score,
    required this.profilePic,
    required this.hourlyRate,
    this.hidePayRate = false,
    this.hideLikeButton = false,
    this.canDelete = false,
    this.timeCompleted,
    this.applicant,
    this.deleteCallback,
  }) : super(key: key);

  final bool clickable;
  final bool saved;
  final int memberId;
  final int? jobId;
  final VoidCallback onTap;
  final String username;
  final String profilePic;
  final double? score;
  final String hourlyRate;
  final bool hidePayRate;
  final bool hideLikeButton;
  final bool canDelete;
  final Applicant? applicant;
  final String? timeCompleted;
  final Function? deleteCallback;

  @override
  Widget build(BuildContext context) {
    ImageProvider profilePicture = AssetImage(AssetHelper.getAsset(name: "avatar.png", assetType: AssetType.image));
    if (profilePic.isNotEmpty) {
      profilePicture = NetworkImage(AssetHelper.getMemberProfilePic(name: profilePic));
    }

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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (clickable) {
              onTap();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: profilePicture,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$username",
                          style: Okito.theme.textTheme.bodyText2!.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        if (timeCompleted == null && score != null)
                          RatingStars(score: score!)
                        else
                          Text(
                            "completed ${timeCompleted ?? ''}",
                            style: Okito.theme.textTheme.bodyText2!.copyWith(
                              fontSize: 10.0,
                              color: ColorConstants.greyColor,
                            ),
                          )
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!hidePayRate) ...[
                      RichText(
                        text: TextSpan(
                          text: hourlyRate,
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
                      SizedBox(height: 5),
                    ],
                    if (!hideLikeButton)
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorConstants.greyColor),
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (!saved) {
                              ExploreScreenController.shared.saveMember(memberId);
                            }
                          },
                          icon: Icon(
                            PhosphorIcons.heart,
                            size: 12,
                            color: ColorConstants.greyColor,
                          ),
                        ),
                      ),
                    if (canDelete)
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorConstants.greyColor),
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (deleteCallback != null) {
                              deleteCallback!();
                            }
                          },
                          icon: Icon(
                            PhosphorIcons.trash,
                            size: 12,
                            color: ColorConstants.greyColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
