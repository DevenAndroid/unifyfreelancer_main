import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/widgets/box_textfield.dart';

import '../resources/app_theme.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';

class SecurityQuestionScreen extends StatefulWidget {
  const SecurityQuestionScreen({Key? key}) : super(key: key);

  @override
  State<SecurityQuestionScreen> createState() => _SecurityQuestionScreenState();
}

class _SecurityQuestionScreenState extends State<SecurityQuestionScreen> {
  var items = [
    "Your mother's maiden name",
    "Your first pet's name",
    "The name of your elementary school",
    "Your favorite writer",
    "Your favorite actor",
    "Your favorite singer",
    "Your favorite song",
    "Your favorite city",
  ];
  bool acceptTerms = false;
  bool acceptTerms2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Security Question",
          // onPressedForLeading:,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Before you can set a new security question, you'll have to answer your current one correctly",
                style: TextStyle(fontSize: 12, color: AppTheme.textColor),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Current Question",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Your mother's maiden name",
                style: TextStyle(fontSize: 12, color: AppTheme.textColor),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Answers",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor),
              ),
              SizedBox(
                height: 5,
              ),
              BoxTextField(obSecure: false.obs, hintText: "".obs),
              SizedBox(
                height: 20,
              ),
              Text(
                "New Question",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor),
              ),
              SizedBox(
                height: 5,
              ),
              DropdownButtonFormField<dynamic>(
                isExpanded: true,
                value: null,
                validator: (value) {
                  if (value == null) {
                    return 'Please select type';
                  }
                },
                decoration: InputDecoration(
                  hintText: "Project preference",
                  hintStyle: TextStyle(fontSize: 13, color: Color(0xff596681)),
                  counterText: "",
                  filled: true,
                  fillColor: AppTheme.primaryColor.withOpacity(.05),
                  focusColor: AppTheme.primaryColor.withOpacity(.05),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.primaryColor.withOpacity(.15),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.primaryColor.withOpacity(.15),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.primaryColor.withOpacity(.15),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: AppTheme.primaryColor),
                items: List.generate(
                    items.length,
                    (index) => DropdownMenuItem(
                          value: items[index],
                          child: Text(
                            items[index].toString(),
                            style: TextStyle(
                                fontSize: 13, color: Color(0xff596681)),
                          ),
                        )),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (newValue) {},
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Answers",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor),
              ),
              SizedBox(
                height: 5,
              ),
              BoxTextField(obSecure: false.obs, hintText: "".obs),
              SizedBox(
                height: 30,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                      value: acceptTerms,
                      activeColor: AppTheme.primaryColor,
                      onChanged: (newValue) {
                        setState(() {
                          acceptTerms = newValue!;
                        });
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      "I understand my account will be locked if i am unable to answer this question",
                      style: TextStyle(fontSize: 12, color: AppTheme.textColor),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                      value: acceptTerms2,
                      activeColor: AppTheme.primaryColor,
                      onChanged: (newValue) {
                        setState(() {
                          acceptTerms2 = newValue!;
                        });
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      "Keep me logged in on this device",
                      style: TextStyle(fontSize: 12, color: AppTheme.textColor),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: CustomOutlineButton(
                        title: 'cancel',
                        backgroundColor: AppTheme.whiteColor,
                        onPressed: () =>Get.back(),
                        expandedValue: false,
                        textColor: AppTheme.primaryColor,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      flex: 1,
                      child: CustomOutlineButton(
                        title: 'Save',
                        backgroundColor: AppTheme.primaryColor,
                        onPressed: () =>Get.back(),
                        expandedValue: false,
                        textColor: AppTheme.whiteColor,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
