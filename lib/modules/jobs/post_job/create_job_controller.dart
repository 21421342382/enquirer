import 'dart:convert';
import 'dart:io';

import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/core/models/member.dart';
import 'package:arcopen_enquirer/http/requests/create_job_request.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/utils/mixins/dialog_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/jobs_repository.dart';
import 'package:arcopen_enquirer/utils/repositories/members_repository.dart';
import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:okito/okito.dart';

class CreateJobController extends BaseController with DialogMixin {
  CreateJobController._internal();
  static final CreateJobController _singleton = CreateJobController._internal();

  factory CreateJobController() {
    return _singleton;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isDraft = false;
  String? jobCategory;
  String? shiftType;
  String? jobType;
  String? city = Okito.use<AuthService>().profile?.city;
  String? fileName = "";
  String? contract;

  List<Member> members = [];
  List<int> invitedMembers = [];
  final MembersRepository membersRepository = MembersRepository();

  final TextEditingController budgetController = TextEditingController();
  final TextEditingController emergencyRateController = TextEditingController();
  final TextEditingController businessController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController vacanciesCountController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController contractController = TextEditingController();

  final JobsRepository _repository = JobsRepository();

  @override
  dispose() {
    jobCategory = "";
    jobType = "";
    fileName = "";
    contract = "";
    budgetController.clear();
    emergencyRateController.clear();
    businessController.clear();
    descriptionController.clear();
    vacanciesCountController.clear();
    startDateController.clear();
    endDateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    addressController.clear();
    locationController.clear();
    contractController.clear();
    super.dispose();
  }

  void inviteMembers({required int memberId, required int jobId}) {
    KLoader().show();
    Map<String, dynamic> params = {"guard_id": memberId, "job_id": jobId};
    _repository.inviteFriends(params: params).then((value) {
      KLoader.hide();
      if (!invitedMembers.contains(memberId)) {
        setState(() {
          invitedMembers.add(memberId);
        });
      }
      this.showSuccessToast("invitation sent");
    }).catchError((e) {
      KLoader.hide();
      showNotification(e.message);
    });
  }

  Future<void> saveJob() async {
    KLoader().show();
    final CreateJobRequest _createJobRequest = CreateJobRequest(
      address: addressController.text,
      budget: budgetController.text,
      businessName: businessController.text,
      city: city,
      contract: contract ?? contractController.text,
      fileName: fileName,
      emergencyRate: emergencyRateController.text,
      isDraft: isDraft.toString(),
      jobCategory: jobCategory,
      jobDescription: descriptionController.text,
      jobType: jobType,
      shiftEndDate: endDateController.text,
      shiftEndTime: endTimeController.text,
      shiftStartDate: startDateController.text,
      shiftStartTime: startTimeController.text,
      shiftType: shiftType,
      vacancies: vacanciesCountController.text,
    );

    _repository.createJob(request: _createJobRequest).then((value) {
      KLoader.hide();
      Okito.arguments["jobId"] = value.jobDetails.id;
      this.showSuccessToast("Job created successfully!");
      // Okito.pop(result: true);
    }).catchError((e) {
      KLoader.hide();
      print("Erreur: $e");
      showNotification(e.message);
    });
  }

  loadMembers() {
    setState(() {
      state = LoadingState.loading;
    });
    membersRepository.exploreMembers().then((value) {
      setState(() {
        state = LoadingState.success;
      });
      members = List<Member>.from(value.allMembers.map((e) => e));
    }).catchError((e) {
      setState(() {
        state = LoadingState.failed;
      });

      this.showErrorToast("Failed to load members. Please try again later.");
    });
  }

  void pickContract() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        allowedExtensions: ['pdf'],
        type: FileType.custom);

    if (result != null) {
      File file = File(result.files.single.path!);
      PlatformFile platformFile = result.files.first;
      double size = file.lengthSync() / (1024 * 1024);
      if (size > 1) {
        this.showErrorToast("File is too large. Maximum size is set to 1 Mb");
      } else {
        setState(() {
          fileName = platformFile.name;
        });
        contract = base64Encode(file.readAsBytesSync());
      }
    }
  }
}
