import 'package:arcopen_enquirer/modules/auth/profile/profile_controller.dart';
import 'package:arcopen_enquirer/utils/helpers/input_formatters/acs_number_input_formatter.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';
import 'package:arcopen_enquirer/widgets/navigation/kp_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okito/okito.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = ProfileController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      profileController.prefillForm();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: Scaffold(
        body: SingleChildScrollView(
          child: OkitoBuilder(
            activateLifecycleForOtherControllers: true,
            controller: profileController,
            builder: () {
              return Form(
                key: profileController.formKey,
                child: Column(
                  children: [
                    KPAppBar(
                      controller: profileController,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          KTextField.soft(
                            label: "ABOUT",
                            controller: profileController.aboutController,
                            minLines: 3,
                            maxLines: 4,
                            hintText: "Write something about you.",
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: KTextField.soft(
                                  label: "REGISTRATION NO.",
                                  controller: profileController.registrationNumberController,
                                  hintText: "xxx-xxx",
                                  inputFormatters: [
                                    AcsNumberInputFormatter(
                                      mask: 'xxx-xxx',
                                      separator: '-',
                                    ),
                                  ],
                                  validator: (value) {
                                    profileController.validateRequired(fieldName: "Registration number", value: value);
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: KTextField.soft(
                                  label: "ACS REFERENCE NUMBER",
                                  controller: profileController.acsRefNumberController,
                                  hintText: "xxx-xxx-xxxx",
                                  inputFormatters: [
                                    AcsNumberInputFormatter(
                                      mask: "xxx-xxx-xxxx",
                                      separator: '-',
                                    ),
                                  ],
                                  validator: (value) {
                                    profileController.validateRequired(fieldName: "ACS Reference Number", value: value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: KTextField.soft(
                                  label: "CONTACT*",
                                  prefixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: profileController.pickPhoneCode,
                                    icon: FittedBox(
                                      child: Text("${profileController.contactDialCode}"),
                                    ),
                                  ),
                                  keybordType: TextInputType.number,
                                  controller: profileController.contactController,
                                  validator: (String? value) {
                                    return profileController.validateRequired(fieldName: "contact", value: value);
                                  },
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: KTextField.soft(
                                  label: "COMPANY CONTACT*",
                                  prefixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: profileController.pickCompanyPhoneCode,
                                    icon: FittedBox(
                                      child: Text("${profileController.companyContactDialCode}"),
                                    ),
                                  ),
                                  keybordType: TextInputType.number,
                                  controller: profileController.companyContactController,
                                  validator: (String? value) {
                                    return profileController.validateRequired(fieldName: "company contact", value: value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          KTextField.soft(
                            label: "ADRESS",
                            controller: profileController.addressController,
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: KTextField.soft(
                                  label: "CITY",
                                  controller: profileController.cityController,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: KTextField.soft(
                                  label: "POSTAL CODE",
                                  controller: profileController.postalCodeController,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: KButton.outlined(
            onPressed: profileController.createOrUpdateProfile,
            title: "DONE",
            color: Okito.theme.primaryColor,
          ),
        ),
      ),
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Okito.theme.primaryColor,
      ),
    );
  }
}
