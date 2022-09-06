import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/modules/explore/explore_screen_controller.dart';
import 'package:arcopen_enquirer/modules/jobs/job_application/job_application_controller.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/navigation/k_app_bar.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/dialogs/confirm_applicant_dialog.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';
import 'package:arcopen_enquirer/widgets/misc/member_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class JobApplicationScreen extends StatefulWidget {
  JobApplicationScreen({Key? key, this.applicant_name, this.hourly_rate, this.username, this.score, this.profilePic, this.hideLikeButton, this.clickable, this.memberId, this.saved, this.applicant}) : super(key: key);

final applicant_name ;
final hourly_rate ;
final username ;
final score ;
final profilePic ;
final hideLikeButton ;
final clickable ;
final memberId ;
final saved ;
final applicant ;

  @override
  _JobApplicationScreenState createState() => _JobApplicationScreenState();
}

class _JobApplicationScreenState extends State<JobApplicationScreen> with ToastMixin {
  Applicant? applicant;
  JobApplicationController _applicationController = JobApplicationController();

  @override
  void initState() {
    super.initState();
    applicant = Okito.arguments["applicant"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: widget.applicant_name,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              MemberCard(
                onTap: () {},
                hourlyRate: widget.hourly_rate,
                username: "${widget.username}",
                score: widget.score,
                profilePic: widget.profilePic,
                hideLikeButton: true,
                clickable: false,
                memberId: widget.memberId,
                saved: widget.saved,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text("Offer Rate"),
                  Spacer(),
                  Text("${widget.hourly_rate}/hr"),
                ],
              ),
              SizedBox(height: 20),
              if (widget.applicant_name != null)
                KTextField.soft(
                  label: "MESSAGE",
                  minLines: 5,
                  maxLines: 5,
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.applicant_name != null)
              KButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    useSafeArea: true,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Okito.pop();
                              },
                              child: Icon(PhosphorIcons.x_bold, size: 15),
                            ),
                            Expanded(
                              child: Text(
                                "Fund job for ${widget.applicant_name}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                        content: ConfirmApplicantDialog(applicant: widget.applicant),
                      );
                    },
                  );
                },
                title: "CONFIRM",
                color: ColorConstants.greenColor,
                expanded: true,
              ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: KButton(
                    onPressed: () {
                      if (widget.memberId != null) {
                        ExploreScreenController.shared.saveMember(widget.memberId);
                      }
                    },
                    title: "Save member",
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                if (widget.applicant_name != null) ...[
                  SizedBox(width: 10),
                  Expanded(
                    child: KButton.outlined(
                      onPressed: () => _applicationController.rejectApplication(widget.memberId),
                      title: "DECLINE",
                      color: ColorConstants.red,
                    ),
                  ),
                ]
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
