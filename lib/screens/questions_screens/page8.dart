import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class Page8 extends StatelessWidget {
  const Page8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12),
        height: AddSize.screenHeight,
        width: AddSize.screenWidth,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AddSize.size10,
              ),
              Text(
                "Nearly there! what work are you here to do?",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font20),
              ),
              SizedBox(
                height: AddSize.size15,
              ),
              Text(
                "Your skills show clients what you can offer, and help us choose which jobs to recommend to you. Add or remove the ones we've suggested, or start typing to pick more. It's up to you.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textColor,
                    fontSize: AddSize.font12),
              ),
              SizedBox(
                height: AddSize.size20,
              ),
              Text(
                "Your skills",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font18),
              ),
              SizedBox(
                height: AddSize.size10,
              ),
              CustomTextField(
                obSecure: false.obs,
                hintText: "Example: Full StackDeveloper | Web & Mobile".obs,
              ),
              SizedBox(
                height: AddSize.size10,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Max 15 Skills",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font14),
                ),
              ),
              SizedBox(
                height: AddSize.size20,
              ),
              Text(
                "Suggested skills",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font18),
              ),
              SizedBox(
                height: AddSize.size20,
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOutlineButton(
                title: 'Back',
                backgroundColor: AppTheme.whiteColor,
                onPressed: () {
                  Get.back();
                },
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
                title: 'Next',
                backgroundColor: AppTheme.primaryColor,
                onPressed: () {
                },
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
