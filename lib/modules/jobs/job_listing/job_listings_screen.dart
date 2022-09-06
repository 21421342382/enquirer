import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/core/models/project.dart';
import 'package:arcopen_enquirer/modules/jobs/job_listing/job_listings_controller.dart';
import 'package:arcopen_enquirer/modules/jobs/post_job/post_job_screen.dart';
import 'package:arcopen_enquirer/widgets/jobs/job_card.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:arcopen_enquirer/widgets/states/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class JobListingsScreen extends StatefulWidget {
  const JobListingsScreen({Key? key}) : super(key: key);

  @override
  _JobListingsScreenState createState() => _JobListingsScreenState();
}

class _JobListingsScreenState extends State<JobListingsScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      JobsListingsController.shared.loadData();
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
    return Scaffold(
      backgroundColor: ColorConstants.lightBlue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    color: _selectedIndex == 0 ? Okito.theme.primaryColor : Colors.white,
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    child: Text(
                      "Active",
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        fontSize: 12.0,
                        color: _selectedIndex == 0 ? Colors.white : ColorConstants.greyColor,
                      ),
                    ),
                  ),
                  Container(
                    color: _selectedIndex == 1 ? Okito.theme.primaryColor : Colors.white,
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    child: Text(
                      "Posted",
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        fontSize: 12.0,
                        color: _selectedIndex == 1 ? Colors.white : ColorConstants.greyColor,
                      ),
                    ),
                  ),
                  Container(
                    color: _selectedIndex == 2 ? Okito.theme.primaryColor : Colors.white,
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    child: Text(
                      "Past",
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        fontSize: 12.0,
                        color: _selectedIndex == 2 ? Colors.white : ColorConstants.greyColor,
                      ),
                    ),
                  ),
                ],
                isSelected: [_selectedIndex == 0, _selectedIndex == 1, _selectedIndex == 2],
              ),
            ),
            SizedBox(height: 20),
            OkitoBuilder(
              controller: JobsListingsController.shared,
              builder: () {
                return PageSkeleton(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitle(title: "JOB LISTINGS"),
                            if (_selectedIndex == 0) _ActiveJobs(jobs: JobsListingsController.shared.activeJobs),
                            if (_selectedIndex == 1) _PostedJobs(jobs: JobsListingsController.shared.postedJobs),
                            if (_selectedIndex == 2) _HistoryJobs(jobs: JobsListingsController.shared.pastJobs),
                          ],
                        ),
                      ),
                    ],
                  ),
                  controller: JobsListingsController.shared,
                  retryCallback: JobsListingsController.shared.loadData,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          if (_selectedIndex == 1) ...[
            FloatingActionButton(
              child: Icon(PhosphorIcons.plus),
              backgroundColor: Okito.theme.primaryColor,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  builder: (context) {
                    return PostJobScreen();
                  },
                ).then((value) {
                  if (value != null && value) {
                    JobsListingsController.shared.loadData();
                  }
                });
              },
            ),
          ]
        ],
      ),
    );
  }
}

class _ActiveJobs extends StatelessWidget {
  const _ActiveJobs({
    Key? key,
    required this.jobs,
  }) : super(key: key);

  final List<Project> jobs;

  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) return EmptyState();
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final Project job = jobs[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: JobCard(
            jobTitle: job.businessName,
            jobType: job.companyName,
            location: job.city,
            budget: job.budget ?? "Not provided",
            daysLeftCount: job.daysRemaining,
            applicants: job.applicantsArray,
            onTap: () {
              Okito.pushNamed(KRoutes.activeJobDetailsRoute, arguments: {"job": job});
            },
          ),
        );
      },
    );
  }
}

class _PostedJobs extends StatelessWidget {
  const _PostedJobs({
    Key? key,
    required this.jobs,
  }) : super(key: key);

  final List<Project> jobs;

  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) return EmptyState();
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final Project job = jobs[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: JobCard(
            jobTitle: job.businessName,
            jobType: job.companyName,
            location: job.city,
            budget: job.budget ?? "Not provided",
            daysLeftCount: job.daysRemaining,
            applicants: job.applicantsArray,
            onTap: () {
              Okito.pushNamed(KRoutes.postedJobDetailsRoute, arguments: {"job": job});
            },
          ),
        );
      },
    );
  }
}

class _HistoryJobs extends StatelessWidget {
  const _HistoryJobs({
    Key? key,
    required this.jobs,
  }) : super(key: key);

  final List<Project> jobs;

  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) return EmptyState();
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final Project job = jobs[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: JobCard(
            budget: job.budget ?? "Not provided",
            jobTitle: job.businessName,
            jobType: job.companyName,
            location: job.city,
            daysLeftCount: job.daysRemaining,
            isCompleted: true,
            applicants: job.applicantsArray,
            onTap: () {
              Okito.pushNamed(KRoutes.historyJobDetailsRoute, arguments: {
                "job": job,
              });
            },
          ),
        );
      },
    );
  }
}
