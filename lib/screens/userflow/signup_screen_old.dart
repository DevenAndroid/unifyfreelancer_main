// import 'dart:convert';
//
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:get/get.dart';
// import 'package:unifyfreelancer/repository/signup_repository.dart';
//
// import '../../models/model_countrylist.dart';
// import '../../repository/countrylist_repository.dart';
// import '../../resources/app_assets.dart';
// import '../../resources/app_theme.dart';
// import '../../resources/strings.dart';
// import '../../routers/my_router.dart';
// import '../../widgets/box_textfield.dart';
// import '../../widgets/common_button.dart';
// import '../../widgets/custom_dialogue.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   var _formKey = GlobalKey<FormState>();
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController searchController = TextEditingController();
//
//   bool acceptTermsOrPrivacy = false;
//   RxBool eyeHide = true.obs;
//
//   var countryText = false;
//   var selectedCountry;
//   Map<String, String> searchList = {};
//
//   ModelCountryList countryList = ModelCountryList();
//   List<Countrylist> countryList1 = [];
//   List<Countrylist> searchList1 = [];
//
//   @override
//   void initState() {
//     super.initState();
//     countryListRepo().then((value) => setState(() {
//           countryList = value;
//           countryList1.addAll(value.countrylist!);
//         }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var deviceHeight = MediaQuery.of(context).size.height;
//     var deviceWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Form(
//           key: _formKey,
//           child: Stack(
//             children: [
//               Container(
//                 color: Colors.white,
//                 height: deviceHeight,
//                 width: deviceWidth,
//               ),
//               Image.asset(
//                 AppAssets.loginBg,
//                 fit: BoxFit.cover,
//                 width: deviceWidth,
//               ),
//               Positioned(
//                   top: 55.h,
//                   right: 0,
//                   left: 0,
//                   child: Image.asset(
//                     AppAssets.splashLogo,
//                     height: 90,
//                   )),
//               Positioned(
//                 // top: 200.h,
//                 right: 16.0,
//                 left: 16.0,
//                 bottom: 40.h,
//                 child: Container(
//                     // height: 436.h,
//                     // margin: EdgeInsets.symmetric(horizontal: 16.0),
//                     padding: EdgeInsets.only(
//                         left: 20.h, right: 20.h, top: 20.h, bottom: 10.h),
//                     decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey,
//                             blurRadius: 5.0,
//                           ),
//                         ]),
//                     child: SingleChildScrollView(
//                       physics: const BouncingScrollPhysics(),
//                       child: Column(
//                         children: [
//                           Text(
//                             AppStrings.signUpYourAccount,
//                             style: TextStyle(
//                                 fontSize: 16.sp, fontWeight: FontWeight.w600),
//                           ),
//                           SizedBox(
//                             height: 18.h,
//                           ),
//                           BoxTextField(
//                               obSecure: false.obs,
//                               prefix: Icon(
//                                 Icons.person_outline,
//                               ),
//                               controller: firstNameController,
//                               hintText: AppStrings.firstName.obs,
//                               validator: MultiValidator([
//                                 RequiredValidator(
//                                     errorText: 'firstname is required'),
//                               ])),
//                           SizedBox(
//                             height: 12.h,
//                           ),
//                           BoxTextField(
//                               obSecure: false.obs,
//                               prefix: Icon(
//                                 Icons.person_outline,
//                               ),
//                               controller: lastNameController,
//                               hintText: AppStrings.lastName.obs,
//                               validator: MultiValidator([
//                                 RequiredValidator(
//                                     errorText: 'lastname is required'),
//                               ])),
//                           SizedBox(
//                             height: 12.h,
//                           ),
//                           BoxTextField(
//                               obSecure: false.obs,
//                               prefix: Icon(
//                                 Icons.mail_outline,
//                               ),
//                               controller: emailController,
//                               hintText: AppStrings.emailID.obs,
//                               validator: MultiValidator([
//                                 RequiredValidator(
//                                     errorText:
//                                         'firstname or email is required'),
//                                 EmailValidator(
//                                     errorText: 'enter a valid email address')
//                               ])),
//                           SizedBox(
//                             height: 12.h,
//                           ),
//                           Obx(() {
//                             return BoxTextField(
//                               obSecure: eyeHide,
//                               prefix: Icon(
//                                 Icons.lock_outline,
//                               ),
//                               suffixIcon: eyeHide == false
//                                   ? InkWell(
//                                       onTap: () => setState(() {
//                                         eyeHide = true.obs;
//                                       }),
//                                      child: Icon(Icons.remove_red_eye_outlined))
//                                   : InkWell(
//                                       onTap: () => setState(() {
//                                         eyeHide = false.obs;
//                                       }),
//                             child: Icon(Icons.visibility_off_outlined)),
//                               controller: passwordController,
//                               hintText: AppStrings.password.obs,
//                               validator: MultiValidator([
//                                 RequiredValidator(
//                                     errorText: 'password is required'),
//                                 MinLengthValidator(8,
//                                     errorText:
//                                         'password must be at least 8 digits long'),
//                               ]),
//                             );
//                           }),
//                           SizedBox(
//                             height: 12.h,
//                           ),
//                           InkWell(
//                               onTap: () {
//                                 // countryListRepo().then((value) => print(value));
//                                 countryText = true;
//                                 searchList1 = countryList1;
//                                 // searchList = countryList;
//                                 showModalBottomSheet<void>(
//                                   isScrollControlled: true,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(30),
//                                           topRight: Radius.circular(30))),
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return SizedBox(
//                                       height: deviceHeight * .7,
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Align(
//                                             alignment: Alignment.topRight,
//                                             child: IconButton(
//                                               onPressed: () =>
//                                                   Navigator.pop(context),
//                                               icon: Icon(
//                                                 Icons.clear,
//                                                 color: AppTheme.blackColor,
//                                               ),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.all(10)
//                                                 .copyWith(top: 0),
//                                             child: TextFormField(
//                                               onChanged: (String value) {
//                                                 if (value.isNotEmpty) {
//                                                   setState(() {
//                                                     searchList1 = countryList1
//                                                         .where((element) => element
//                                                             .name!
//                                                             .toLowerCase()
//                                                             .contains(value
//                                                                 .toLowerCase()))
//                                                         .toList();
//                                                   });
//                                                 } else if (value == "") {
//                                                   setState(() {
//                                                     searchList1 = countryList1;
//                                                   });
//                                                 }
//                                               },
//                                               /*onFieldSubmitted: (value) {
//                                                 if (value != "") {
//                                                   setState(() {
//                                                     searchList1 = countryList1
//                                                         .where((element) => element
//                                                             .name!
//                                                             .toLowerCase()
//                                                             .contains(value
//                                                                 .toLowerCase()))
//                                                         .toList();
//                                                   });
//                                                 } else {
//                                                   setState(() {
//                                                     searchList1 = countryList1;
//                                                   });
//                                                 }
//                                               },*/
//                                               decoration: InputDecoration(
//                                                 filled: true,
//                                                 fillColor: AppTheme.primaryColor
//                                                     .withOpacity(.05),
//                                                 hintText: "Select country",
//                                                 prefixIcon: Icon(Icons.flag),
//                                                 hintStyle: const TextStyle(
//                                                     color: Color(0xff596681),
//                                                     fontSize: 15),
//                                                 contentPadding:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 14,
//                                                         horizontal: 20),
//                                                 focusedBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                       color: AppTheme
//                                                           .primaryColor
//                                                           .withOpacity(.15),
//                                                       width: 1.0),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                                 enabledBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                       color: AppTheme
//                                                           .primaryColor
//                                                           .withOpacity(.15),
//                                                       width: 1.0),
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                 ),
//                                                 border: OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: AppTheme
//                                                             .primaryColor
//                                                             .withOpacity(.15),
//                                                         width: 1.0),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8.0)),
//                                               ),
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: ListView.builder(
//                                                 physics:
//                                                     BouncingScrollPhysics(),
//                                                 shrinkWrap: true,
//                                                 itemCount: searchList1.length,
//                                                 itemBuilder: (context, index) {
//                                                   return InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         selectedCountry =
//                                                             searchList1[index]
//                                                                 .name
//                                                                 .toString();
//                                                       });
//                                                       print(searchList1[index]
//                                                           .name
//                                                           .toString());
//                                                       Navigator.pop(context);
//                                                     },
//                                                     child: Padding(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 horizontal: 30,
//                                                                 vertical: 10),
//                                                         child: Text(
//                                                           searchList1[index]
//                                                               .name
//                                                               .toString(),
//                                                           style: TextStyle(
//                                                               fontSize: 14,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600),
//                                                         )),
//                                                   );
//                                                 }),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                               child: countryText == false
//                                   ? TextFormField(
//                                       enabled: false,
//                                       decoration: InputDecoration(
//                                         filled: true,
//                                         fillColor: AppTheme.primaryColor
//                                             .withOpacity(.05),
//                                         hintText: "Select country",
//                                         errorText: "Select country",
//                                         prefixIcon: Icon(Icons.flag),
//                                         suffixIcon: Icon(
//                                           Icons.keyboard_arrow_down,
//                                           size: 20,
//                                         ),
//                                         hintStyle: const TextStyle(
//                                             color: Color(0xff596681),
//                                             fontSize: 15),
//                                         contentPadding: const EdgeInsets.only(
//                                             top: 14, bottom: 14, left: 20),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: AppTheme.primaryColor
//                                                   .withOpacity(.15),
//                                               width: 1.0),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: AppTheme.primaryColor
//                                                   .withOpacity(.15),
//                                               width: 1.0),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         border: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: AppTheme.primaryColor
//                                                     .withOpacity(.15),
//                                                 width: 1.0),
//                                             borderRadius:
//                                                 BorderRadius.circular(8.0)),
//                                       ),
//                                     )
//                                   : TextFormField(
//                                       enabled: false,
//                                       decoration: InputDecoration(
//                                         filled: true,
//                                         fillColor: AppTheme.primaryColor
//                                             .withOpacity(.05),
//                                         hintText: '${selectedCountry}',
//                                         prefixIcon: Icon(Icons.flag),
//                                         suffixIcon: Icon(
//                                           Icons.keyboard_arrow_down,
//                                           size: 20,
//                                         ),
//                                         hintStyle: const TextStyle(
//                                             color: Color(0xff596681),
//                                             fontSize: 15),
//                                         contentPadding: const EdgeInsets.only(
//                                             top: 14, bottom: 14, left: 20),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: AppTheme.primaryColor
//                                                   .withOpacity(.15),
//                                               width: 1.0),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                               color: AppTheme.primaryColor
//                                                   .withOpacity(.15),
//                                               width: 1.0),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                         border: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: AppTheme.primaryColor
//                                                     .withOpacity(.15),
//                                                 width: 1.0),
//                                             borderRadius:
//                                                 BorderRadius.circular(8.0)),
//                                       ),
//                                     )),
//                           SizedBox(
//                             height: 12.h,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Checkbox(
//                                   materialTapTargetSize:
//                                       MaterialTapTargetSize.shrinkWrap,
//                                   value: acceptTermsOrPrivacy,
//                                   activeColor: AppTheme.primaryColor,
//                                   onChanged: (newValue) {
//                                     setState(() {
//                                       acceptTermsOrPrivacy = newValue!;
//                                     });
//                                   }),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Expanded(
//                                 child: RichText(
//                                   text: TextSpan(
//                                     style: const TextStyle(
//                                         color: AppTheme.primaryColor,
//                                         fontSize: 10),
//                                     children: [
//                                       const TextSpan(
//                                         text:
//                                             'Yes, I Understand and agree to the ',
//                                         style: TextStyle(
//                                           color: Color(0xff172B4D),
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                           text: 'Unify Terms and of Services ',
//                                           style: const TextStyle(
//                                             color: AppTheme.primaryColor,
//                                             fontSize: 12,
//                                             //decoration: TextDecoration.underline,
//                                           ),
//                                           recognizer: TapGestureRecognizer()
//                                             ..onTap = () {
//                                               //Get.toNamed(MyRouter.termsScreen);
//                                             }),
//                                       const TextSpan(
//                                         text: 'including the ',
//                                         style: TextStyle(
//                                           color: Color(0xff172B4D),
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                           text: 'User Agreement ',
//                                           style: const TextStyle(
//                                             fontSize: 12,
//                                             color: AppTheme.primaryColor,
//                                             //decoration: TextDecoration.underline,
//                                           ),
//                                           recognizer: TapGestureRecognizer()
//                                             ..onTap = () {
//                                               //Get.toNamed(MyRouter.termsScreen);
//                                             }),
//                                       const TextSpan(
//                                         text: 'and ',
//                                         style: TextStyle(
//                                           color: Color(0xff172B4D),
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                           text: 'Privacy Policy',
//                                           style: const TextStyle(
//                                             fontSize: 12,
//                                             //decoration: TextDecoration.underline,
//                                           ),
//                                           recognizer: TapGestureRecognizer()
//                                             ..onTap = () {
//                                               //Get.toNamed(MyRouter.termsScreen);
//                                             }),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           CommonButton(AppStrings.buttonCreateAccount, () {
//                             if (_formKey.currentState!.validate()) {
//                               if (acceptTermsOrPrivacy == false) {
//                                 showError('Please accept conditions.');
//                               } else if (countryText == false) {
//                                 showError(
//                                   'Please select a country',
//                                 );
//                               } else {
//                                 signUp(
//                                         firstNameController.text,
//                                         lastNameController.text,
//                                         emailController.text,
//                                         passwordController.text,
//                                         selectedCountry,
//                                         "freelancer",
//                                         "",
//                                         acceptTermsOrPrivacy == true ? 1 : 0,
//                                         "",
//                                         context)
//                                     .then((value) {
//                                   if (value.status == true) {
//                                     print(jsonEncode(value));
//                                     // sens to email verify Screen
//                                     Get.toNamed(MyRouter.verificationScreen,
//                                         arguments: [
//                                           emailController.text,
//                                           "fromSignUp"
//                                         ]);
//                                     Fluttertoast.showToast(
//                                         msg: value.message.toString(),
//                                         toastLength: Toast.LENGTH_SHORT,
//                                         gravity: ToastGravity.CENTER,
//                                         timeInSecForIosWeb: 1,
//                                         backgroundColor: Colors.black,
//                                         textColor: Colors.white,
//                                         fontSize: 14.0);
//                                   } else {
//                                     Fluttertoast.showToast(
//                                         msg: value.message.toString(),
//                                         toastLength: Toast.LENGTH_SHORT,
//                                         gravity: ToastGravity.CENTER,
//                                         timeInSecForIosWeb: 1,
//                                         backgroundColor: Colors.black,
//                                         textColor: Colors.white,
//                                         fontSize: 14.0);
//                                   }
//                                   return null;
//                                 });
//                               }
//                             }
//                           }, deviceWidth, 50),
//                           SizedBox(
//                             height: 16.h,
//                           ),
//                         ],
//                       ),
//                     )),
//               ),
//               Positioned(
//                   bottom: 10.h,
//                   right: 0,
//                   left: 0,
//                   child: Align(
//                       alignment: Alignment.center,
//                       child: InkWell(
//                         onTap: () {
//                           Get.offAndToNamed(MyRouter.loginScreen);
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               AppStrings.alreadyHaveAnAccount,
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 4.w,
//                             ),
//                             Text(
//                               AppStrings.buttonLogin,
//                               style: TextStyle(
//                                   fontSize: 14.sp,
//                                   color: AppTheme.primaryColor),
//                             ),
//                           ],
//                         ),
//                       ))),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
