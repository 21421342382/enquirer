import 'dart:io';

import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/utils/mixins/toast_mixin.dart';
import 'package:arcopen_enquirer/utils/mixins/validation_mixin.dart';
import 'package:arcopen_enquirer/utils/repositories/auth_repository.dart';
import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:arcopen_enquirer/widgets/dialogs/k_loader.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:okito/okito.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:phone_code_picker/phone_code_picker.dart';

class ProfileController extends BaseController with ToastMixin, ValidationMixin {
  ProfileController._internal();
  static final ProfileController _singleton = ProfileController._internal();

  factory ProfileController() {
    return _singleton;
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? resumeFile;
  File? profilePicFile;
  String contactDialCode = "+1";

  String companyContactDialCode = "+1";
  final AuthRepository _repository = AuthRepository();

  final TextEditingController aboutController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController registrationNumberController = TextEditingController();
  final TextEditingController acsRefNumberController = TextEditingController();
  final TextEditingController companyContactController = TextEditingController();

  String? get getResumeFilename => resumeFile == null ? null : basename(resumeFile!.path);

  void prefillForm() {
    final service = Okito.use<AuthService>();
    if (service.profileExists) {
      aboutController.text = service.profile?.about ?? "";

      contactDialCode = service.profile?.contact.split("-").first ?? "";
      contactController.text = service.profile?.contact.split("-").last ?? "";

      companyContactDialCode = service.profile?.companyContact.split("-").first ?? "";
      companyContactController.text = service.profile?.companyContact.split("-").last ?? "";

      addressController.text = service.profile?.address ?? "";
      cityController.text = service.profile?.city ?? "";
      postalCodeController.text = service.profile?.postalCode ?? "";

      acsRefNumberController.text = service.profile?.acsReferenceNumber ?? "";
      registrationNumberController.text = service.profile?.registrationNumber ?? "";

      setState(() {});
    }
  }

  Future<void> pickPictureFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      profilePicFile = File(result.files.single.path!);
      setState(() {});
    }
  }

  Future<String?> _pickPhoneCode() async {
    String? dialCode;
    await showModalBottomSheet(
      context: Okito.context!,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      builder: (_) => Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(Okito.context!).viewPadding.bottom),
        child: PhoneCodePicker(
          primaryColor: Okito.theme.primaryColor,
          onSelected: (country) {
            dialCode = country.dialCode;
          },
        ),
      ),
    );
    return dialCode;
  }

  Future<void> pickPhoneCode() async {
    contactDialCode = await _pickPhoneCode() ?? "+1";
    setState(() {});
  }

  Future<void> pickCompanyPhoneCode() async {
    companyContactDialCode = await _pickPhoneCode() ?? "+1";
    setState(() {});
  }

  void createOrUpdateProfile() {
    if (formKey.currentState!.validate()) {
      if (Okito.use<AuthService>().profileExists)
        _updateProfile();
      else
        _createProfile();
    }
  }

  FormData computeFormData() {
    return FormData.fromMap({
      "about": aboutController.text,
      "registration_number": registrationNumberController.text,
      "acs_reference_number": acsRefNumberController.text,
      "contact": "$contactDialCode-${contactController.text}",
      "company_contact": "$companyContactDialCode-${companyContactController.text}",
      "postal_code": postalCodeController.text,
      "city": cityController.text,
      "address": addressController.text,
      if (profilePicFile != null) "company_logo": MultipartFile.fromFile(profilePicFile!.path),
    });
  }

  _createProfile() {
    KLoader().show();
    _repository.createProfile(data: computeFormData()).then((value) {
      KLoader.hide();
      Okito.use<AuthService>().profileExists = true;
      Okito.use<AuthService>().profile = value.profile;
      Okito.pushNamed(KRoutes.homeRoute);
    }).catchError((e) {
      this.showErrorToast(e.message);
      KLoader.hide();
    });
  }

  _updateProfile() {
    KLoader().show();
    _repository.updateProfile(data: computeFormData()).then((value) {
      KLoader.hide();
      Okito.use<AuthService>().profileExists = true;
      Okito.use<AuthService>().profile = value.profile;
      this.showSuccessToast(value.success);
    }).catchError((e) {
      this.showErrorToast(e.message);
      KLoader.hide();
    });
  }
}
