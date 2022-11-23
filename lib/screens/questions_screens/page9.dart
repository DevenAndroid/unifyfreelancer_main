/*
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../../controller/profie_screen_controller.dart';
import '../../repository/edit_designation_info_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class Page9 extends StatefulWidget {
  Page9({Key? key}) : super(key: key);

  @override
  State<Page9> createState() => _Page9State();
}

class _Page9State extends State<Page9> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ProfileScreenController());

  RxInt character = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Form(
          key: _formKey,
          child: Container(
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
                    "Great! Now write a bio to tell the world about yourself.",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkBlueText,
                        fontSize: AddSize.font20),
                  ),
                  SizedBox(
                    height: AddSize.size15,
                  ),
                  Text(
                    "Help people get to know you at a glance. What work are you best at? Tell them clearly, using paragraphs or bullet point, you can always edit later-just make sure you proofread now!",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font12),
                  ),
                  SizedBox(
                    height: AddSize.size20,
                  ),
                  CustomTextField(
                    onChanged: (value) {
                      print(value);
                      character.value = value.length;
                    },
                    controller: controller.descriptionController,
                    isMulti: true,
                    obSecure: false.obs,
                    hintText: "Description".obs,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Description is required'),
                      MinLengthValidator(
                          100, errorText: "Minimum length is 100"),
                      MaxLengthValidator(5000, errorText: "Max length is 5000")
                    ]),
                  ),
                  SizedBox(
                    height: AddSize.size10,
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
                  SizedBox(
                    height: AddSize.size20,
                  ),
                ],
              ),
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
                  if (_formKey.currentState!.validate()) {
                    editDesignationInfoRepo(title: "",
                        description: controller.descriptionController.text.trim(), context: context).then((value){
                      log(jsonEncode(value));
                      if(value.status == true) {
                        controller.nextPage();
                      }
                      showToast(value.message.toString());
                    });
                  }
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
*/
