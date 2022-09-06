import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/http/responses/active_job_details_response.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/mixins/dialog_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/jobs_repository.dart';

class JobDetailsController extends BaseController with DialogMixin {
  JobDetailsController._internal();
  static final JobDetailsController _singleton = JobDetailsController._internal();

  final JobsRepository _repository = JobsRepository();

  List<JobMember> members = [];
  ActiveJob? job;

  factory JobDetailsController() {
    return _singleton;
  }

  set loading(LoadingState state) {
    setState(() {
      this.state = state;
    });
  }

  @override
  void dispose() {
    members = [];
    job = null;
    super.dispose();
  }

  void loadJobDetails({required int jobId}) {
    loading = state = LoadingState.loading;
    _repository.getActiveJobDetails(jobId).then((value) {
      setState(() {
        job = value.jobDetails;
        members = [...value.activeMembers, ...value.completedMembers, ...value.inactiveMembers];
        state = LoadingState.success;
      });
    }).catchError((e) {
      loading = LoadingState.failed;
    });
  }
}
