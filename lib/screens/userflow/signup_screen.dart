import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/model_countrylist.dart';
import '../../repository/countrylist_repository.dart';
import '../../repository/signup_repository.dart';
import '../../repository/social_login_repository.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../resources/strings.dart';
import '../../routers/my_router.dart';

import '../../utils/api_contant.dart';
import '../../widgets/box_textfield.dart';
import '../../widgets/common_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController invitationController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  bool acceptTermsOrPrivacy = false;
  RxBool eyeHide = true.obs;
  RxBool eyeHide2 = true.obs;
  ModelCountryList countryList = ModelCountryList();
  RxList searchList1 = <String>[].obs;

  @override
  void initState() {
    super.initState();
    countryListRepo().then((value) => setState(() {
          countryList = value;
        }));
  }

  bool checkboxColor = false;

  loginWithGoogle(context) async {
    await GoogleSignIn().signOut();
    GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignIn!.authentication;
    final userCredentials = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    await FirebaseAuth.instance.signInWithCredential(userCredentials);
    socialLoginApi(
        context, googleSignInAuthentication.accessToken.toString(), "google");
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
    socialLoginRepo(context: context, accessToken: authToken, provider: provider).then((value) async {
      showToast(value.message.toString());
      log(jsonEncode(value));
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

  Future<void> _launchUrl(value) async {
    final Uri url = Uri.parse("$value");
    try{
      await launchUrl(url,mode: LaunchMode.externalApplication);
    } catch (e){
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: AddSize.size300 * .86,
                  width: deviceWidth,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/loginBg.png'),
                          fit: BoxFit.cover)),
                  child: Container(
                    height: AddSize.size250,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/images/Logo.png'),
                      //fit: BoxFit.cover
                    )),
                  ),
                ),
              ),
              Positioned.fill(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: AddSize.size300 * .65,
                    ),
                    Container(
                      padding: EdgeInsets.all(AddSize.padding18),
                      margin:
                          EdgeInsets.symmetric(horizontal: AddSize.padding18),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              spreadRadius: 5,
                            )
                          ]),
                      child: Column(
                        children: [
                          Text(
                            AppStrings.signUpYourAccount,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          BoxTextField(
                              obSecure: false.obs,
                              prefix: const Icon(
                                Icons.person_outline,
                              ),
                              controller: firstNameController,
                              hintText: AppStrings.firstName.obs,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter your first name'),
                              ])),
                          SizedBox(
                            height: 12.h,
                          ),
                          BoxTextField(
                              obSecure: false.obs,
                              prefix: const Icon(
                                Icons.person_outline,
                              ),
                              controller: lastNameController,
                              hintText: AppStrings.lastName.obs,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter your last name'),
                              ])),
                          SizedBox(
                            height: 12.h,
                          ),
                          BoxTextField(
                              obSecure: false.obs,
                              prefix: const Icon(
                                Icons.mail_outline,
                              ),
                              controller: emailController,
                              hintText: AppStrings.emailID.obs,
                             /* validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Email is required'),
                                EmailValidator(
                                    errorText: 'Enter a valid email address')
                              ])*/
                            validator: (value) {
                              if (emailController.text.isEmpty) {
                                return "Please enter your email";
                              } else if (emailController.text.contains('+') || emailController.text.contains(' ')) {
                                return "Email is invalid";
                              } else if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailController.text)) {
                                return null;
                              } else {
                                return 'Please type a valid email address';
                              }
                            },
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Obx(() {
                            return BoxTextField(
                              obSecure: eyeHide,
                              textSize: AddSize.size12,
                              prefix: const Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: eyeHide == false
                                  ? InkWell(
                                      onTap: () => setState(() {
                                            eyeHide = true.obs;

                                          }),
                                      child:
                                          const Icon(Icons.remove_red_eye_outlined))
                                  : InkWell(
                                      onTap: () => setState(() {
                                            eyeHide = false.obs;
                                          }),
                                      child:
                                          const Icon(Icons.visibility_off_outlined)),
                              controller: passwordController,
                              hintText: AppStrings.password.obs,

                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Please enter your password'),
                                MinLengthValidator(8, errorText: 'Password must be at least 8 characters, with 1 special character & 1 numerical'),
                                MaxLengthValidator(16, errorText: "Password maximum length is 16"),
                                PatternValidator(r"(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                                    errorText: "Password must be at least 8 characters, with 1 special character & 1 numerical"),
                              ]),
                            );
                          }),
                          SizedBox(
                            height: 12.h,
                          ),
                          BoxTextField(
                            obSecure: eyeHide2,
                            prefix: const Icon(
                              Icons.lock_outline,
                            ),
                            suffixIcon: eyeHide2 == false
                                ? InkWell(
                                    onTap: () => setState(() {
                                          eyeHide2 = true.obs;
                                        }),
                                    child: const Icon(Icons.remove_red_eye_outlined))
                                : InkWell(
                                    onTap: () => setState(() {
                                          eyeHide2 = false.obs;
                                        }),
                                    child: const Icon(Icons.visibility_off_outlined)),
                            // controller: confirmPasswordController,
                            hintText: "Confirm password".obs,
                            validator: (value) {
                              if (value == "") {
                                return "Please enter your confirm password";
                              } else if (value.toString() !=
                                  passwordController.text.trim()) {
                                return "The confirm password is not matching with password";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          BoxTextField(
                            obSecure: false.obs,
                            prefix: Image.asset(
                              'assets/icon/email_icon.png',
                              height: 20,
                              width: 20,
                            ),
                            controller: invitationController,
                            hintText: "Invitation code".obs,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextFormField(
                            onTap: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                              searchList1.clear();
                              for (var item in countryList.countrylist!) {
                                searchList1.add(item.name.toString());
                              }
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: deviceHeight * .7,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            icon: const Icon(
                                              Icons.clear,
                                              color: AppTheme.blackColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10)
                                              .copyWith(top: 0),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              if (value != "") {
                                                searchList1.clear();
                                                // searchList1.value = countryList.countrylist!.map((e) => e.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                                for (var item in countryList
                                                    .countrylist!) {
                                                  if (item.name
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(value
                                                          .toLowerCase())) {
                                                    searchList1.add(
                                                        item.name.toString());
                                                  }
                                                }
                                              } else {
                                                searchList1.clear();
                                                for (var item in countryList
                                                    .countrylist!) {
                                                  searchList1.add(
                                                      item.name.toString());
                                                }
                                              }
                                              log("jsonEncode(searchList1)");
                                            },
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppTheme.primaryColor
                                                  .withOpacity(.05),
                                              hintText: "Select country",
                                              prefixIcon: const Icon(Icons.flag),
                                              hintStyle: const TextStyle(
                                                  color: Color(0xff596681),
                                                  fontSize: 15),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                      horizontal: 20),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppTheme.primaryColor
                                                        .withOpacity(.15),
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppTheme.primaryColor
                                                        .withOpacity(.15),
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppTheme
                                                          .primaryColor
                                                          .withOpacity(.15),
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                          ),
                                        ),
                                        Obx(() {
                                          return Expanded(
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: searchList1.length,
                                                itemBuilder: (context, index) {
                                                  return Obx(() {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          countryController
                                                                  .text =
                                                              searchList1[index]
                                                                  .toString();
                                                        });
                                                        print(countryController
                                                            .text);
                                                        Navigator.pop(context);
                                                      },
                                                      child: Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 10),
                                                          child: Text(
                                                            searchList1[index]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )),
                                                    );
                                                  });
                                                }),
                                          );
                                        }),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            controller: countryController,
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: AppTheme.primaryColor.withOpacity(.05),
                              hintText: 'Select country',
                              prefixIcon: const Icon(Icons.flag),
                              suffixIcon: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                              ),
                              hintStyle: const TextStyle(
                                  color: Color(0xff596681), fontSize: 15),
                              contentPadding: const EdgeInsets.only(
                                  top: 14, bottom: 14),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        AppTheme.primaryColor.withOpacity(.15),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        AppTheme.primaryColor.withOpacity(.15),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.primaryColor
                                          .withOpacity(.15),
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please select your country'),
                            ]),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Theme(
                                data: ThemeData(
                                  unselectedWidgetColor: checkboxColor == false ? Colors.grey.withOpacity(.78) : Colors.red,

                                ),
                                child: Checkbox(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: acceptTermsOrPrivacy,
                                    activeColor: AppTheme.primaryColor,
                                    onChanged: (newValue) {
                                      setState(() {
                                        acceptTermsOrPrivacy = newValue!;
                                      });
                                    }),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: 10),
                                    children: [
                                      const TextSpan(
                                        text:
                                            'Yes, I Understand and agree to the ',
                                        style: TextStyle(
                                          color: Color(0xff172B4D),
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'Unify Terms and of Services ',
                                          style: const TextStyle(
                                            color: AppTheme.primaryColor,
                                            fontSize: 12,
                                            //decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              _launchUrl("https://unify-web.eoxyslive.com/#/pages/term-conditions");
                                            }),
                                      const TextSpan(
                                        text: 'including the ',
                                        style: TextStyle(
                                          color: Color(0xff172B4D),
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'User Agreement ',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppTheme.primaryColor,
                                            //decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()..onTap = () {
                                              _launchUrl("https://unify-web.eoxyslive.com/#/pages/agreements");

                                            }),
                                      const TextSpan(
                                        text: 'and ',
                                        style: TextStyle(
                                          color: Color(0xff172B4D),
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                          text: 'Privacy Policy',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            //decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              _launchUrl("https://unify-web.eoxyslive.com/#/pages/privacy-policy");
                                            }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          CommonButton(AppStrings.buttonCreateAccount, () {
                            if (_formKey.currentState!.validate() && acceptTermsOrPrivacy == true) {
                              signUp(
                                      firstName: firstNameController.text.trim(),
                                      lastName: lastNameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      referalCode: invitationController.text.trim(),
                                      country: countryController.text.trim(),
                                      userType: "freelancer",
                                      agreeTerms: acceptTermsOrPrivacy == true ? 1 : 0,
                                      sendEmail: "",
                                      context: context).then((value) {
                                showToast(value.message.toString());
                                print(jsonEncode(value));
                                if (value.status == true) {
                                  Get.toNamed(MyRouter.verificationScreen,
                                      arguments: [
                                        emailController.text,
                                        "fromSignUp"
                                      ]);
                                }
                              });
                            }
                            if(acceptTermsOrPrivacy == false){
                            //  showToast("Please accept terms and conditions");
                              setState(() {
                                checkboxColor = true;
                              });
                            }
                          }, deviceWidth, 50),
                          SizedBox(
                            height: 25.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppStrings.orSignupWith,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.darkBlueText),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
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
                              if (Platform.isIOS)
                                SizedBox(width: AddSize.size20),
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
                      ),
                    ),
                    SizedBox(
                      height: AddSize.size14,
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(MyRouter.loginScreen),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              color: AppTheme.primaryColor, fontSize: 10),
                          children: [
                            const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff172B4D)),
                            ),
                            TextSpan(
                                text: ' Login',
                                style: const TextStyle(
                                    fontSize: 14, color: AppTheme.primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.back();
                                  }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AddSize.size14 * 1.5,
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
