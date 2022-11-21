import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';

class Page5 extends StatelessWidget {
  Page5({Key? key}) : super(key: key);
  RxBool acceptTermsOrPrivacy = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
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
                  "If you have relevant work experience, add it here",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "Freelancers who add their experience are twice as likely to win work. But if you're just starting out, you can still create a great profile. just head on the next page",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font12),
                ),
                SizedBox(
                  height: AddSize.size20,
                ),
                Container(
                  padding: EdgeInsets.all(AddSize.padding16),
                  decoration: BoxDecoration(
                      color: AppTheme.whiteColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Flutter developer",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textColor,
                                fontSize: AddSize.font18),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.whiteColor,
                                    border: Border.all(color: Color(0xff707070))),
                                child: Icon(
                                  Icons.edit,
                                  color: AppTheme.primaryColor,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.whiteColor,
                                  border: Border.all(color: Color(0xff707070))),
                              child: Icon(
                                Icons.delete,
                                color: AppTheme.primaryColor,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AddSize.size20,
                      ),
                      Text(
                        "Eoxysit",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor,
                            fontSize: AddSize.font16),
                      ),
                      Text(
                        "November 2016 - Present",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppTheme.textColor,
                            fontSize: AddSize.font14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                CustomOutlineButton(
                  title: '+  Add Experience',
                  backgroundColor: AppTheme.whiteColor,
                  onPressed: () {},
                  textColor: AppTheme.primaryColor,
                  expandedValue: true,
                ),
                SizedBox(
                  height: AddSize.size20,
                ),
                Row(
                  children: [
                    Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: acceptTermsOrPrivacy.value,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (newValue) {
                          acceptTermsOrPrivacy.value = newValue!;
                          print(acceptTermsOrPrivacy.value);
                        }),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        "Nothing to Add? Check the box and keep going.",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textColor,
                            fontSize: AddSize.font14),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AddSize.size20,
                ),

              ],
            ),
          ),
        );
      }),
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
