import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/core/models/message.dart';
import 'package:arcopen_enquirer/modules/inbox/inbox_details_manager.dart';
import 'package:arcopen_enquirer/utils/helpers/asset_helper.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class InboxDetailsScreen extends StatefulWidget {
  const InboxDetailsScreen({Key? key}) : super(key: key);

  @override
  _InboxDetailsScreenState createState() => _InboxDetailsScreenState();
}

class _InboxDetailsScreenState extends State<InboxDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      InboxDetailsController.shared.loadChats();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OkitoBuilder(
      controller: InboxDetailsController.shared,
      builder: () {
        final InboxDetailsController controller = InboxDetailsController.shared;
        final Message message = Okito.arguments["message"];
        late ImageProvider userProfilePicture;

        if (message.profilePic.isNotEmpty) {
          userProfilePicture = NetworkImage(AssetHelper.getMemberProfilePic(name: message.profilePic));
        } else {
          userProfilePicture = AssetImage(AssetHelper.getAsset(name: "avatar.png"));
        }
        return Scaffold(
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  if (controller.state == LoadingState.loading)
                    CircularProgressIndicator()
                  else
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              PhosphorIcons.caret_left,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Okito.pop();
                            },
                          ),
                          CircleAvatar(
                            backgroundImage: userProfilePicture,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.receiver,
                                  style: Okito.theme.textTheme.bodyText2!.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(
                                      PhosphorIcons.map_pin,
                                      size: 12,
                                      color: ColorConstants.greyColor,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "KITCHENER",
                                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                                        fontSize: 10.0,
                                        color: ColorConstants.greyColor,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  _Line(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...InboxDetailsController.shared.messages.map((message) {
                              final service = Okito.use<AuthService>();
                              bool authUserIsSender = service.user.name == message.sender;

                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: SectionTitle(
                                      title: message.messageTime,
                                      textColor: Colors.black,
                                    ),
                                  ),
                                  _MessageBulb(
                                    message: message.message,
                                    alignment: authUserIsSender ? BulbAlignment.right : BulbAlignment.left,
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Color(0XFFF5F7FD),
        );
      },
    );
  }
}

class _MessageBulb extends StatelessWidget {
  const _MessageBulb({
    Key? key,
    this.alignment = BulbAlignment.right,
    required this.message,
  }) : super(key: key);

  final BulbAlignment alignment;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment == BulbAlignment.left ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18.0, top: 10.0),
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: alignment == BulbAlignment.left ? Color(0XFFF5F5F5) : Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 2.0,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Text(
            "$message",
            style: Okito.theme.textTheme.bodyText2!.copyWith(fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}

enum BulbAlignment { left, right }

class _Line extends StatelessWidget {
  const _Line({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1,
      decoration: BoxDecoration(
        color: ColorConstants.greyColor.withOpacity(0.5),
      ),
    );
  }
}
