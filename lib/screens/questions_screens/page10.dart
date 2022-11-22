import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class Page10 extends StatelessWidget {
   Page10({Key? key}) : super(key: key);

final TextEditingController _serviceController = TextEditingController();

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
                "What are the main services you offer?",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font20),
              ),
              SizedBox(
                height: AddSize.size15,
              ),
              Text(
                "Choose at least 1 service that best describes the type of work you do. this helps us match you with clients who need your unique expertise.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textColor,
                    fontSize: AddSize.font12),
              ),
              SizedBox(
                height: AddSize.size20,
              ),
              CustomTextField(
                onTap: () {
                  showFilterButtonSheet(
                      context: context,
                      titleText: "Select a service",
                      widgets: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: AppTheme.pinkText.withOpacity(.49),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 100,
                              itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: (){
                                  Get.back();
                                },
                                child: Text(
                                  "Accounting & Consulting",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.darkBlueText,
                                      fontSize: AddSize.font16),
                                ),
                              ),
                            );
                          })
                        ],
                      ));
                },
                controller: _serviceController,
                readOnly: true,
                obSecure: false.obs,
                hintText: "Search for a service".obs,
                suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
              ),
              SizedBox(
                height: AddSize.size20,
              ),
              Text(
                "Suggested services",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font16),
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
                onPressed: () {},
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
