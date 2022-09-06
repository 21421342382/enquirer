import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/job.dart';
import 'package:arcopen_enquirer/core/models/saved_member.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/jobs_repository.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';

class SavedScreenController extends BaseController with ToastMixin {
  static final SavedScreenController shared = SavedScreenController();
  final JobsRepository repository = JobsRepository();

  List<SavedMember> members = [];
  List<Job> drafts = [];

  void loadData() {
    setState(() {
      state = LoadingState.loading;
    });
    repository.getSavedDetails().then((value) {
      setState(() {
        state = LoadingState.success;
        drafts = value.drafts;
        members = value.savedMembers;
      });
    }).catchError((e) {
      setState(() {
        state = LoadingState.failed;
      });
      this.showErrorToast(e.message);
    });
  }

  void removeSavedMember({required int instanceId}) {
    KLoader().show();
    repository.removeSavedMember(id: instanceId).then((value) {
      KLoader.hide();
      setState(() {
        this.members = value.savedMembers;
      });
      this.showSuccessToast(value.success);
    }).catchError((e) {
      KLoader.hide();
      this.showErrorToast("Failed to remove member from saved list. Please try again later.");
    });
  }
}
