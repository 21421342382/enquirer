import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/project.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/repositories/jobs_repository.dart';

class JobsListingsController extends BaseController {
  static final JobsListingsController shared = JobsListingsController();
  final JobsRepository repository = JobsRepository();

  List<Project> postedJobs = [];
  List<Project> activeJobs = [];
  List<Project> pastJobs = [];

  loadData() async {
    try {
      setState(() {
        state = LoadingState.loading;
      });
      await this._loadActiveJobs();
      await this._loadPastJobs();
      await this._loadPostedJobs();
      setState(() {
        state = LoadingState.success;
      });
    } catch (e) {
      setState(() {
        state = LoadingState.failed;
      });
      this.showErrorToast("Failed to load data. Please try again later.");
    }
  }

  Future<void> _loadPostedJobs() async {
    postedJobs = (await repository.getPostedJobs()).postedProjects;
    setState(() {});
  }

  Future<void> _loadActiveJobs() async {
    activeJobs = (await repository.getActiveJobs()).activeProjects;
    setState(() {});
  }

  Future<void> _loadPastJobs() async {
    pastJobs = (await repository.getPastJobs()).pastProjects;
    setState(() {});
  }
}
