import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/core/models/project.dart';
import 'package:arcopen_enquirer/http/responses/active_job_details_response.dart';
import 'package:arcopen_enquirer/modules/jobs/job_details_controller.dart';
import 'package:arcopen_enquirer/widgets/jobs/job_details_card.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:arcopen_enquirer/widgets/navigation/expanded_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';
import 'package:readmore/readmore.dart';

class ActiveJobDetailsScreen extends StatefulWidget {
  const ActiveJobDetailsScreen({Key? key}) : super(key: key);

  @override
  _ActiveJobDetailsScreenState createState() => _ActiveJobDetailsScreenState();
}

class _ActiveJobDetailsScreenState extends State<ActiveJobDetailsScreen> {
  Project? job;
  JobDetailsController _jobDetailsController = JobDetailsController();

  @override
  void initState() {
    job = Okito.arguments["job"];
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _jobDetailsController.loadJobDetails(jobId: job!.jobId);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Okito.arguments.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: OkitoBuilder(
            controller: _jobDetailsController,
            builder: () {
              return PageSkeleton(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpandedAppBar(
                      company: _jobDetailsController.job?.companyName ?? "Loading...",
                      jobTitle: _jobDetailsController.job?.businessName ?? "Loading...",
                      duration: "",
                      type: _jobDetailsController.job?.jobType ?? "Loading...",
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitle(title: "DESCRIPTION"),
                          const SizedBox(height: 10),
                          ReadMoreText(
                            _jobDetailsController.job?.jobDescription ?? "Loading...",
                            trimLines: 2,
                            colorClickableText: Okito.theme.primaryColor,
                            trimMode: TrimMode.Line,
                            style: TextStyle(color: Colors.black),
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          SectionTitle(title: "HIRED MEMBERS"),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: ListView.builder(
                        itemCount: _jobDetailsController.members.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          JobMember applicant = _jobDetailsController.members[index];
                          return JobDetailsCard(
                            username: applicant.memberName,
                            endTime: _jobDetailsController.job!.shiftEndDate,
                            startTime: _jobDetailsController.job!.shiftStartDate,
                            date: _jobDetailsController.job!.shiftStartDate,
                            expandable: false,
                            onTrailingPressed: () {
                              Okito.pushNamed(KRoutes.activeJobMemberDetailsRoute, arguments: {"job": _jobDetailsController.job, "applicant": applicant});
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                controller: _jobDetailsController,
                retryCallback: () => _jobDetailsController.loadJobDetails(jobId: job!.jobId),
              );
            },
          ),
        ),
      ),
    );
  }
}
