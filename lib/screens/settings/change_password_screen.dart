import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();

  RxBool eyeHide = false.obs;
  RxBool eyeHide2 = false.obs;
  RxBool eyeHide3 = false.obs;
  bool acceptTermsOrPrivacy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Change Password",
          // onPressedForLeading:,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(() {
              return Container(
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
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Old Password",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: "Old Password".obs,
                        obSecure: eyeHide,
                        controller: _oldPasswordController,
                        keyboardType: TextInputType.text,
                        suffixIcon: eyeHide == false
                            ? InkWell(
                                onTap: () => setState(() {
                                      eyeHide = true.obs;
                                    }),
                                child: Icon(Icons.remove_red_eye_outlined))
                            : InkWell(
                                onTap: () => setState(
                                      () {
                                        eyeHide = false.obs;
                                      },
                                    ),
                                child: Icon(Icons.visibility_off_outlined)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "New Password",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: "New Password".obs,
                        obSecure: eyeHide2,
                        controller: _newPasswordController,
                        keyboardType: TextInputType.text,
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Confirm new Password",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintText: "Confirm new Password".obs,
                        obSecure: eyeHide3,
                        controller: _confirmNewPasswordController,
                        keyboardType: TextInputType.text,
                        suffixIcon: eyeHide3 == false
                            ? InkWell(
                                onTap: () => setState(() {
                                      eyeHide3 = true.obs;
                                      print(eyeHide3);
                                    }),
                                child: Icon(Icons.remove_red_eye_outlined))
                            : InkWell(
                                onTap: () => setState(() {
                                      eyeHide3 = false.obs;
                                      print(eyeHide3);
                                    }),
                                child: Icon(Icons.visibility_off_outlined)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
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
                            child: Text(
                              
                              "All devices will be required to sign in with new password.",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textColor),
                            ),
                          ),
                        ],
                      )
                    ]),
              );
            })),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOutlineButton(
                title: 'Cancel',
                backgroundColor: AppTheme.whiteColor,
                onPressed: () {},
                textColor: AppTheme.primaryColor,
                expandedValue: false,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOutlineButton(
                title: 'Update',
                backgroundColor: AppTheme.primaryColor,
                onPressed: () => Get.back(),
                textColor: AppTheme.whiteColor,
                expandedValue: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
