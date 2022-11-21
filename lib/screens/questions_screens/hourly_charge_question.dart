import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class HourlyChargeQuestion extends StatelessWidget {
  const HourlyChargeQuestion({Key? key}) : super(key: key);

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
                "Now, Let's set your hourly rate.",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font20),
              ),
              SizedBox(
                height: AddSize.size15,
              ),
              Text(
                "Clients will se this rate on your profile and in search result once you publish your profile. You can adjust your rate every time you submit a proposal",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textColor,
                    fontSize: AddSize.font12),
              ),
              SizedBox(
                height: AddSize.size30,
              ),
              Text(
                "Hourly Rate",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font16),
              ),
              Text(
                "Total amount the client will see",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textColor,
                    fontSize: AddSize.font12),
              ),
              SizedBox(
                height: AddSize.size5,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      obSecure: false.obs,
                      hintText: "".obs,
                      prefix: Icon(Icons.attach_money),
                    ),
                  ),
                  Text(
                    "/hour",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textColor.withOpacity(.49),
                        fontSize: AddSize.font18),
                  ),
                ],
              ),
              SizedBox(
                height: AddSize.size30,
              ),
              Text(
                "Unify Service Fee",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font16),
              ),
              Text(
                "The unify Service fee is 20% when you begin a contract with a new client. Once you bill over \$500 with your client, the fee will be 10%",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textColor,
                    fontSize: AddSize.font12),
              ),
              SizedBox(
                height: AddSize.size5,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      obSecure: false.obs,
                      hintText: "".obs,
                      prefix: Icon(Icons.attach_money),
                    ),
                  ),
                  Text(
                    "/hour",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textColor.withOpacity(.49),
                        fontSize: AddSize.font18),
                  ),
                ],
              ),
              SizedBox(
                height: AddSize.size30,
              ),
              Text(
                "Hourly Rate",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font16),
              ),
              Text(
                "The estimate amount you'll receive after service fees",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textColor,
                    fontSize: AddSize.font12),
              ),
              SizedBox(
                height: AddSize.size5,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      obSecure: false.obs,
                      hintText: "".obs,
                      prefix: Icon(Icons.attach_money),
                    ),
                  ),
                  Text(
                    "/hour",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textColor.withOpacity(.49),
                        fontSize: AddSize.font18),
                  ),
                ],
              ),
              SizedBox(
                height: AddSize.size30,
              ),
              Row(
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

            ],
          ),
        ),
      ),
    );
  }
}
