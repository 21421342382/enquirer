import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/http/responses/history_job_details_response.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/repositories/jobs_repository.dart';

class HistoryJobDetailsController extends BaseController {
  final JobsRepository repository = JobsRepository();
  HistoryJob? job;
  List<HiredMember> members = [];
  String totalAmount = "0";
  double totalHours = 0.0;

  loadJobDetails(int id) {
    loadingState = LoadingState.loading;
    repository.getPastJobDetails(id).then((value) {
      job = value.jobDetails;
      members = value.hiredMembers;
      totalAmount = value.totalAmount;
      totalHours = value.totalHours;
      loadingState = LoadingState.success;
    }).catchError((e) {
      loadingState = LoadingState.failed;
    });
  }
}
