import 'dart:convert';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../../models/model_countrylist.dart';
import '../../repository/countrylist_repository.dart';
import '../../repository/signup_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/strings.dart';
import '../../routers/my_router.dart';
import '../../size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/box_textfield.dart';
import '../../widgets/common_button.dart';
import '../../widgets/custom_dialogue.dart';

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
                  height: AddSize.size300 * 1.2,
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
                      height: AddSize.size300 * .9,
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
                              prefix: Icon(
                                Icons.person_outline,
                              ),
                              controller: firstNameController,
                              hintText: AppStrings.firstName.obs,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'firstname is required'),
                              ])),
                          SizedBox(
                            height: 12.h,
                          ),
                          BoxTextField(
                              obSecure: false.obs,
                              prefix: Icon(
                                Icons.person_outline,
                              ),
                              controller: lastNameController,
                              hintText: AppStrings.lastName.obs,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'lastname is required'),
                              ])),
                          SizedBox(
                            height: 12.h,
                          ),
                          BoxTextField(
                              obSecure: false.obs,
                              prefix: Icon(
                                Icons.mail_outline,
                              ),
                              controller: emailController,
                              hintText: AppStrings.emailID.obs,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText:
                                        'firstname or email is required'),
                                EmailValidator(
                                    errorText: 'enter a valid email address')
                              ])),
                          SizedBox(
                            height: 12.h,
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
                                      child:
                                          Icon(Icons.remove_red_eye_outlined))
                                  : InkWell(
                                      onTap: () => setState(() {
                                            eyeHide = false.obs;
                                          }),
                                      child:
                                          Icon(Icons.visibility_off_outlined)),
                              controller: passwordController,
                              hintText: AppStrings.password.obs,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'password is required'),
                                MinLengthValidator(8,
                                    errorText:
                                        'password must be at least 8 digits long'),
                              ]),
                            );
                          }),
                          SizedBox(
                            height: 12.h,
                          ),
                          BoxTextField(
                            obSecure: eyeHide2,
                            prefix: Icon(
                              Icons.lock_outline,
                            ),
                            suffixIcon: eyeHide2 == false
                                ? InkWell(
                                    onTap: () => setState(() {
                                          eyeHide2 = true.obs;
                                        }),
                                    child: Icon(Icons.remove_red_eye_outlined))
                                : InkWell(
                                    onTap: () => setState(() {
                                          eyeHide2 = false.obs;
                                        }),
                                    child: Icon(Icons.visibility_off_outlined)),
                            // controller: confirmPasswordController,
                            hintText: "Confirm Password".obs,
                            validator: (value) {
                              if (value == "") {
                                return "Confirm password required";
                              } else if (value.toString() !=
                                  passwordController.text.trim()) {
                                return "Confirm password is not matching with password";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextFormField(
                            onTap: () {
                              // searchList1.value = countryList1;
                              searchList1.clear();
                              for (var item in countryList.countrylist!) {
                                searchList1.add(item.name.toString());
                              }
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
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
                                            icon: Icon(
                                              Icons.clear,
                                              color: AppTheme.blackColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10)
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
                                              prefixIcon: Icon(Icons.flag),
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
                                                    BouncingScrollPhysics(),
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
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 10),
                                                          child: Text(
                                                            searchList1[index]
                                                                .toString(),
                                                            style: TextStyle(
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
                            readOnly: true,
                            controller: countryController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppTheme.primaryColor.withOpacity(.05),
                              hintText: 'Select country',
                              prefixIcon: Icon(Icons.flag),
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                              ),
                              hintStyle: const TextStyle(
                                  color: Color(0xff596681), fontSize: 15),
                              contentPadding: const EdgeInsets.only(
                                  top: 14, bottom: 14, left: 20),
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
                                  errorText: 'Country is required'),
                            ]),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: acceptTermsOrPrivacy,
                                  activeColor: AppTheme.primaryColor,
                                  onChanged: (newValue) {
                                    setState(() {
                                      acceptTermsOrPrivacy = newValue!;
                                    });
                                  }),
                              SizedBox(
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
                                              //Get.toNamed(MyRouter.termsScreen);
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
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              //Get.toNamed(MyRouter.termsScreen);
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
                                              //Get.toNamed(MyRouter.termsScreen);
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
                            if (_formKey.currentState!.validate()) {
                              signUp(
                                      firstNameController.text,
                                      lastNameController.text,
                                      emailController.text,
                                      passwordController.text,
                                      countryController.text,
                                      "freelancer",
                                      "",
                                      acceptTermsOrPrivacy == true ? 1 : 0,
                                      "",
                                      context)
                                  .then((value) {
                                if (value.status == true) {
                                  print(jsonEncode(value));
                                  Get.toNamed(MyRouter.verificationScreen,
                                      arguments: [
                                        emailController.text,
                                        "fromSignUp"
                                      ]);
                                  showToast(
                                    value.message.toString(),
                                  );
                                } else {
                                  showToast(
                                    value.message.toString(),
                                  );
                                }
                                return null;
                              });
                            }
                          }, deviceWidth, 50),
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
                                    fontSize: 14, color: AppTheme.primaryColor
                                    //decoration: TextDecoration.underline,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {}),
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
