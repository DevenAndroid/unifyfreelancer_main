import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app_theme.dart';

class ApiUrls {
  static const String apiBaseUrl = 'https://unify.eoxyslive.com/api/';
  static const String login = "${apiBaseUrl}login";
  static const String signUp = "${apiBaseUrl}signup";
  static const String verifySignUp = "${apiBaseUrl}verifysignup";
  static const String countryList = "${apiBaseUrl}coutrylist";
  static const String resendOtp = "${apiBaseUrl}resend-otp";
  static const String forgotPassword = "${apiBaseUrl}forget-password";
  static const String verifyForgotPassword = "${apiBaseUrl}verify-forgot-otp";
  static const String resetPassword = "${apiBaseUrl}reset-password";
  static const String socialLoginUrl = "${apiBaseUrl}social-login";
  static const String getFreelancerProfile = "${apiBaseUrl}get-freelancer-profile";
  static const String editDesignationInfo = "${apiBaseUrl}edit-designation-info";
  static const String editCertificateInfo = "${apiBaseUrl}edit-certificate-info";
  static const String deleteCertificateInfo = "${apiBaseUrl}delete-certificate-info";
  static const String editTestimonialInfo = "${apiBaseUrl}edit-testimonial-info";
  static const String deleteTestimonialInfo = "${apiBaseUrl}delete-testimonial-info";
  static const String skillList = "${apiBaseUrl}skill-list";
  static const String editSkillsInfo = "${apiBaseUrl}edit-skills-info";

}
 showToast(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.blackColor,
      textColor: AppTheme.whiteColor,
      fontSize: 14);
}

getAuthHeader() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  print(pref.getString("cookie")!.toString().replaceAll('\"', ''));
  return {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}'
  };
}