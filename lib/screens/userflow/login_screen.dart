import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/login_repository.dart';
import '../../repository/social_login_repository.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../resources/strings.dart';
import '../../routers/my_router.dart';
import '../../utils/api_contant.dart';
import '../../widgets/box_textfield.dart';
import '../../widgets/common_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool eyeHide = true.obs;

  loginWithGoogle(context) async {
    await GoogleSignIn().signOut();
    GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignIn!.authentication;
    final userCredentials = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    await FirebaseAuth.instance.signInWithCredential(userCredentials);
    socialLoginApi(context, googleSignInAuthentication.accessToken.toString(), "google");
    log("Google Access Token... ${googleSignInAuthentication.accessToken!}");
    log(FirebaseAuth.instance.currentUser!.uid);
  }

  loginWithApple(context) async {
    final appleProvider = AppleAuthProvider();
    if (kIsWeb) {
      await FirebaseAuth.instance.signInWithPopup(appleProvider).then((value) {
        socialLoginApi(
            context, value.credential!.accessToken.toString(), "apple");
      });
    } else {
      await FirebaseAuth.instance
          .signInWithProvider(appleProvider)
          .then((value) {
        socialLoginApi(
            context, value.credential!.accessToken.toString(), "apple");
      });
    }
  }

  socialLoginApi(context, authToken, provider) {
    socialLoginRepo(
            context: context, accessToken: authToken, provider: provider)
        .then((value) async {
      showToast(value.message.toString());
      log(jsonEncode(value));
      if (value.status!) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('cookie', jsonEncode(value.authToken));
        pref.setBool("shownIntro", true);
        //   pref.setBool("isSubscribed", false);
        if(value.data!.user!.isProfileComplete!)
        {
          if(value.data!.user!.isSubscription!){
            Get.offAllNamed(MyRouter.bottomNavbar);
          }
          else{
            Get.offAllNamed(MyRouter.subscriptionScreen);
          }
        } else {
          Get.offAllNamed(MyRouter.questionsScreen);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                height: deviceHeight,
                width: deviceWidth,
              ),
              Image.asset(
                AppAssets.loginBg,
                fit: BoxFit.cover,
                width: deviceWidth,
              ),
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
                            keyboardType: TextInputType.emailAddress,
                            obSecure: false.obs,
                            hintText: AppStrings.userNameOrEmailID.obs,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please enter your email'),
                              EmailValidator(
                                  errorText:
                                      'Please type a valid email address')
                            ])),
                        SizedBox(
                          height: 16.h,
                        ),
                        Obx(() {
                          return BoxTextField(
                            obSecure: eyeHide,
                            prefix: Icon(
                              Icons.lock_outline,
                            ),
                            suffixIcon: eyeHide == false
                                ? InkWell(
                                    onTap: () => setState(() {
                                          eyeHide = true.obs;
                                        }),
                                    child: Icon(Icons.remove_red_eye_outlined))
                                : InkWell(
                                    onTap: () => setState(() {
                                          eyeHide = false.obs;
                                        }),
                                    child: Icon(Icons.visibility_off_outlined)),
                            controller: passwordController,
                            hintText: AppStrings.password.obs,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please enter your password'),
                            ]),
                          );
                        }),
                        SizedBox(
                          height: 12.h,
                        ),
                        InkWell(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () =>
                                  Get.toNamed(MyRouter.forgotPasswordScreen),
                              child: Text(
                                AppStrings.forgotPassword,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.primaryColor),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        CommonButton(AppStrings.buttonLogin, () {
                          if (_formKey.currentState!.validate()) {
                            login(usernameController.text,
                                    passwordController.text, context)
                                .then((value) async {
                              showToast(
                                value.message.toString(),
                              );
                              if (value.status == true) {
                                SharedPreferences pref = await SharedPreferences.getInstance();
                                pref.setString('cookie', jsonEncode(value.authToken));
                                pref.setBool("shownIntro", true);
                             //   pref.setBool("isSubscribed", false);
                                if(value.data!.user!.isProfileComplete!)
                                {
                                  if(value.data!.user!.isSubscription!){
                                    Get.offAllNamed(MyRouter.bottomNavbar);
                                  }
                                  else{
                                    Get.offAllNamed(MyRouter.subscriptionScreen);
                                  }
                                } else {
                                  Get.offAllNamed(MyRouter.questionsScreen);
                                }
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
                            InkWell(
                              onTap: () {
                                loginWithGoogle(context);
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: AddSize.size30,
                                    top: AddSize.padding10,
                                    right: AddSize.size30,
                                    bottom: AddSize.padding10),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AddSize.size10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Image.asset(
                                  AppAssets.googleIcon,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                            if (Platform.isIOS) SizedBox(width: AddSize.size20),
                            if (Platform.isIOS)
                              InkWell(
                                onTap: () {
                                  loginWithApple(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: AddSize.size30,
                                      top: AddSize.padding10,
                                      right: AddSize.size30,
                                      bottom: AddSize.padding10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(AddSize.size10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Image.asset(
                                    AppAssets.appleIcon,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              )
                          ],
                        ),
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
                          Get.toNamed(MyRouter.signUpScreen);
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
