import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/core/models/job_category.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class StepOne extends StatelessWidget {
  StepOne({
    Key? key,
    required this.onCategorySelected,
  }) : super(key: key);

  final Function(JobCategory) onCategorySelected;
  final List<JobCategory> categories = [
    JobCategory(
      icon: "assets/images/shop.png",
      name: "Warehouse",
      color: 0XFF7667F8,
      description: "Warehouse Security officers ensure that stock,staff and the warehouse premises....",
    ),
    JobCategory(
      icon: "assets/images/building.png",
      name: "Industrial Complex",
      color: 0XFFF1C899,
      description: "These includes work, building sites and large complexes such as Energy, Biotech and high...",
    ),
    JobCategory(
      icon: "assets/images/market.png",
      name: "Retail Store",
      color: 0XFF4064E6,
      description: "Security officers working in security shopping centres (Shopping Malls), supermarkets...",
    ),
    JobCategory(
      icon: "assets/images/greetings2.png",
      name: "Corporate Events",
      color: 0XFFF743BC,
      description: "The security officers role at events,exhibitions and Company retreats include....",
    ),
    JobCategory(
      icon: "assets/images/grant.png",
      name: "NightClub",
      color: 0XFF7AB832,
      description: "Popularly known as Bouncers;the role of security guards is to deal with potential....",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ListView(
        children: [
          SizedBox(height: 20),
          SectionTitle(title: "SELECT THE JOB TYPE"),
          SizedBox(height: 10),
          ...categories.map<Widget>((category) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    offset: Offset(0, 1),
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    onCategorySelected(category);
                  },
                  borderRadius: BorderRadius.circular(12.0),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(category.color).withOpacity(0.2),
                          backgroundImage: AssetImage(category.icon),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.name,
                                style: Okito.theme.textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                category.description,
                                maxLines: 2,
                                style: Okito.theme.textTheme.bodyText2!.copyWith(
                                  fontSize: 10.0,
                                  letterSpacing: 1.3,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          PhosphorIcons.caret_right,
                          color: ColorConstants.greyColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          
        ],
      ),
    );
  }
}
