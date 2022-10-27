import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../repository/forgot_password_repository.dart';
import '../resources/app_theme.dart';
import '../widgets/box_textfield.dart';
import '../widgets/common_button.dart';
import '../widgets/custom_appbar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Forgot Password",
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
                    "Enter Email Address",
                    style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  BoxTextField(
                      controller: emailController,
                      obSecure: false.obs,
                      hintText: "  Email ID".obs,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'username or email is required'),
                        EmailValidator(errorText: 'enter a valid email address')
                      ])),
                  SizedBox(
                    height: 15,
                  ),
                  CommonButton("Send", () {
                    if (_formKey.currentState!.validate()) {
                      forgotPassword(emailController.text, context)
                          .then((value) async {
                        showToast(value.message.toString());
                        if (value.status == true) {
                          Get.toNamed(MyRouter.verificationScreen,
                              arguments: [emailController.text, ""]);
                        }
                      });
                    }
                  }, deviceWidth, 50),
                ],
              ),
            ),
          ),
        ));
  }
}
