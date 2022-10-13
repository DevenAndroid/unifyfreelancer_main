import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class AddLanguageScreen extends StatefulWidget {
  const AddLanguageScreen({Key? key}) : super(key: key);

  @override
  State<AddLanguageScreen> createState() => _AddLanguageScreenState();
}

class _AddLanguageScreenState extends State<AddLanguageScreen> {
  RxList language = [
    "English",
    "Hindi",
    "Spanish",
    "Gujarati",
    "Telugu",
  ].obs;
  RxList level = [
    "Basic",
    "Conversational",
    "Fluent",
    "Native or Bilingual",
  ].obs;

  Rx selectedLanguage = "".obs;
  Rx selectedLevel = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Add Education",
          )
          // onPressedForLeading:,
          ),
      body: Form(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Language",
                    style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.titleText,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    onTap: () {
                      showFilterButtonSheet(
                          context: context,
                          titleText: "Select a language",
                          widgets: Obx(() {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.only(bottom: 20),
                                    shrinkWrap: true,
                                    itemCount: language.length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Obx(() {
                                        return RadioListTile(
                                          title: Text(
                                            language[index].toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    AppTheme.darkBlueText,
                                                fontWeight:
                                                    FontWeight.w500),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          dense: true,
                                          visualDensity: VisualDensity(
                                              horizontal: -4,
                                              vertical: -4),
                                          value:
                                              language[index].toString(),
                                          groupValue:
                                              selectedLanguage.value,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedLanguage.value =
                                                  value.toString();
                                              Get.back();
                                            });
                                          },
                                        );
                                      });
                                    })
                              ],
                            );
                          }));
                    },
                    readOnly: true,
                    obSecure: false.obs,
                    keyboardType: TextInputType.emailAddress,
                    hintText:
                        "${selectedLanguage.value == '' ? "Select a language" : selectedLanguage.value.toString()}"
                            .obs,
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Proficiency level",
                    style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.titleText,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    onTap: () {
                      showFilterButtonSheet(
                          context: context,
                          titleText: "To (or expected graduation year)",
                          widgets: Obx(() {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                ListView.builder(
                                    padding: EdgeInsets.only(bottom: 20),
                                    shrinkWrap: true,
                                    itemCount: level.length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Obx(() {
                                        return RadioListTile(
                                          title: Text(
                                            level[index].toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    AppTheme.darkBlueText,
                                                fontWeight:
                                                    FontWeight.w500),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          dense: true,
                                          visualDensity: VisualDensity(
                                              horizontal: -4,
                                              vertical: -4),
                                          value: level[index].toString(),
                                          groupValue: selectedLevel.value,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedLevel.value =
                                                  value.toString();
                                              Get.back();
                                            });
                                          },
                                        );
                                      });
                                    })
                              ],
                            );
                          }));
                    },
                    readOnly: true,
                    obSecure: false.obs,
                    keyboardType: TextInputType.emailAddress,
                    hintText:
                        "${selectedLevel.value == '' ? "Basic" : selectedLevel.value.toString()}"
                            .obs,
                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                  ),
                ]),
          ),
        ),
      ),
        bottomNavigationBar: Row(children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOutlineButton(
                title: 'cancel',
                backgroundColor: AppTheme.whiteColor,
                onPressed: () => Get.back(),
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
                onPressed: () {},
                textColor: AppTheme.whiteColor,
                expandedValue: false,
              ),
            ),
          ),
        ])
    );
  }
}
