import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/app_theme.dart';
import '../resources/size.dart';

class ApiUrls {
   static const String apiBaseUrl = 'https://unify.eoxyslive.com/api/';
//  static const String apiBaseUrl = 'https://unify-backend-staging.eoxyslive.com/api/';

  static const String stripeApiKey = "pk_test_51M7YBGEAU8g6XRhsSzwgw2cS4DwXnFyL6C8HiT3GkOTY4GVOpbyjff7PCITznuAi5GV9xic6sDlLZd4p2t9fKnPZ00zZi7dmqe";

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
  static const String editPortfolioInfo = "${apiBaseUrl}edit-portfolio-info";
  static const String deletePortfolioInfo = "${apiBaseUrl}delete-portfolio-info";
  static const String editEmploymentInfo = "${apiBaseUrl}edit-employment-info";
  static const String hoursPerWeek = "${apiBaseUrl}hours-per-week";
  static const String editHoursPerWeek = "${apiBaseUrl}edit-hours-per-week";
  static const String deleteEmploymentInfo = "${apiBaseUrl}delete-employment-info";
  static const String editEducationInfo = "${apiBaseUrl}edit-education-info";
  static const String editNameInfo= "${apiBaseUrl}edit-name-info";
  static const String deleteEducationInfo= "${apiBaseUrl}delete-education-info";
  static const String languagesList= "${apiBaseUrl}languages-list";
  static const String editLanguage= "${apiBaseUrl}edit-language";
  static const String degreeList = "${apiBaseUrl}degree-list";
  static const String jobsList = "${apiBaseUrl}jobs-list";
  static const String recentJobsList = "${apiBaseUrl}recent-jobs-list";
  static const String bestMatchJobsList = "${apiBaseUrl}best-match-jobs-list";
  static const String sendProposal = "${apiBaseUrl}send-proposal";
  static const String closeAccountReasonList = "${apiBaseUrl}close-account-reason-list";
  static const String closeAccount = "${apiBaseUrl}close-account";
  static const String timezoneList = "${apiBaseUrl}timezone_list";
  static const String additionalAccount = "${apiBaseUrl}additional-account";
  static const String editLocation = "${apiBaseUrl}edit-location";
  static const String editContactInfo = "${apiBaseUrl}edit-contact-info";
  static const String savedJobList = "${apiBaseUrl}freelancer-saved-job";
  static const String singleJob = "${apiBaseUrl}single-job";
  static const String savedJobs = "${apiBaseUrl}saved-jobs";
  static const String removeSavedJobs = "${apiBaseUrl}remove-saved-jobs";
  static const String allProposal = "${apiBaseUrl}all-proposal";
  static const String dislikeReasons = "${apiBaseUrl}dislike-reasons";
  static const String dislikeJob = "${apiBaseUrl}dislike-job";
  static const String contracts = "${apiBaseUrl}contracts";
  static const String categoryList = "${apiBaseUrl}category-list";
  static const String addCategory = "${apiBaseUrl}add-category";
  static const String submitProfile = "${apiBaseUrl}submit-profile";
  static const String subscriptionPlansUrl = "${apiBaseUrl}subscription-list";
  static const String stripePayUrl = "${apiBaseUrl}subscription-payment";
  static const String singleProposalDetails = "${apiBaseUrl}single-proposal-details/";
  static const String inviteDecline = "${apiBaseUrl}invite-decline";
  static const String proposalWithdraw = "${apiBaseUrl}proposal-withdraw";
  static const String updateProposal = "${apiBaseUrl}update-proposal";
  static const String acceptOffer = "${apiBaseUrl}accept-offer/";
  static const String declineOffer = "${apiBaseUrl}decline-offer";
  static const String userDocumentVerify = "${apiBaseUrl}user-document-verify";
  static const String declineReasonList = "${apiBaseUrl}decline-reason-list/";
  static const String setVisibility = "${apiBaseUrl}set-visibility";
  static const String editExperienceLevel = "${apiBaseUrl}edit-experience-level";


}
 showToast(message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.primaryColor,
      textColor: AppTheme.whiteColor,
      fontSize: 14);
}

Future getAuthHeader() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  print(pref.getString("cookie")!.toString().replaceAll('\"', ''));
  return {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}'
  };
}

showFilterButtonSheet(
    {required context, required titleText, required widgets}) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      isDismissible: true,
      constraints: BoxConstraints(
        maxHeight: AddSize.screenHeight * .8,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
          ),
        ),
        padding: EdgeInsets.only(
            top: AddSize.padding20,
            left: AddSize.padding20,
            right: AddSize.padding20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: AddSize.size20,
                ),
                Expanded(
                  child: Text(
                    titleText,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppTheme.textColor
                    ),

                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.clear,
                    size: AddSize.size25,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: widgets,
              ),
            )
          ],
        ),
      ));
}

