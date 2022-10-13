import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class AddEmploymentScreen extends StatefulWidget {
  const AddEmploymentScreen({Key? key}) : super(key: key);

  @override
  State<AddEmploymentScreen> createState() => _AddEmploymentScreenState();
}

class _AddEmploymentScreenState extends State<AddEmploymentScreen> {
  var acceptTermsOrPrivacy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Add Employment",
          // onPressedForLeading:,
        ),
      ),
      body: Form(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 3)),
                    ] // changes position of shadow
                    ,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Company",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          obSecure: false.obs,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Ex: Unify".obs,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Location",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                obSecure: false.obs,
                                keyboardType: TextInputType.emailAddress,
                                hintText: "City".obs,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomTextField(
                                obSecure: false.obs,
                                keyboardType: TextInputType.emailAddress,
                                hintText: "Country".obs,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          obSecure: false.obs,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Degree (Optional)".obs,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Period",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                obSecure: false.obs,
                                keyboardType: TextInputType.emailAddress,
                                hintText: "From Month".obs,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomTextField(
                                obSecure: false.obs,
                                keyboardType: TextInputType.emailAddress,
                                hintText: "From year".obs,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
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
                            Text(
                              "I currently work here",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.titleText,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Description (Optional)",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          isMulti: true,
                          obSecure: false.obs,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Description".obs,
                        ),
                        SizedBox(
                          height: 15,
                        ),

                      ])),
              Row(
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
                        title: 'Save',
                        backgroundColor: AppTheme.primaryColor,
                        onPressed: () =>Get.back(),
                        textColor: AppTheme.whiteColor,
                        expandedValue: false,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}
