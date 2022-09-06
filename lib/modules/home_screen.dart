import 'package:arcopen_enquirer/modules/explore/explore_screen.dart';
import 'package:arcopen_enquirer/modules/finances/finances_screen.dart';
import 'package:arcopen_enquirer/modules/inbox/inbox_list/inbox_screen.dart';
import 'package:arcopen_enquirer/modules/jobs/job_listing/job_listings_screen.dart';
import 'package:arcopen_enquirer/modules/saved/saved_screen.dart';
import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:arcopen_enquirer/utils/services/subscription_service.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/utils/helpers/asset_helper.dart';
import 'package:arcopen_enquirer/widgets/navigation/k_bottom_navbar.dart';
import 'package:arcopen_enquirer/widgets/navigation/k_bottom_navbar_item.dart';
import 'package:arcopen_enquirer/widgets/navigation/k_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _activeTabIndex;

  late PageController _pageController;
  late String _pageTitle;

  @override
  void initState() {
    _activeTabIndex = 0;
    _pageTitle = "Explore Members";
    _pageController = PageController(initialPage: 0);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Okito.use<SubscriptionService>().init();
      await Okito.use<SubscriptionService>().getCurrentSubscription();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider profilePicture = AssetImage(AssetHelper.getAsset(name: "avatar.png", assetType: AssetType.image));

    final authService = Okito.use<AuthService>();
    if (authService.profileExists && (authService.profile?.companyLogo.isNotEmpty ?? false)) {
      profilePicture = NetworkImage(AssetHelper.getMemberProfilePic(name: authService.profile!.companyLogo));
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: ColorConstants.lightBlue,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black, size: 24),
          backgroundColor: Colors.white,
          title: Text(
            "$_pageTitle",
            style: Okito.theme.textTheme.headline3,
          ),
          elevation: 0,
          actions: [
            // IconButton(
            //   onPressed: () {
            //     showDialog(
            //       context: context,
            //       builder: (context) {
            //         return AlertDialog(
            //           title: Row(
            //             children: [
            //               Expanded(
            //                 child: Text(
            //                   "Notifications",
            //                   textAlign: TextAlign.center,
            //                   style: TextStyle(fontSize: 14.0),
            //                 ),
            //               ),
            //               IconButton(
            //                 onPressed: () {
            //                   KRouter().pop();
            //                 },
            //                 iconSize: 15,
            //                 icon: Icon(PhosphorIcons.x_bold),
            //               ),
            //             ],
            //           ),
            //           content: Container(
            //             width: MediaQuery.of(context).size.width * 0.9,
            //             child: NotificationsDialog(),
            //           ),
            //         );
            //       },
            //     );
            //   },
            //   icon: Icon(
            //     PhosphorIcons.bell_fill,
            //     size: 25,
            //     color: ColorConstants.darkBlue.withOpacity(0.3),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  KRouter().push(KRoutes.userProfileRoute);
                },
                child: CircleAvatar(
                  backgroundImage: profilePicture,
                ),
              ),
            ),
          ],
        ),
        drawer: KDrawer(),
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text("Hit back button again to close"),
          ),
          child: SafeArea(
            child: PageView(
              allowImplicitScrolling: false,
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _activeTabIndex = index;
                });
              },
              children: [
                ExploreScreen(),
                InboxScreen(),
                JobListingsScreen(),
                FinancesScreen(),
                SavedScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: KBottomNavBar(
          onTap: (index) {
            setState(() {
              _activeTabIndex = index;
              _pageController.jumpToPage(index);
              _pageTitle = _getPageTitle(index);
            });
          },
          items: [
            KBottomNavBarItem(
              title: "EXPLORE",
              icon: PhosphorIcons.magnifying_glass,
              isActive: _activeTabIndex == 0,
            ),
            KBottomNavBarItem(
              title: "INBOX",
              icon: PhosphorIcons.chat_circle_fill,
              isActive: _activeTabIndex == 1,
            ),
            KBottomNavBarItem(
              title: "JOB LISTING",
              icon: PhosphorIcons.newspaper_fill,
              isActive: _activeTabIndex == 2,
            ),
            KBottomNavBarItem(
              title: "FINANCES",
              icon: PhosphorIcons.currency_eur_fill,
              isActive: _activeTabIndex == 3,
            ),
            KBottomNavBarItem(
              title: "SAVED",
              icon: PhosphorIcons.heart,
              isActive: _activeTabIndex == 4,
            ),
          ],
        ),
      ),
    );
  }

  _getPageTitle(int index) {
    switch (index) {
      case 0:
        return "Explore Members";
      case 1:
        return "Inbox";
      case 2:
        return "Job listings";
      case 3:
        return "Finances";
      case 4:
        return "Saved";
    }
  }
}
