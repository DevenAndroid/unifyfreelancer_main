import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/model_language_list.dart';
import '../../repository/languages_list_repository.dart';
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
  RxList level = [
    "Basic",
    "Conversational",
    "Fluent",
    "Native or Bilingual",
  ].obs;

  Rx selectedLanguage = "".obs;
  Rx selectedLevel = "".obs;

  ModelLanguageList languages = ModelLanguageList();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    languagesListRepo().then((value) {
      languages = value;
      if (value.status == true) {
        print(languages);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar(
              isLikeButton: false,
              isProfileImage: false,
              titleText: "Add Language",
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
                        showFilterButtonSheet1(
                            context: context,
                            titleText: "Select a language",
                            widgets: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                ListView.builder(
                                    padding: EdgeInsets.only(bottom: 20),
                                    shrinkWrap: true,
                                    itemCount: languages.data!.length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return RadioListTile(
                                        title: Text(
                                          languages.data![index].name
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.darkBlueText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        contentPadding:
                                        const EdgeInsets.all(0),
                                        dense: true,
                                        visualDensity: VisualDensity(
                                            horizontal: -4, vertical: -4),
                                        value: languages.data![index].name
                                            .toString(),
                                        groupValue: selectedLanguage.value,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedLanguage.value =
                                                value.toString();
                                            Get.back();
                                          });
                                        },
                                      );
                                    })
                              ],
                            ));
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
                        showFilterButtonSheet1(
                            context: context,
                            titleText: "To (or expected graduation year)",
                            widgets: Column(
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
                                      return RadioListTile(
                                        title: Text(
                                          level[index].toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.darkBlueText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        contentPadding:
                                        const EdgeInsets.all(0),
                                        dense: true,
                                        visualDensity: VisualDensity(
                                            horizontal: -4, vertical: -4),
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
                                    })
                              ],
                            ));
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
                onPressed: () {
                  print(getMapData());
                },
                textColor: AppTheme.whiteColor,
                expandedValue: false,
              ),
            ),
          ),
        ]));
  }
  getMapData(){
    Map<String,dynamic>map = {};
    Map<String,dynamic>map1 = {};
    map1["11111"] = "222";
    map1["222222"] = "33444";

    for(var i = 0; i<languages.data!.length; i++){
      map[languages.data![i].name.toString()] = selectedLevel.value;
    }


    return map;
  }
}
