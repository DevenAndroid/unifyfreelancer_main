import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/repository/signup_repository.dart';

import '../../resources/app_assets.dart';
import '../../resources/app_theme.dart';
import '../../resources/strings.dart';
import '../../routers/my_router.dart';
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

  bool acceptTermsOrPrivacy = false;
  RxBool eyeHide = false.obs;

  Country? _selectedCountry;
  var countryText = false;

  @override
  void initState() {
    initCountry();
    super.initState();
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }

  void _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    final country = _selectedCountry;
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
                  top: 55.h,
                  right: 0,
                  left: 0,
                  child: Image.asset(
                    AppAssets.splashLogo,
                    height: 90,
                  )),
              Positioned(
                // top: 200.h,
                right: 16.0,
                left: 16.0,
                bottom: 40.h,
                child: Container(
                    // height: 436.h,
                    // margin: EdgeInsets.symmetric(horizontal: 16.0),
                    padding: EdgeInsets.only(
                        left: 20.h, right: 20.h, top: 20.h, bottom: 10.h),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                    child: SingleChildScrollView(
                      physics: ScrollPhysics(),
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
                          BoxTextField(
                            obSecure: eyeHide,
                            prefix: Icon(
                              Icons.lock_outline,
                            ),
                            // suffixIcon: eyeHide == false
                            //     ? Icons.visibility_off_outlined
                            //     : Icons.remove_red_eye_outlined,
                            controller: passwordController,
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
                          InkWell(
                              onTap: () {
                                _onPressedShowBottomSheet();
                                setState(() {
                                  countryText = true;
                                });
                              },
                              child: countryText == false
                                  ? TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppTheme.primaryColor
                                            .withOpacity(.05),
                                        hintText: "Select country",
                                        errorText: "Select country",
                                        prefixIcon: Icon(Icons.flag),
                                        hintStyle: const TextStyle(
                                            color: Color(0xff596681),
                                            fontSize: 15),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 14, horizontal: 20),
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
                                                color: AppTheme.primaryColor
                                                    .withOpacity(.15),
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                      ),
                                    )
                                  : TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppTheme.primaryColor
                                            .withOpacity(.05),
                                        hintText: ' ${country!.name}',
                                        errorText: "Select country",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: Image.asset(
                                            country.flag,
                                            package: countryCodePackageName,
                                            width: 5,
                                            height: 5,
                                          ),
                                        ),
                                        hintStyle: const TextStyle(
                                            color: Color(0xff596681),
                                            fontSize: 15),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 14, horizontal: 20),
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
                                                color: AppTheme.primaryColor
                                                    .withOpacity(.15),
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                      ),
                                    )),
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
                              if (acceptTermsOrPrivacy == false) {
                                showError('Please accept conditions.');
                              } else if (countryText == false) {
                                showError(
                                  'Please select a country',
                                );
                              } else {
                                signUp(
                                        firstNameController.text,
                                        lastNameController.text,
                                        emailController.text,
                                        passwordController.text,
                                        country!.name,
                                        "freelancer",
                                        "",
                                        acceptTermsOrPrivacy == true ? 1 : 0,
                                        "",
                                        context)
                                    .then((value) {
                                  if (value.status == true) {
                                    print("apihit");
                                    // sens to email verify Screen
                                    Get.toNamed(MyRouter.loginScreen);
                                    showError(value.message);
                                  } else {
                                    showError(value.message);
                                  }
                                  return null;
                                });
                              }
                            }
                          }, deviceWidth, 50),
                          SizedBox(
                            height: 16.h,
                          ),
                        ],
                      ),
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
                          Get.offAndToNamed(MyRouter.loginScreen);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.alreadyHaveAnAccount,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              AppStrings.buttonLogin,
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

// Widget _buildDropdownItem(Country country) => Container(
//       child: Row(
//         children: <Widget>[
//           SizedBox(
//             width: 12.0,
//           ),
//           CountryPickerUtils.getDefaultFlagImage(country),
//           SizedBox(
//             width: 8.0,
//           ),
//           // Text("+${country.phoneCode}(${country.isoCode})"),
//           Expanded(
//             child: Text(
//               "${country.name}",
//               style: TextStyle(overflow: TextOverflow.ellipsis),
//             ),
//           ),
//         ],
//       ),
//     );
}

class PickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CountryPickerWidget(
      onSelected: (country) => Navigator.pop(context, country),
    );
  }
}
