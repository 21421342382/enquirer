import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/modules/splash_screen/splash_screen_controller.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenController controller = SplashScreenController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.initialize();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 80,
                  child: Image.asset("assets/images/logo.png"),
                ),
                OkitoBuilder(
                  controller: controller,
                  builder: () {
                    if (controller.initDataFailed)
                      return KButton(
                        onPressed: controller.initialize,
                        title: "Try again",
                        color: ColorConstants.greyColor.withOpacity(0.8),
                      );
                    return Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: LinearProgressIndicator(
                        backgroundColor: ColorConstants.greyColor.withOpacity(0.3),
                        color: ColorConstants.greyColor.withOpacity(0.5),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
