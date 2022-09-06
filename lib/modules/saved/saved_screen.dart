import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/core/models/job.dart';
import 'package:arcopen_enquirer/core/models/saved_member.dart';
import 'package:arcopen_enquirer/modules/saved/saved_screen_controller.dart';
import 'package:arcopen_enquirer/widgets/jobs/draft_job_card.dart';
import 'package:arcopen_enquirer/widgets/misc/member_card.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:arcopen_enquirer/widgets/states/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      SavedScreenController.shared.loadData();
    });
    super.initState();
  }

  void _updateActiveIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: OkitoBuilder(
          controller: SavedScreenController.shared,
          builder: () {
            return PageSkeleton(
              controller: SavedScreenController.shared,
              retryCallback: SavedScreenController.shared.loadData,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    height: 40,
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(8.0),
                      borderWidth: 0,
                      borderColor: Okito.theme.primaryColor,
                      onPressed: (index) {
                        _updateActiveIndex(index);
                      },
                      children: [
                        Container(
                          color: _selectedIndex == 0
                              ? Okito.theme.primaryColor
                              : Colors.white,
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.center,
                          child: Text(
                            "Draft Jobs",
                            style: Okito.theme.textTheme.bodyText2!.copyWith(
                              fontSize: 12.0,
                              color: _selectedIndex == 0
                                  ? Colors.white
                                  : ColorConstants.greyColor,
                            ),
                          ),
                        ),
                        Container(
                          color: _selectedIndex == 1
                              ? Okito.theme.primaryColor
                              : Colors.white,
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.center,
                          child: Text(
                            "Saved Members",
                            style: Okito.theme.textTheme.bodyText2!.copyWith(
                              fontSize: 12.0,
                              color: _selectedIndex == 1
                                  ? Colors.white
                                  : ColorConstants.greyColor,
                            ),
                          ),
                        ),
                      ],
                      isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                    ),
                  ),
                  if (_selectedIndex == 0)
                    _DraftJobs(
                      jobs: SavedScreenController.shared.drafts,
                    ),
                  if (_selectedIndex == 1)
                    _SavedMembers(
                      members: SavedScreenController.shared.members,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DraftJobs extends StatelessWidget {
  const _DraftJobs({
    Key? key,
    required this.jobs,
  }) : super(key: key);

  final List<Job> jobs;

  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) return EmptyState(stateType: StateType.job);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        SectionTitle(title: "DRAFTS"),
        SizedBox(height: 20),
        ListView.builder(
          itemCount: jobs.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final Job job = jobs[index];
            return DraftJobCard(
              businessName:
                  job.businessName.isEmpty ? "Not defined" : job.businessName,
              location: job.city.isEmpty ? "Not defined" : job.city,
              payRate:
                  (job.budget?.isEmpty ?? true) ? "Not defined" : job.budget!,
              contractType: job.jobType.isEmpty ? "Not defined" : job.jobType,
            );
          },
        ),
      ],
    );
  }
}

class _SavedMembers extends StatelessWidget {
  const _SavedMembers({
    Key? key,
    required this.members,
  }) : super(key: key);

  final List<SavedMember> members;

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) return EmptyState(stateType: StateType.misc);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        SectionTitle(title: "SAVED"),
        SizedBox(height: 20),
        ListView.builder(
          itemCount: members.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final SavedMember member = members[index];
            return MemberCard(
              onTap: () {},
              score: member.rating,
              hourlyRate: "-",
              memberId: member.memberId,
              hidePayRate: true,
              username: member.memberName,
              profilePic: member.profilePic,
              canDelete: true,
              hideLikeButton: true,
              deleteCallback: () {
                SavedScreenController.shared
                    .removeSavedMember(instanceId: member.saveInstanceId);
              },
            );
          },
        ),
      ],
    );
  }
}
