import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/utils/navigation/k_app_bar.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/forms/k_text_field.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightBlue,
      appBar: KAppBar(title: "Filter"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  KTextField.circular(
                    hintText: "Search",
                    leading: PhosphorIcons.magnifying_glass,
                    controller: _searchController,
                  ),
                  SizedBox(height: 20),
                  SectionTitle(title: "PROXIMITY"),
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        value: index.isEven,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "London (Greater London)",
                          style: Okito.theme.textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value) {
                          print(value);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  SectionTitle(title: "HOURLY RATE"),
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        value: index.isEven,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "London (Greater London)",
                          style: Okito.theme.textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value) {
                          print(value);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  SectionTitle(title: "CATEGORY"),
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        value: index.isEven,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "London (Greater London)",
                          style: Okito.theme.textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (value) {
                          print(value);
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: KButton.outlined(
          onPressed: () {},
          title: "DONE",
          color: Okito.theme.primaryColor,
        ),
      ),
    );
  }
}
