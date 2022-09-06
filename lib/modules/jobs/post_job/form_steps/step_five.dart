import 'package:arcopen_enquirer/core/models/member.dart';
import 'package:arcopen_enquirer/modules/jobs/post_job/create_job_controller.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';
import 'package:arcopen_enquirer/widgets/misc/invite_member_card.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class StepFive extends StatefulWidget {
  StepFive({
    Key? key,
    required this.onNextButtonTapped,
    required this.onSaveDraftsTapped,
  }) : super(key: key);

  final Function onSaveDraftsTapped;
  final Function onNextButtonTapped;

  @override
  State<StepFive> createState() => _StepFiveState();
}

class _StepFiveState extends State<StepFive> {
  final TextEditingController searchController = TextEditingController();

  final CreateJobController _controller = CreateJobController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.loadMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            KTextField.circular(
              hintText: "Search",
              leading: PhosphorIcons.magnifying_glass,
              controller: searchController,
            ),
            SizedBox(height: 20),
            OkitoBuilder(
                controller: _controller,
                builder: () {
                  return PageSkeleton(
                      child: ListView.builder(
                        itemCount: _controller.members.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Member member = _controller.members[index];
                          return GestureDetector(
                            child: InviteMemberCard(
                              username: member.memberName,
                              score: member.rating,
                              onTap: () {},
                              onInviteTap: () {
                                _controller.inviteMembers(
                                    jobId: Okito.arguments['jobId'],
                                    memberId: member.memberId);
                              },
                              isInvited: _controller.invitedMembers
                                  .contains(member.memberId),
                            ),
                          );
                        },
                      ),
                      controller: _controller,
                      retryCallback: () => _controller.loadMembers());
                })
          ],
        ),
      ),
    );
  }
}
