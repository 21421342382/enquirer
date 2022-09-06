import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/core/models/job.dart';
import 'package:arcopen_enquirer/core/models/project.dart';
import 'package:arcopen_enquirer/modules/disputes/dispute_controller.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/forms/k_dropdown_button.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class RaiseDisputeDialog extends StatefulWidget {
  const RaiseDisputeDialog({Key? key, this.applicant, this.job}) : super(key: key);

  final Applicant? applicant;
  final Job? job;

  @override
  _RaiseDisputeDialogState createState() => _RaiseDisputeDialogState();
}

class _RaiseDisputeDialogState extends State<RaiseDisputeDialog> {
  DisputeController controller = DisputeController();

  Job? _job;
  Applicant? _applicant;

  @override
  void initState() {
    super.initState();
    _job = widget.job;
    _applicant = widget.applicant;

    if (_job == null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        controller.loadJobs();
      });
    } else {
      controller.newApplicant = _applicant;
      controller.newJob = Project(applicants: {}, applicantsArray: [], budget: "", businessName: "", city: "", companyName: "", daysRemaining: 0, jobId: "${_job!.jobId}".toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_job == null) ...[
              _DisputeContent(controller: controller),
            ] else ...[
              _DisputeContentJob(controller: controller)
            ]
          ],
        ),
      ),
    );
  }
}

class _DisputeContent extends StatefulWidget {
  const _DisputeContent({Key? key, required this.controller}) : super(key: key);

  final DisputeController controller;

  @override
  State<_DisputeContent> createState() => _DisputeContentState();
}

class _DisputeContentState extends State<_DisputeContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: OkitoBuilder(
            controller: widget.controller,
            builder: () {
              return PageSkeleton(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: KDropdownButton<Project>(
                                title: "JOB",
                                value: widget.controller.newJob,
                                onChanged: (value) {
                                  setState(() {
                                    widget.controller.newJob = value;
                                  });
                                },
                                items: widget.controller.jobs.map((e) {
                                  return DropdownMenuItem<Project>(value: e, child: Text(e.businessName));
                                }).toList(),
                              ),
                            ),
                            if (widget.controller.newJob != null) ...[
                              SizedBox(width: 10),
                              Expanded(
                                child: KDropdownButton<Applicant>(
                                  title: "Member",
                                  value: widget.controller.newApplicant,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.controller.newApplicant = value;
                                    });
                                  },
                                  items: widget.controller.newJob!.applicantsArray.map((e) {
                                    return DropdownMenuItem<Applicant>(value: e, child: Text(e.applicantName!));
                                  }).toList(),
                                ),
                              ),
                            ]
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: KTextField.soft(
                                label: "TYPE",
                                validator: (value) {
                                  return widget.controller.validateRequired(value: widget.controller.disputeType.text, fieldName: "type");
                                },
                                controller: widget.controller.disputeType,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: KTextField.soft(
                                label: "AMOUNT",
                                validator: (value) {
                                  return widget.controller.validateRequired(fieldName: "amount", value: widget.controller.amount.text);
                                },
                                controller: widget.controller.amount,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        KTextField.soft(
                          label: "DESCRIPTION",
                          controller: widget.controller.description,
                          validator: (value) {
                            return widget.controller.validateRequired(fieldName: "description", value: widget.controller.description.text);
                          },
                          minLines: 4,
                          maxLines: 4,
                        ),
                        SizedBox(height: 20),
                        KButton(
                          expanded: true,
                          onPressed: widget.controller.addDispute,
                          title: "SUBMIT",
                          color: Okito.theme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  controller: widget.controller,
                  retryCallback: widget.controller.loadJobs);
            }));
  }
}

class _DisputeContentJob extends StatefulWidget {
  const _DisputeContentJob({Key? key, required this.controller}) : super(key: key);

  final DisputeController controller;

  @override
  State<_DisputeContentJob> createState() => _DisputeContentStateJob();
}

class _DisputeContentStateJob extends State<_DisputeContentJob> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                    child: KTextField.soft(
                        label: "TYPE",
                        validator: (value) {
                          return widget.controller.validateRequired(value: widget.controller.disputeType.text, fieldName: "type");
                        },
                        controller: widget.controller.disputeType)),
                SizedBox(width: 10),
                Expanded(
                  child: KTextField.soft(
                    label: "AMOUNT",
                    validator: (value) {
                      return widget.controller.validateRequired(fieldName: "amount", value: widget.controller.amount.text);
                    },
                    controller: widget.controller.amount,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            KTextField.soft(
              label: "DESCRIPTION",
              controller: widget.controller.description,
              validator: (value) {
                return widget.controller.validateRequired(fieldName: "description", value: widget.controller.description.text);
              },
              minLines: 4,
              maxLines: 4,
            ),
            SizedBox(height: 20),
            KButton(
              expanded: true,
              onPressed: widget.controller.addDispute,
              title: "SUBMIT",
              color: Okito.theme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
