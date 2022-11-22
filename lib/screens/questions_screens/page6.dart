import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/question_controller.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';

class Page6 extends StatefulWidget {
   Page6({Key? key}) : super(key: key);

  @override
  State<Page6> createState() => _Page6State();
}

class _Page6State extends State<Page6> {
   RxBool acceptTermsOrPrivacy = false.obs;

   final controller = Get.put(QuestionController());

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
                  "Clients like to know what you know - add your education here.",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "You don't have to have a degree. Adding any relevant education helps make your profile visible",
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
                            "Oxford University",
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
                        "Bachelor of engineering",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor,
                            fontSize: AddSize.font16),
                      ),
                      Text(
                        "(BEng), Computer Science 2016-2017",
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
                  title: '+  Add Education',
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: AddSize.padding16).copyWith(bottom: AddSize.padding14),
        child: Row(
          children: [
            Expanded(
              child: CustomOutlineButton(
                title: "Back",
                backgroundColor: AppTheme.whiteColor,
                textColor: AppTheme.primaryColor,
                expandedValue: false,
                onPressed: () {
                  controller.previousPage();
                },
              ),
            ),
            SizedBox(width: AddSize.size20,),
            Expanded(
              child: CustomOutlineButton(
                title: "Next",
                backgroundColor: AppTheme.primaryColor,
                textColor: AppTheme.whiteColor,
                expandedValue: false,
                onPressed: () {
                  controller.nextPage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
