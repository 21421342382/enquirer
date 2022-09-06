import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/core/models/dispute.dart';
import 'package:arcopen_enquirer/modules/disputes/dispute_controller.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/dialogs/raise_dispute_dialog.dart';
import 'package:arcopen_enquirer/widgets/misc/dispute_card.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class DisputesScreen extends StatefulWidget {
  const DisputesScreen({Key? key}) : super(key: key);

  @override
  _DisputesScreenState createState() => _DisputesScreenState();
}

class _DisputesScreenState extends State<DisputesScreen> {
  DisputeController _controller = DisputeController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.loadDispute();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF5F7FD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: ColorConstants.greyColor,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: Okito.pop,
                        color: Colors.black,
                        icon: Icon(PhosphorIcons.caret_left_bold, size: 20),
                      ),
                      Expanded(
                        child: Text(
                          "Dispute Resolution",
                          style: Okito.theme.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 5),
                      KButton.regular(
                        title: "+ ADD DISPUTE",
                        onTap: () {
                          showDialog(
                            context: context,
                            useSafeArea: true,
                            builder: (context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Okito.pop();
                                      },
                                      iconSize: 10,
                                      icon: Icon(PhosphorIcons.x_bold),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Add dispute",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  ],
                                ),
                                content: RaiseDisputeDialog(),
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              OkitoBuilder(
                controller: _controller,
                builder: () {
                  return PageSkeleton(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          SectionTitle(title: "OPEN"),
                          SizedBox(height: 10),
                          ListView.builder(
                            itemCount: _controller.disputes.where((element) => element.active).length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Dispute dispute = _controller.disputes.where((element) => element.active).elementAt(index);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: DisputeCard(
                                  onTap: () {},
                                  createdAt: dispute.createdOn,
                                  description: dispute.description,
                                  isClosed: false,
                                  name: dispute.disputeType,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          SectionTitle(title: "RESOLVED DISPUTES"),
                          SizedBox(height: 10),
                          ListView.builder(
                            itemCount: _controller.disputes.where((element) => !element.active).length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Dispute dispute = _controller.disputes.where((element) => !element.active).elementAt(index);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: DisputeCard(
                                  onTap: () {},
                                  createdAt: dispute.createdOn,
                                  description: dispute.description,
                                  isClosed: false,
                                  name: dispute.disputeType,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    controller: _controller,
                    retryCallback: _controller.loadDispute,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
