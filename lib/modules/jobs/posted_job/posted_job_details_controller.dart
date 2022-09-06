import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/core/models/job.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/repositories/jobs_repository.dart';

class PostedJobDetailsController extends BaseController {
  final JobsRepository repository = JobsRepository();
  Job? job;
  List<Applicant> applicants = [];

  loadJobDetails(int id) {
    loadingState = LoadingState.loading;
    repository.getPostedJobDetails(id).then((value) {
      job = value.jobDetails.first;
      applicants = value.applicants;
      loadingState = LoadingState.success;
    }).catchError((e) {
      loadingState = LoadingState.failed;
    });
  }
}
