import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../../repository/reset_password_repository.dart';
import '../../resources/app_theme.dart';
import '../../widgets/box_textfield.dart';
import '../../widgets/common_button.dart';
import '../../widgets/custom_appbar.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var email;
  RxBool eyeHide = true.obs;
  RxBool eyeHide2 = true.obs;
  @override
  void initState() {
    super.initState();
    email = Get.arguments[0];
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "New Password",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter new password",
                    style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BoxTextField(
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
                    obSecure: eyeHide,
                    hintText: "  New password".obs,
                  /*  validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required'),
                      MinLengthValidator(8, errorText: 'Password must be at least 8 characters with symbol & letter. '),
                      MaxLengthValidator(16, errorText: "Password maximum length is 16"),
                      PatternValidator(r"(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                          errorText: "Password must be at least 8 characters with symbol & letter. "),
                    ]),*/
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required'),
                      MinLengthValidator(8, errorText: 'Password must be at least 8 characters,\nwith 1 special character & 1 numerical'),
                      MaxLengthValidator(16, errorText: "Password maximum length is 16"),
                      PatternValidator(r"(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                          errorText: "Password must be at least 8 characters,\nwith 1 special character & 1 numerical"),
                    ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Confirm new password",
                    style: TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BoxTextField(
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
                    controller: confirmPasswordController,
                    obSecure: eyeHide2,
                    hintText: "  Confirm new password".obs,
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
                    height: 15,
                  ),
                  CommonButton("Submit", () {
                    if (_formKey.currentState!.validate()) {
                      resetPassword(email, passwordController.text.trim(),
                              confirmPasswordController.text.trim(), context)
                          .then((value) async {
                        showToast(value.message.toString());
                        if (value.status == true) {
                          Get.toNamed(MyRouter.loginScreen);
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
