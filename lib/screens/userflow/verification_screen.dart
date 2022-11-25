import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/repository/resend_otp_repository.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../../repository/verify_signup_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../routers/my_router.dart';
import '../../widgets/add_text.dart';
import '../../widgets/common_button.dart';
import '../../widgets/custom_appbar.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  bool isFromSignUp = false;
  String stars = "";

  @override
  void initState() {
    super.initState();
    email = Get.arguments[0];
    isFromSignUp = Get.arguments[1].toString() == "fromSignUp" ? true : false;

    String str = Get.arguments[0];
    int vv = email.split("@").first.length > 2
        ? email.split("@").first.length - 2
        : email.split("@").first.length;
    for (var i = 0; i < vv; i++) {
      if (stars == "") {
        stars = "*";
      } else {
        stars = stars + "*";
      }
    }
  }

  var email;
  var otp = "";

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Verification",
            // onPressedForLeading:,
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Enter Verification Code",
                    style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  /*  Text(
                    "We have sent code to your email:",
                    style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    email.toString(),
                    style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),*/
                  Center(
                    child: AddText(
                      text: "We have sent code to your email:" +
                          "\n${email.substring(0, 2)}$stars@${email.split("@").last}",
                      textAlign: TextAlign.center,
                      height: 1.5,
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  OtpTextField(
                    numberOfFields: 4,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    fieldWidth: 60,
                    margin: EdgeInsets.all(10),
                    fillColor: AppTheme.primaryColor.withOpacity(0.04),
                    borderColor: AppTheme.primaryColor.withOpacity(0.08),
                    filled: true,
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      otp = code;
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      setState(() {
                        otp = verificationCode;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      resendOtp(email, context).then((value) async {
                        print(jsonEncode(value));
                        if (value.status == true) {}
                        showToast(
                          value.message.toString(),
                        );
                      });
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "if you Don't receive a code ? ",
                          style: TextStyle(
                            color: AppTheme.textColor,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Resend",
                              style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CommonButton("Verify", () {
                    print("value");
                    if (_formKey.currentState!.validate()) {
                      print(otp);
                      if (otp =="") {
                        showToast("Please enter the otp");
                      }
                      else if(otp.toString().length <4)
                      {
                        showToast("The otp must be 4 digit");
                      }
                      else {
                        if (isFromSignUp == true) {
                          verifySignUp(email, otp, context).then((value) async {
                            print(value);
                            showToast(
                              value.message.toString(),
                            );
                            if (value.status == true) {
                              Get.toNamed(
                                MyRouter.loginScreen,
                              );
                            }
                          });
                        } else {
                          verifySignUp(email, otp, context).then((value) async {
                            if (value.status == true) {
                              Get.toNamed(MyRouter.newPasswordScreen,
                                  arguments: [email]);
                            }
                            showToast(
                              value.message.toString(),
                            );
                          });
                        }
                      }
                    }
                  }, deviceWidth, 50),
                ],
              ),
            ),
          ),
        ));
  }
}
