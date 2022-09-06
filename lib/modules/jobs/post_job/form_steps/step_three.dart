import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/modules/jobs/post_job/create_job_controller.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class StepThree extends StatefulWidget {
  const StepThree({
    Key? key,
    required this.onNextButtonTapped,
    required this.onSaveDraftsTapped,
  }) : super(key: key);

  final Function onNextButtonTapped;
  final Function onSaveDraftsTapped;

  @override
  _StepThreeState createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CreateJobController jobController = CreateJobController();
  final List<Map<String, dynamic>> jobTypes = [
    {
      "name": "Contract",
      "description": "More than 30hrs/week and 1 month",
      "icon": PhosphorIcons.calendar_blank,
    },
    {
      "name": "Temporary",
      "description": "Less than 30hrs/week and 1 month",
      "icon": PhosphorIcons.clock_fill,
    }
  ];
  String? jobType;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      jobController.jobType = jobTypes.first["name"];
      setState(() {
        jobType = jobTypes.first["name"];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      offset: Offset(0, 1),
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ...jobTypes.map<Widget>((e) {
                      final bool isSelected = e["name"] == jobType;
                      final activeColor = Okito.theme.primaryColor;
                      return Container(
                        color: isSelected
                            ? activeColor.withOpacity(0.1)
                            : Colors.white,
                        child: RadioListTile<String>(
                          value: e["name"]!,
                          groupValue: jobType,
                          onChanged: (value) {
                            jobController.jobType = value!;
                            setState(() {
                              jobType = value;
                            });
                          },
                          title: Row(
                            children: [
                              Icon(
                                e["icon"] as IconData,
                                size: 22,
                                color: isSelected
                                    ? activeColor
                                    : ColorConstants.greyColor,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    e["name"]!,
                                    style: Okito.theme.textTheme.bodyText2!
                                        .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(e["description"]!),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            KTextField.soft(
              label: "BUDGET",
              controller: jobController.budgetController,
              validator: (value) {
                return jobController.validateRequired(
                    fieldName: "budget", value: value);
              },
            ),
            SizedBox(height: 20),
            KTextField.soft(
              label: "EMERGENCY RATE",
              controller: jobController.emergencyRateController,
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: KButton.outlined(
                    onPressed: () {
                      widget.onSaveDraftsTapped();
                    },
                    title: "SAVE TO DRAFTS",
                    color: Okito.theme.primaryColor,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: KButton.outlined(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onNextButtonTapped();
                      }
                    },
                    title: "NEXT",
                    color: Okito.theme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
