import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifyfreelancer/repository/login_repository.dart';
import 'package:unifyfreelancer/resources/app_assets.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/resources/strings.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/widgets/box_textfield.dart';
import 'package:unifyfreelancer/widgets/common_button.dart';
import 'package:unifyfreelancer/widgets/custom_dialogue.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                height: deviceHeight,
                width: deviceWidth,
              ),
              Image.asset(AppAssets.loginBg),
              Positioned(
                  top: 90.h,
                  right: 0,
                  left: 0,
                  child: Image.asset(
                    AppAssets.splashLogo,
                    height: 90,
                  )),
              Positioned(
                // top: 180.h,
                right: 16.0,
                left: 16.0,
                bottom: 40.h,
                child: Container(
                    // height: 400.h,
                    // margin: EdgeInsets.symmetric(horizontal: 16.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.loginYourAccount,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        BoxTextField(
                            prefix: Icon(
                              Icons.mail_outline,
                            ),
                            controller: usernameController,
                            obSecure: false.obs,
                            hintText: AppStrings.userNameOrEmailID.obs,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'username or email is required'),
                              EmailValidator(
                                  errorText: 'enter a valid email address')
                            ])),
                        SizedBox(
                          height: 16.h,
                        ),
                        BoxTextField(
                          prefix: Icon(
                            Icons.lock_outline,
                          ),
                          controller: passwordController,
                          obSecure: false.obs,
                          hintText: AppStrings.password.obs,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'password is required'),
                            MinLengthValidator(8,
                                errorText:
                                    'password must be at least 8 digits long'),
                          ]),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            AppStrings.forgotPassword,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.primaryColor),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        CommonButton(AppStrings.buttonLogin, () {
                          if (_formKey.currentState!.validate()) {
                            login(usernameController.text, passwordController.text, context).then((value) async {
                              if (value.status == true) {
                                showError(value.message.toString());
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.setString('cookie', jsonEncode(value.authToken));
                                Get.toNamed(MyRouter.bottomNavbar);
                                print("login Done");
                                log(":::" + jsonEncode(pref.getString('cookie')));
                              } else {
                                showError(value.message.toString());
                              }
                            });
                          }
                        }, deviceWidth, 50),
                        SizedBox(
                          height: 25.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppStrings.orLoginWith,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.darkBlueText),
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0))),
                              ),
                              child: Image.asset(
                                AppAssets.googleIcon,
                                width: 20.w,
                                height: 25.h,
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            OutlinedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0))),
                              ),
                              child: Image.asset(
                                AppAssets.appleIcon,
                                width: 20,
                                height: 25,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
              Positioned(
                  bottom: 10.h,
                  right: 0,
                  left: 0,
                  child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Get.offAndToNamed(MyRouter.signUpScreen);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.newToUnify,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              AppStrings.register,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppTheme.primaryColor),
                            ),
                          ],
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
