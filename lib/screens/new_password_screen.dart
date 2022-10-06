import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../resources/app_theme.dart';
import '../widgets/box_textfield.dart';
import '../widgets/common_button.dart';
import '../widgets/custom_appbar.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
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
                      controller: emailController,
                      obSecure: true.obs,
                      hintText: "  New password".obs,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: 'username or email is required'),
                        EmailValidator(errorText: 'enter a valid email address')
                      ])),
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
                    controller: emailController,
                    obSecure: true.obs,
                    hintText: "  Confirm new password".obs,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'password is required'),
                      MinLengthValidator(8,
                          errorText: 'password must be at least 8 digits long'),
                    ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CommonButton("Submit", () {
                    if (_formKey.currentState!.validate()) {}
                  }, deviceWidth, 50),
                ],
              ),
            ),
          ),
        ));
  }
}
