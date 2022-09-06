import 'package:arcopen_enquirer/utils/helpers/k_storage.dart';
import 'package:flutter/material.dart';
import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/constants/app_constants.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:okito/okito.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late int _currentPage;
  late PageController _pageController;

  @override
  void initState() {
    _currentPage = 0;
    _pageController = PageController(
      initialPage: 0,
    );
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      KStorage.write(key: AppConstants.firstAppOpeningKey, value: true);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int _page) {
                  setState(() {
                    _currentPage = _page;
                  });
                },
                children: <Widget>[
                  _IntroPage(image: "assets/images/step-one.png", title: AppConstants.stepOneTitle, content: AppConstants.stepOneContent),
                  _IntroPage(image: "assets/images/step-two.png", title: AppConstants.stepTwoTitle, content: AppConstants.stepTwoContent),
                  _IntroPage(image: "assets/images/step-three.png", title: AppConstants.stepThreeTitle, content: AppConstants.stepThreeContent),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage == 2
                      ? SizedBox()
                      : GestureDetector(
                          child: Center(
                            child: Text(
                              "SKIP",
                              style: TextStyle(
                                color: ColorConstants.greyColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          onTap: () {
                            _pageController.animateToPage(
                              2,
                              duration: Duration(milliseconds: 520),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                  TextButton(
                    child: Text(
                      _currentPage == 2 ? "GET STARTED" : "NEXT",
                      style: TextStyle(
                        color: _currentPage == 2 ? Okito.theme.primaryColor : ColorConstants.greenColor,
                        fontSize: 12.0,
                        fontWeight: _currentPage == 2 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onPressed: () {
                      if (_currentPage == 2) {
                        KRouter().push(KRoutes.loginRoute, replace: true);
                        return;
                      }
                      _pageController.animateToPage(
                        ++_currentPage,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> _indicators = [];
    for (int i = 0; i < 3; i++) {
      if (_currentPage == i) {
        _indicators.add(_Indicator(context: context, isActive: true));
      } else {
        _indicators.add(_Indicator(context: context, isActive: false));
      }
    }
    return _indicators;
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    Key? key,
    required this.context,
    required this.isActive,
  }) : super(key: key);

  final BuildContext context;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 30 : 8,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : ColorConstants.greyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  const _IntroPage({
    Key? key,
    required this.image,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String image;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
              SizedBox(height: 30),
            ],
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ColorConstants.greyColor),
          ),
        ],
      ),
    );
  }
}
