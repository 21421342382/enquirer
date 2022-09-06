import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/member.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/jobs_repository.dart';
import 'package:arcopen_enquirer/utils/repositories/members_repository.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:flutter/cupertino.dart';

class ExploreScreenController extends BaseController with ToastMixin {
  static final ExploreScreenController shared = ExploreScreenController();

  final TextEditingController searchController = TextEditingController();
  final MembersRepository repository = MembersRepository();
  final JobsRepository _jobsRepository = JobsRepository();

  List<Member> allMembers = [];
  List<Member> topRatedMembers = [];

  void saveMember(int id) {
    final index = allMembers.indexWhere((element) => element.memberId == id);
    Member newMemberInstance = allMembers[index];
    if (newMemberInstance.saved) {
      showWarningToast("The member has already been saved.");
      return;
    }
    KLoader().show();
    _jobsRepository.saveMember(memberId: id).then((value) {
      newMemberInstance.saved = true;
      allMembers[index] = newMemberInstance;
      setState(() {});
      showSuccessToast("Member saved successfully.");
    }).catchError((e) {
      this.showErrorToast(e.message);
    }).whenComplete(() => KLoader.hide());
  }

  void loadMembers() {
    setState(() {
      state = LoadingState.loading;
    });
    repository.exploreMembers().then((value) {
      setState(() {
        allMembers = value.allMembers;
        topRatedMembers = value.highRated;
        state = LoadingState.success;
      });
    }).catchError((e) {
      setState(() {
        state = LoadingState.failed;
      });
    });
  }
}
