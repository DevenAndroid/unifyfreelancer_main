import 'package:get/get.dart';
import 'package:unifyfreelancer/Screens/userflow/login_screen.dart';
import 'package:unifyfreelancer/screens/userflow/splashScreen.dart';
import '../Screens/alerts_screen.dart';
import '../Screens/chat_screen.dart';
import '../Screens/contracts_details_screen.dart';
import '../Screens/contracts_screen.dart';
import '../Screens/help_and_support_screen.dart';
import '../Screens/home_screen.dart';
import '../Screens/job_details_screen.dart';
import '../Screens/messages_screen.dart';
import '../Screens/profile/profile_screen.dart';
import '../Screens/proposals_screen.dart';
import '../Screens/reports_screen.dart';
import '../Screens/save_jobs_screen.dart';
import '../Screens/settings_screen.dart';
import '../Screens/unify_qualifications.dart';
import '../Screens/userflow/onboarding_screen.dart';
import '../bottom_navbar.dart';
import '../screens/add_milestone_screen.dart';
import '../screens/agency_account_screen.dart';
import '../screens/change_hour_rate.dart';
import '../screens/create_client_account.dart';
import '../screens/profile/add_certifications.dart';
import '../screens/profile/add_education_screen.dart';
import '../screens/profile/add_employment_screen.dart';
import '../screens/profile/add_language_screen.dart';
import '../screens/profile/add_other_experiences_screen.dart';
import '../screens/profile/add_portfolio_screen.dart';
import '../screens/profile/add_testimonials_screen.dart';
import '../screens/profile/edit_language_screen.dart';
import '../screens/profile/hour_per_week_screen.dart';
import '../screens/request_milestone_changes.dart';
import '../screens/settings/change_password_screen.dart';
import '../screens/settings/security_question_screen.dart';
import '../screens/settings/billing_and_payment_process_screen.dart';
import '../screens/profile/edit_skills_screen.dart';
import '../screens/new_password_screen.dart';
import '../screens/settings/billing_and_payment_screen.dart';
import '../screens/settings/contact_info_screen.dart';
import '../screens/settings/get_paid_screen.dart';
import '../screens/settings/my_teams_screen.dart';
import '../screens/settings/password_and_security_screen.dart';
import '../screens/settings/profile_setting_screen.dart';
import '../screens/submit_proposal_screen.dart';
import '../screens/userflow/signup_screen.dart';
import '../screens/settings/tax_information_screen.dart';
import '../screens/forgot_password_screen.dart';
import '../screens/userflow/verification_screen.dart';

class MyRouter {
  static var splashScreen = "/splashScreen";
  static var onBoardingScreen = "/onBoardingScreen";
  static var signUpScreen = "/signUpScreen";
  static var loginScreen = "/loginScreen";
  static var forgotPasswordScreen = "/forgotPasswordScreen";
  static var verificationScreen = "/verificationScreen";
  static var newPasswordScreen = "/newPasswordScreen";
  static var bottomNavbar = "/bottomNavbar";
  static var homeScreen = "/homeScreen";
  static var saveJobsScreen = "/saveJobsScreen";
  static var jobDetailsScreen = "/jobDetailsScreen";
  static var proposalsScreen = "/proposalsScreen";
  static var contractsScreen = "/contractsScreen";
  static var contractsDetailsScreen = "/contractsDetailsScreen";
  static var alertsScreen = "/alertsScreen";
  static var unifyQualificationsScreen = "/unifyQualificationsScreen";
  static var reportsScreen = "/reportsScreen";
  static var messagesScreen = "/messagesScreen";
  static var chatScreen = "/chatScreen";
  static var profileScreen = "/profileScreen";
  static var addLanguageScreen = "/addLanguageScreen";
  static var editLanguageScreen = "/editLanguageScreen";
  static var hoursPerWeekScreen = "/hoursPerWeekScreen";
  static var addEducationScreen = "/addEducationScreen";
  static var addEmploymentScreen = "/addEmploymentScreen";
  static var addCertificationsScreen = "/addCertificationsScreen";
  static var editSkillsScreen = "/editSkillsScreen";
  static var addOtherExperiencesScreen = "/addOtherExperiencesScreen";
  static var addTestimonialsScreen = "/addTestimonialsScreen";
  static var addPortFolioScreen = "/addPortFolioScreen";
  static var settingsScreen = "/settingsScreen";
  static var billingAndPaymentScreen = "/billingAndPaymentScreen";
  static var billingAndPaymentProcessScreen = "/billingAndPaymentProcessScreen";
  static var getPaidScreen = "/getPaidScreen";
  static var myTeamsScreen = "/myTeamsScreen";
  static var taxInformationScreen = "/taxInformationScreen";
  static var contactInfoScreen = "/contactInfoScreen";
  static var profileSettingScreen = "/profileSettingScreen";
  static var passwordAndSecurityScreen = "/passwordAndSecurityScreen";
  static var helpAndSupportScreen = "/helpAndSupportScreen";
  static var securityQuestionScreen = "/securityQuestionScreen";
  static var changePasswordScreen = "/changePasswordScreen";
  static var changeHourlyRateScreen = "/changeHourlyRateScreen";
  static var agencyAccountScreen = "/agencyAccountScreen";
  static var createClientAccount = "/createClientAccount";
  static var submitProposalScreen = "/submitProposalScreen";
  static var addMilestoneScreen = "/addMilestoneScreen";
  static var requestMilestoneChangesScreen = "/requestMilestoneChangesScreen";

  static var route = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: MyRouter.onBoardingScreen, page: () => OnBoardingScreen()),
    GetPage(name: MyRouter.signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: MyRouter.loginScreen, page: () => const LoginScreen()),
    GetPage(name: MyRouter.forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(name: MyRouter.verificationScreen, page: () => const VerificationScreen()),
    GetPage(name: MyRouter.newPasswordScreen, page: () => const NewPasswordScreen()),
    GetPage(name: MyRouter.bottomNavbar, page: () => const BottomNavbar()),
    GetPage(name: MyRouter.homeScreen, page: () => const HomeScreen()),
    GetPage(name: MyRouter.saveJobsScreen, page: () => const SaveJobsScreen()),
    GetPage(name: MyRouter.jobDetailsScreen, page: () => const JobDetailsScreen()),
    GetPage(name: MyRouter.proposalsScreen, page: () => const ProposalsScreen()),
    GetPage(name: MyRouter.contractsScreen, page: () => const ContractsScreen()),
    GetPage(name: MyRouter.contractsDetailsScreen, page: () => const ContractsDetailsScreen()),
    GetPage(name: MyRouter.alertsScreen, page: () => const AlertsScreen()),
    GetPage(name: MyRouter.unifyQualificationsScreen, page: () => const UnifyQualificationsScreen()),
    GetPage(name: MyRouter.reportsScreen, page: () => const ReportsScreen()),
    GetPage(name: MyRouter.messagesScreen, page: () => const MessagesScreen()),
    GetPage(name: MyRouter.chatScreen, page: () => const ChatScreen()),
    GetPage(name: MyRouter.profileScreen, page: () => const ProfileScreen()),
    GetPage(name: MyRouter.addLanguageScreen, page: () => const AddLanguageScreen()),
    GetPage(name: MyRouter.editLanguageScreen, page: () => const EditLanguageScreen()),
    GetPage(name: MyRouter.hoursPerWeekScreen, page: () => const HoursPerWeekScreen()),
    GetPage(name: MyRouter.addEducationScreen, page: () => const AddEducationScreen()),
    GetPage(name: MyRouter.addEmploymentScreen, page: () => const AddEmploymentScreen()),
    GetPage(name: MyRouter.addCertificationsScreen, page: () => const AddCertificationsScreen()),
    GetPage(name: MyRouter.editSkillsScreen, page: () => const EditSkillsScreen()),
    GetPage(name: MyRouter.addOtherExperiencesScreen, page: () => const AddOtherExperiencesScreen()),
    GetPage(name: MyRouter.addTestimonialsScreen, page: () => const AddTestimonialsScreen()),
    GetPage(name: MyRouter.addPortFolioScreen, page: () => const AddPortFolioScreen()),
    GetPage(name: MyRouter.settingsScreen, page: () => const SettingsScreen()),
    GetPage(name: MyRouter.billingAndPaymentScreen, page: () => const BillingAndPaymentScreen()),
    GetPage(name: MyRouter.billingAndPaymentProcessScreen, page: () => const BillingAndPaymentProcessScreen()),
    GetPage(name: MyRouter.getPaidScreen, page: () => const GetPaidScreen()),
    GetPage(name: MyRouter.myTeamsScreen, page: () => const MyTeamsScreen()),
    GetPage(name: MyRouter.taxInformationScreen, page: () => const TaxInformationScreen()),
    GetPage(name: MyRouter.contactInfoScreen, page: () => const ContactInfoScreen()),
    GetPage(name: MyRouter.profileSettingScreen, page: () => const ProfileSettingScreen()),
    GetPage(name: MyRouter.passwordAndSecurityScreen, page: () => const PasswordAndSecurityScreen()),
    GetPage(name: MyRouter.helpAndSupportScreen, page: () => const HelpAndSupportScreen()),
    GetPage(name: MyRouter.securityQuestionScreen, page: () => const SecurityQuestionScreen()),
    GetPage(name: MyRouter.changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: MyRouter.changeHourlyRateScreen, page: () => const ChangeHourlyRateScreen()),
    GetPage(name: MyRouter.agencyAccountScreen, page: () => const AgencyAccountScreen()),
    GetPage(name: MyRouter.createClientAccount, page: () => const CreateClientAccount()),
    GetPage(name: MyRouter.submitProposalScreen, page: () => const SubmitProposalScreen()),
    GetPage(name: MyRouter.addMilestoneScreen, page: () => const AddMilestoneScreen()),
    GetPage(name: MyRouter.requestMilestoneChangesScreen, page: () => const RequestMilestoneChangesScreen()),
  ];
}
