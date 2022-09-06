import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/core/models/project.dart';
import 'package:arcopen_enquirer/modules/jobs/posted_job/posted_job_details_controller.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';
import 'package:arcopen_enquirer/widgets/misc/member_card.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:arcopen_enquirer/widgets/navigation/expanded_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';
import 'package:readmore/readmore.dart';

import '../job_application/job_application_screen.dart';

class PostedJobDetailsScreen extends StatefulWidget {
  const PostedJobDetailsScreen({Key? key}) : super(key: key);

  @override
  _PostedJobDetailsScreenState createState() => _PostedJobDetailsScreenState();
}

class _PostedJobDetailsScreenState extends State<PostedJobDetailsScreen> {
  Project? job;
  PostedJobDetailsController _jobDetailsController = PostedJobDetailsController();

  @override
  void initState() {
    job = Okito.arguments["job"];
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _jobDetailsController.loadJobDetails(job!.jobId);
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
                child: Column(children: [
                  ExpandedAppBar(
                    company: _jobDetailsController.job?.companyName ?? "Loading...",
                    jobTitle: _jobDetailsController.job?.businessName ?? "Loading...",
                    duration: "${_jobDetailsController.job?.daysRemaining ?? 0} Days",
                    type: _jobDetailsController.job?.jobType ?? "Loading...",
                    location: job?.city ?? "Loading...",
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(title: "DESCRIPTION"),
                        SizedBox(height: 10),
                        ReadMoreText(
                          _jobDetailsController.job?.jobDescription ?? "Loading...",
                          trimLines: 2,
                          colorClickableText: Okito.theme.primaryColor,
                          style: TextStyle(color: Colors.black),
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        KTextField.soft(
                          label: "JOB TYPE",
                          hintText: _jobDetailsController.job?.jobType.toString(),
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        KTextField.soft(
                          label: "BUDGET",
                          hintText: _jobDetailsController.job?.budget.toString(),
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: KTextField.soft(
                                label: "START DATE",
                                hintText: _jobDetailsController.job?.shiftStartDate.toString(),
                                readOnly: true,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: KTextField.soft(
                                label: "END DATE",
                                hintText: _jobDetailsController.job?.shiftEndDate.toString(),
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: KTextField.soft(
                                label: "START TIME",
                                readOnly: true,
                                hintText: _jobDetailsController.job?.shiftStartTime.toString(),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: KTextField.soft(
                                label: "END TIME",
                                hintText: _jobDetailsController.job?.shiftEndTime.toString(),
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SectionTitle(title: "APPLICANTS"),
                        SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _jobDetailsController.applicants.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Applicant applicant = _jobDetailsController.applicants[index];
                            return MemberCard(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => JobApplicationScreen(
                                        applicant_name : applicant.applicantName,
                                        hourly_rate: applicant.hourlyRate,
                                        username: applicant.applicantName,
                                        score: applicant.rating,
                                        profilePic: applicant.profilePic,
                                        memberId: applicant.memberId,
                                        saved: applicant.saved,
                                        applicant: applicant,
                                    )));
                                },
                              username: applicant.applicantName!,
                              score: applicant.rating ?? 0,
                              hideLikeButton: true,
                              memberId: applicant.memberId!,
                              applicant: applicant,
                              jobId: job!.jobId,
                              hourlyRate: applicant.hourlyRate ?? "£0",
                              profilePic: applicant.profilePic!,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ]),
                controller: _jobDetailsController,
                retryCallback: () => _jobDetailsController.loadJobDetails(job!.jobId),
              );
            },
          ),
        ),
      ),
    );
  }
}
