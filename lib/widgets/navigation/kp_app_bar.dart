import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/modules/auth/profile/profile_controller.dart';
import 'package:arcopen_enquirer/utils/helpers/asset_helper.dart';

class KPAppBar extends StatelessWidget with PreferredSizeWidget {
  const KPAppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final service = Okito.use<AuthService>();

    ImageProvider profilePicture = AssetImage(AssetHelper.getAsset(name: "avatar.png", assetType: AssetType.image));
    if ((service.profile?.companyLogo.isNotEmpty ?? false)) {
      profilePicture = NetworkImage(AssetHelper.getEnquirerProfilePic(name: service.profile!.companyLogo));
    }
    if (controller.profilePicFile != null) {
      profilePicture = FileImage(controller.profilePicFile!);
    }
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Okito.theme.primaryColor,
      ),
      child: Column(
        children: [
          SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Okito.pop();
                },
                icon: Icon(PhosphorIcons.caret_left_bold),
                color: Colors.white,
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: controller.pickPictureFile,
                child: CircleAvatar(
                  backgroundImage: profilePicture,
                  child: ClipRRect(borderRadius: BorderRadius.circular(60.0)),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${service.user.name}",
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(65.0);
}
