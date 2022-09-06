import 'package:arcopen_enquirer/core/models/k_card.dart';
import 'package:arcopen_enquirer/modules/partials/pay_body_controller.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';

class PayBody extends StatefulWidget {
  const PayBody({
    Key? key,
    required this.onItemDeleted,
    required this.onItemSelected,
    required this.onItemAdded,
    required this.onCvvChanged,
    this.selectable = true,
  }) : super(key: key);

  final bool selectable;
  final Function onItemDeleted;
  final Function onItemAdded;
  final Function(String) onCvvChanged;
  final Function(KCard?) onItemSelected;

  @override
  _PayBodyState createState() => _PayBodyState();
}

class _PayBodyState extends State<PayBody> {
  KCard? _selectedItem;
  final PayBodyController controller = PayBodyController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.getCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return OkitoBuilder(
        controller: controller,
        builder: () {
          return PageSkeleton(
              child: Column(
                children: [
                  ...controller.cards.map((e) {
                    String protectedCardNumber = e.cardNumber.replaceRange(0, 14, "**** **** ****");

                    return Column(
                      children: [
                        Divider(),
                        InkWell(
                          onLongPress: () {
                            // showAdaptiveActionSheet(
                            //   context: context,
                            //   title: const Text("Options"),
                            //   actions: <BottomSheetAction>[],
                            //   cancelAction: CancelAction(
                            //     title: Text(
                            //       "Remove card",
                            //       style: TextStyle(color: ColorConstants.red),
                            //     ),
                            //     onPressed: () {},
                            //   ),
                            // ).then((value) {
                            //   widget.onItemDeleted();
                            //   _selectedItem = null;
                            // });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // SizedBox(
                                    //   height: 25,
                                    //   width: 40,
                                    //   child: Image.asset(
                                    //     "assets/images/bank/${e.cardType.replaceAll(" ", "-").toLowerCase()}.png",
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    // ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: RadioListTile<KCard>(
                                        contentPadding: EdgeInsets.zero,
                                        controlAffinity: ListTileControlAffinity.trailing,
                                        value: e,
                                        groupValue: _selectedItem,
                                        toggleable: widget.selectable,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedItem = value;
                                          });
                                          widget.onItemSelected(value);
                                        },
                                        title: Text("${e.cardType} $protectedCardNumber"),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "For security reasons, please enter your cvv",
                                  style: TextStyle(fontSize: 10.0),
                                ),
                                SizedBox(height: 10),
                                if (_selectedItem == e)
                                  SizedBox(
                                    width: 45,
                                    height: 40,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      obscureText: true,
                                      onChanged: widget.onCvvChanged,
                                      decoration: InputDecoration(
                                        hintText: "123",
                                        hintStyle: TextStyle(fontSize: 12.0),
                                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorConstants.greyColor.withOpacity(0.3),
                                          ),
                                          borderRadius: BorderRadius.circular(3.0),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          PhosphorIcons.credit_card_fill,
                          color: ColorConstants.greyColor,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: false,
                            groupValue: true,
                            onChanged: (value) {
                              Okito.pushNamed(KRoutes.addPaymentMethodRoute, arguments: {"cards": controller.cards}).then((value) {
                                controller.getCards();
                              });
                            },
                            title: Text("Add Card"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              controller: controller,
              retryCallback: controller.getCards);
        });
  }
}
