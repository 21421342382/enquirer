import 'dart:io';

import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/core/models/dispute.dart';
import 'package:arcopen_enquirer/core/models/project.dart';
import 'package:arcopen_enquirer/http/requests/add_dispute_request.dart';
import 'package:arcopen_enquirer/modules/jobs/job_listing/job_listings_controller.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/mixins/dialog_mixin.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/jobs_repository.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class DisputeController extends BaseController with ToastMixin, DialogMixin {
  final JobsRepository repository = JobsRepository();
  final JobsListingsController jobController = JobsListingsController();

  List<Dispute> disputes = [];
  List<Project> jobs = [];

  TextEditingController description = TextEditingController();
  TextEditingController disputeType = TextEditingController();
  TextEditingController amount = TextEditingController();

  Project? newJob;
  Applicant? newApplicant;

  final formKey = GlobalKey<FormState>();

  void loadDispute() {
    setState(() {
      state = LoadingState.loading;
    });
    repository.getDisputeJobs().then((value) {
      setState(() {
        state = LoadingState.success;
        disputes = value.disputes;
      });
    }).catchError((e) {
      setState(() {
        state = LoadingState.failed;
      });
    });
  }

  void addDispute() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    late String memberDeviceId;
    if (Platform.isAndroid) {
      memberDeviceId = (await deviceInfo.androidInfo).androidId;
    } else if (Platform.isIOS) {
      memberDeviceId = (await deviceInfo.iosInfo).identifierForVendor;
    } else {
      memberDeviceId = "unknow";
    }

    if (newApplicant == null || newJob == null) {
      this.showNotification("Select job and member before submit");
    } else if (formKey.currentState!.validate()) {
      KLoader().show();
      repository
          .addDispute(
              request: AddDisputeRequest(
                  disputeType: disputeType.text,
                  description: description.text,
                  jobId: newJob!.jobId,
                  memberDeviceId: memberDeviceId,
                  amount: amount.text,
                  memberId: newApplicant!.memberId ?? 98))
          .then((value) {
        KLoader.hide();
        Okito.pop(result: true);
      }).catchError((e) {
        KLoader.hide();
        this.showErrorToast(e);
      });
    }
  }

  loadJobs() async {
    try {
      setState(() {
        state = LoadingState.loading;
      });
      await repository.getPastJobs().then((value) {
        setState(() {
          state = LoadingState.success;
        });
        jobs = value.pastProjects;
      });
    } catch (e) {
      setState(() {
        state = LoadingState.failed;
      });
      this.showErrorToast("Failed to load data. Please try again later.");
    }
  }
}
