import 'package:arcopen_enquirer/modules/auth/change_password/change_password_screen.dart';
import 'package:arcopen_enquirer/modules/auth/login/login_screen.dart';
import 'package:arcopen_enquirer/modules/auth/profile/profile_screen.dart';
import 'package:arcopen_enquirer/modules/auth/register/register_screen.dart';
import 'package:arcopen_enquirer/modules/auth/reset_password/reset_password_screen.dart';
import 'package:arcopen_enquirer/modules/auth/reset_password/reset_password_success_screen.dart';
import 'package:arcopen_enquirer/modules/disputes/disputes_screen.dart';
import 'package:arcopen_enquirer/modules/explore/filter_screen.dart';
import 'package:arcopen_enquirer/modules/explore/location_filter_screen.dart';
import 'package:arcopen_enquirer/modules/home_screen.dart';
import 'package:arcopen_enquirer/modules/inbox/inbox_details_screen.dart';
import 'package:arcopen_enquirer/modules/jobs/active_job/active_job_details_screen.dart';
import 'package:arcopen_enquirer/modules/jobs/active_job/active_job_member_details/active_job_member_details_screen.dart';
import 'package:arcopen_enquirer/modules/jobs/history_job/history_job_details_screen.dart';
import 'package:arcopen_enquirer/modules/jobs/history_job_member_details/history_job_member_details_screen.dart';
import 'package:arcopen_enquirer/modules/jobs/job_application/job_application_screen.dart';
import 'package:arcopen_enquirer/modules/jobs/posted_job/posted_job_details_screen.dart';
import 'package:arcopen_enquirer/modules/payments/billing_methods_screen.dart';
import 'package:arcopen_enquirer/modules/payments/payment_successful_screen.dart';
import 'package:arcopen_enquirer/modules/payments/subscription_successful.dart';
import 'package:arcopen_enquirer/modules/settings/bank_details/bank_details_screen.dart';
import 'package:arcopen_enquirer/modules/settings/settings_screen.dart';
import 'package:arcopen_enquirer/modules/splash_screen/splash_screen.dart';
import 'package:arcopen_enquirer/modules/start_screen.dart';
import 'package:arcopen_enquirer/modules/subscription/add_card/add_card_screen.dart';
import 'package:arcopen_enquirer/modules/subscription/choose_plan_screen.dart';
import 'package:arcopen_enquirer/modules/subscription/payment/pay_screen.dart';
import 'package:arcopen_enquirer/modules/subscription/upgrade_plan_screen.dart';
import './k_route.dart';
import './k_router.dart';

///
/// Declaring Routes
///
class KRoutes {
  static final String splashRoute = "/";
  static final String stepperRoute = "/intro";

  static final String homeRoute = "/home";
  static final String loginRoute = "/login";
  static final String registerRoute = "/register";
  static final String resetPasswordRoute = "/reset-password-route";
  static final String resetPasswordSuccessRoute = "/reset-password-success-route";
  static final String changePasswordRoute = "/change-password";
  static final String userProfileRoute = "/user-profile";

  // Subscription routes
  static final String choosePlanRoute = "/choose-plan";
  static final String upgradePlanRoute = "/upgrade-plan";
  static final String bankDetailsRoute = "/bank-details";
  static final String settingsRoute = "/settings";
  static final String payRoute = "/pay";
  static final String addPaymentMethodRoute = "/add-payment-method-route";

  static final String disputesRoute = "/disputes";

  static final String filterRoute = "/filter-jobs";
  static final String locationFilterRoute = "/location-filter";

  static final String inboxDetailsRoute = "/inbox-details";

  static final String activeJobDetailsRoute = "/active-job-details";
  static final String activeJobMemberDetailsRoute = "/active-job-member-details";
  static final String postedJobDetailsRoute = "/posted-job-details";

  static final String billingMethodsRoute = "/billing-methods";
  static final String paymentSuccessfulRoute = "/payment-successful";
  static final String subscriptionSuccessfulUpdate = "/subscription-successful";
  static final String historyJobDetailsRoute = "/history-job-details";
  static final String historyJobMemberDetailsRoute = "/history-job-member-details";
  static final String jobApplicationRoute = "/application-details";

  static registerRoutes() {
    KRouter().registerRoute(route: KRoute(name: KRoutes.splashRoute, page: SplashScreen(), isInitial: true));
    KRouter().registerRoute(route: KRoute(name: KRoutes.stepperRoute, page: StartScreen()));

    KRouter().registerRoute(route: KRoute(name: KRoutes.registerRoute, page: RegisterScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.loginRoute, page: LoginScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.userProfileRoute, page: ProfileScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.homeRoute, page: HomeScreen()));

    KRouter().registerRoute(route: KRoute(name: KRoutes.locationFilterRoute, page: LocationFilterScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.filterRoute, page: FilterScreen()));

    KRouter().registerRoute(route: KRoute(name: KRoutes.resetPasswordRoute, page: ResetPasswordScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.resetPasswordSuccessRoute, page: ResetPasswordSuccessScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.changePasswordRoute, page: ChangePasswordScreen()));

    KRouter().registerRoute(route: KRoute(name: KRoutes.settingsRoute, page: SettingsScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.addPaymentMethodRoute, page: AddCardWidget()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.payRoute, page: PayScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.bankDetailsRoute, page: BankDetailsScreen()));

    KRouter().registerRoute(route: KRoute(name: KRoutes.choosePlanRoute, page: ChoosePlanScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.upgradePlanRoute, page: UpgradePlanScreen()));

    KRouter().registerRoute(route: KRoute(name: KRoutes.disputesRoute, page: DisputesScreen()));

    KRouter().registerRoute(route: KRoute(name: KRoutes.inboxDetailsRoute, page: InboxDetailsScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.activeJobDetailsRoute, page: ActiveJobDetailsScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.activeJobMemberDetailsRoute, page: ActiveJobMemberDetailsScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.postedJobDetailsRoute, page: PostedJobDetailsScreen()));

    KRouter().registerRoute(route: KRoute(name: KRoutes.billingMethodsRoute, page: BillingMethodsScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.paymentSuccessfulRoute, page: PaymentSuccessfulScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.subscriptionSuccessfulUpdate, page: SubscriptionSuccessfulScreen()));

    KRouter().registerRoute(route: KRoute(name: KRoutes.historyJobDetailsRoute, page: HistoryJobDetailsScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.historyJobMemberDetailsRoute, page: HistoryJobMemberDetailsScreen()));
    KRouter().registerRoute(route: KRoute(name: KRoutes.jobApplicationRoute, page: JobApplicationScreen()));
  }
}
