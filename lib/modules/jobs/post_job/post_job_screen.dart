import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/modules/jobs/post_job/create_job_controller.dart';
import 'package:arcopen_enquirer/modules/jobs/post_job/form_steps/step_five.dart';
import 'package:arcopen_enquirer/modules/jobs/post_job/form_steps/step_four.dart';
import 'package:arcopen_enquirer/modules/jobs/post_job/form_steps/step_one.dart';
import 'package:arcopen_enquirer/modules/jobs/post_job/form_steps/step_three.dart';
import 'package:arcopen_enquirer/modules/jobs/post_job/form_steps/step_two.dart';
import 'package:arcopen_enquirer/widgets/jobs/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({Key? key}) : super(key: key);

  @override
  _PostJobScreenState createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  late int _currentIndex;
  final PageController pageController = PageController();
  final CreateJobController jobController = CreateJobController();

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OkitoBuilder(
      controller: jobController,
      activateLifecycleForOtherControllers: true,
      builder: () {
        return Container(
          decoration: BoxDecoration(
            color: ColorConstants.lightBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleBar(
                activeIndex: _currentIndex,
                onBack: () {
                  if (_currentIndex == 0) {
                    Okito.pop();
                  } else {
                    _goTo(--_currentIndex);
                  }
                },
                onNext: () {
                  if (_currentIndex == 3) {
                    jobController.saveJob().then((value) {
                      _goTo(++_currentIndex);
                    });
                  } else {
                    _goTo(++_currentIndex);
                  }
                },
              ),
              Expanded(
                child: Form(
                  key: jobController.formKey,
                  child: PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      StepOne(
                        onCategorySelected: (category) {
                          _goTo(++_currentIndex);
                          jobController.jobCategory = category.name;
                        },
                      ),
                      StepTwo(
                        onNextButtonTapped: () {
                          _goTo(++_currentIndex);
                        },
                        onSaveDraftsTapped: () {},
                      ),
                      StepThree(
                        onNextButtonTapped: () {
                          if (jobController.jobType == "Contract")
                            _goTo(++_currentIndex);
                          else {
                            jobController.saveJob().then((value) => _goTo(_currentIndex + 2));
                          }
                        },
                        onSaveDraftsTapped: () {},
                      ),
                      StepFour(
                        onDone: () {
                          jobController.saveJob().then((value) => _goTo(++_currentIndex));
                        },
                        onSaveDraftsTapped: () {},
                      ),
                      StepFive(
                        onNextButtonTapped: () {
                          _goTo(++_currentIndex);
                        },
                        onSaveDraftsTapped: () {},
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _goTo(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    setState(() {});
  }
}
