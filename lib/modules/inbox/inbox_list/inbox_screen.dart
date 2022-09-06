import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/core/models/message.dart';
import 'package:arcopen_enquirer/modules/inbox/inbox_list/inbox_list_controller.dart';
import 'package:arcopen_enquirer/utils/helpers/asset_helper.dart';
import 'package:arcopen_enquirer/utils/inbox/inbox_card.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:arcopen_enquirer/widgets/states/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      InboxListController.shared.getInboxList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OkitoBuilder(
      controller: InboxListController.shared,
      builder: () {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "ALL MESSAGES",
                  style: Okito.theme.textTheme.bodyText2!.copyWith(
                    fontSize: 10.0,
                    letterSpacing: 1.3,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.greyColor,
                  ),
                ),
                PageSkeleton(
                  controller: InboxListController.shared,
                  retryCallback: InboxListController.shared.getInboxList,
                  child: InboxListController.shared.messages.isEmpty
                      ? EmptyState(
                          stateType: StateType.message,
                        )
                      : ListView.builder(
                          itemCount: InboxListController.shared.messages.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final Message message = InboxListController.shared.messages[index];
                            late ImageProvider userProfilePicture;

                            if (message.profilePic.isNotEmpty) {
                              userProfilePicture = NetworkImage(AssetHelper.getEnquirerProfilePic(name: message.profilePic));
                            } else {
                              userProfilePicture = AssetImage(AssetHelper.getAsset(name: "avatar.png"));
                            }
                            return InboxCard(
                              description: message.message,
                              sentAt: message.date,
                              title: message.sentTo,
                              userPicture: userProfilePicture,
                              onTap: () {
                                Okito.pushNamed(KRoutes.inboxDetailsRoute, arguments: {
                                  "message": message,
                                });
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
