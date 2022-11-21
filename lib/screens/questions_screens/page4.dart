import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/repository/edit_designation_info_repository.dart';

import '../../controller/question_controller.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class Page4 extends StatelessWidget {
  Page4({Key? key}) : super(key: key);
  final controller = Get.put(QuestionController());
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
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
                  "Got it. Now, add a title to tell the world what you do",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "It's the very first thing clients see, so make it count. Stand out by describing your expertise in your own words.",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font12),
                ),
                SizedBox(
                  height: AddSize.size20,
                ),
                CustomTextField(
                  controller: controller.textEditingController,
                  validator: (value){
                    if(value!.trim().isEmpty){
                      return "Example: Full StackDeveloper | Web & Mobile";
                    } else {
                      return null;
                    }
                  },
                  obSecure: false.obs,
                  hintText: "Example: Full StackDeveloper | Web & Mobile".obs,
                ),
                SizedBox(
                  height: AddSize.size20,
                ),

              ],
            ),
          ),
        ),
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
                    if(formKey.currentState!.validate()) {
                      questionDesignation(controller.textEditingController.text.trim(), "", context).then((value){
                        controller.nextPage();
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
