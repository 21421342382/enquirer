import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/modules/jobs/post_job/create_job_controller.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class StepFour extends StatefulWidget {
  const StepFour({
    Key? key,
    this.onNextButtonTapped,
    required this.onDone,
    required this.onSaveDraftsTapped,
  }) : super(key: key);

  final VoidCallback onSaveDraftsTapped;
  final VoidCallback? onNextButtonTapped;
  final VoidCallback onDone;

  @override
  _StepFourState createState() => _StepFourState();
}

class _StepFourState extends State<StepFour> {
  CreateJobController jobController = CreateJobController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          KTextField.soft(
            label: "CONTRACT TERMS",
            minLines: 6,
            readOnly: jobController.fileName?.isNotEmpty ?? false,
            maxLines: 6,
            controller: jobController.contractController,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Divider()),
              SizedBox(width: 5),
              Text(
                "OR",
                style: Okito.theme.textTheme.bodyText2!.copyWith(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.greyColor,
                ),
              ),
              SizedBox(width: 5),
              Expanded(child: Divider()),
            ],
          ),
          SizedBox(height: 20),
          if (jobController.fileName!.isNotEmpty) ...[
            Text("Contract: ${jobController.fileName}"),
            SizedBox(height: 20),
          ],
          KButton(
            onPressed: () async {
              if (jobController.contractController.text.isEmpty) {
                jobController.pickContract();
              }
            },
            title: "UPLOAD CONTRACT",
            color: jobController.contractController.text.isEmpty ? Okito.theme.primaryColor : Colors.grey,
          ),
          Spacer(),
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
                    widget.onDone();
                  },
                  title: "DONE",
                  color: Okito.theme.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
