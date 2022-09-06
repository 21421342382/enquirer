import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static final String applicationName = dotenv.env["APPNAME"]!;

  static final String firstAppOpeningKey = "opening-app-for-the-first-time";
  static final String accessTokenKey = "access-token";
  static final String paymentMethodsKey = "payment_methods";

  // Intro stepper strings
  static final String stepOneTitle = "Post Jobs";
  static final String stepOneContent = "Post your job with all details and get 1000's of proposal from different guards";

  static final String stepTwoTitle = "Discuss Projects";
  static final String stepTwoContent = "Interview your favorite and hire the best fit for your business";

  static final String stepThreeTitle = "Easy Payment";
  static final String stepThreeContent = "See your transaction and get invoice";

  // External links
  static final String supportUrl = "https://arcopenspace.com/help-support";
  static final String privacyPolicyUrl = "https://arcopenspace.com/privacy-policy";
  static final String accessibilityUrl = "https://arcopenspace.com/accessibility";
  static final String tosUrl = "https://arcopenspace.com/terms-services";
}
