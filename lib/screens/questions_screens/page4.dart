import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/repository/edit_designation_info_repository.dart';

import '../../controller/profie_screen_controller.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class Page4 extends StatelessWidget {
  Page4({Key? key}) : super(key: key);
  final controller = Get.put(ProfileScreenController());
  final GlobalKey<FormState> formKey = GlobalKey();
  RxInt character = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Obx(() {
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
                    "Ok Great! Now we need a headline.",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkBlueText,
                        fontSize: AddSize.font20),
                  ),
                  SizedBox(
                    height: AddSize.size10,
                  ),
                  Text(
                    "This will be the first thing a client sees when looking for a freelancer. It'll also allow them to quickly get an overview of your skills. Be unique!",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font12),
                  ),
                  SizedBox(
                    height: AddSize.size20,
                  ),
                  CustomTextField(
                    controller: controller.titleController,
                    /* validator: (value){
                    if(value!.trim().isEmpty){
                      return "Example: Full StackDeveloper | Web & Mobile";
                    } else {
                      return null;
                    }
                  },*/
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Please enter your title'),
                      MinLengthValidator(3, errorText: 'title minimum length is 3 characters'),
                    ]),
                    obSecure: false.obs,
                    hintText: "Example: full stack developer | web & mobile".obs,
                  ),
                  SizedBox(
                    height: AddSize.size15,
                  ),
                  CustomTextField(
                    onChanged: (value) {
                      print(value);
                      character.value = value.length;
                    },
                    isMulti: true,
                    controller: controller.descriptionController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Please enter your description '),
                      MinLengthValidator(100,
                          errorText: 'Description minimum length is 100 characters'),
                      MaxLengthValidator(5000, errorText: "Description max length is 5000 characters"),
                    ]),
                    obSecure: false.obs,
                    hintText: "Description...".obs,
                  ),
                  SizedBox(
                    height: AddSize.size20,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "${5000 - character.value } Characters left",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkBlueText,
                          fontSize: AddSize.font14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16)
                .copyWith(bottom: AddSize.padding14),
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
                SizedBox(
                  width: AddSize.size20,
                ),
                Expanded(
                  child: CustomOutlineButton(
                    title: "Next",
                    backgroundColor: AppTheme.primaryColor,
                    textColor: AppTheme.whiteColor,
                    expandedValue: false,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        editDesignationInfoRepo(
                                title: controller.titleController.text.trim(),
                                description: controller.descriptionController.text.trim(),
                                context: context)
                            .then((value) {
                          log(jsonEncode(value));
                          if (value.status == true) {
                            controller.nextPage();
                          }
                          else {
                            showToast(value.message.toString());
                          }

                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
