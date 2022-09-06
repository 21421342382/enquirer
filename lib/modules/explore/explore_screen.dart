import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/core/models/member.dart';
import 'package:arcopen_enquirer/modules/explore/explore_screen_controller.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';
import 'package:arcopen_enquirer/widgets/misc/k_chip.dart';
import 'package:arcopen_enquirer/widgets/misc/member_card.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:arcopen_enquirer/widgets/misc/top_rated_member_card.dart';
import 'package:arcopen_enquirer/widgets/states/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

import '../jobs/job_application/job_application_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ExploreScreenController.shared.loadMembers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OkitoBuilder(
            controller: ExploreScreenController.shared,
            builder: () {
              return PageSkeleton(
                retryCallback: ExploreScreenController.shared.loadMembers,
                controller: ExploreScreenController.shared,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          KTextField.circular(
                            hintText: "Search",
                            leading: PhosphorIcons.magnifying_glass,
                            controller: ExploreScreenController.shared.searchController,
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            children: [
                              KChip(
                                title: "Location",
                                icon: PhosphorIcons.map_pin_fill,
                                onTap: () {
                                  Okito.pushNamed(KRoutes.locationFilterRoute);
                                },
                              ),
                              const SizedBox(width: 10),
                              KChip(
                                title: "Filter",
                                icon: PhosphorIcons.funnel_fill,
                                onTap: () {
                                  Okito.pushNamed(KRoutes.filterRoute);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    if (ExploreScreenController.shared.topRatedMembers.isNotEmpty) ...[
                      const SectionTitle(title: "HIGH RATED"),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...ExploreScreenController.shared.topRatedMembers.map<Widget>((member) {
                              return TopRatedMemberCard(
                                username: member.memberName,
                                score: member.rating,
                                profilePic: member.profilePic,
                                location: member.city,
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => JobApplicationScreen(
                                        applicant_name : member.memberName,
                                        hourly_rate: member.perHourRate,
                                        username: member.memberId,
                                        score: member.rating,
                                        profilePic: member.profilePic,
                                        memberId: member.memberId,
                                        saved: member.saved,
                                        applicant: member,
                                      )));
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                    if (ExploreScreenController.shared.allMembers.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            SectionTitle(title: "ALL MEMBERS"),
                            const SizedBox(height: 10),
                            ListView.builder(
                              itemCount: ExploreScreenController.shared.allMembers.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final Member member = ExploreScreenController.shared.allMembers[index];
                                return MemberCard(
                                  hourlyRate: member.perHourRate,
                                  username: member.memberName,
                                  memberId: member.memberId,
                                  score: member.rating,
                                  profilePic: member.profilePic,
                                  saved: member.saved,
                                  onTap: () {
                                    //Okito.pushNamed(KRoutes.jobApplicationRoute, arguments: {"applicant": Applicant.fromMember(member)});
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => JobApplicationScreen(
                                          applicant_name : member.memberName,
                                          hourly_rate: member.perHourRate,
                                          username: member.memberId,
                                          score: member.rating,
                                          profilePic: member.profilePic,
                                          memberId: member.memberId,
                                          saved: member.saved,
                                          //applicant: "${member}",
                                        )));
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      )
                    else
                      const EmptyState(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
