import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../models/model_language_list.dart';
import '../../repository/languages_list_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/custom_textfield.dart';
import '../profile/edit_language_screen.dart';

class AddLanguageQuestionScreen extends StatefulWidget {
  const AddLanguageQuestionScreen({Key? key}) : super(key: key);

  @override
  State<AddLanguageQuestionScreen> createState() => _AddLanguageQuestionScreenState();
}

class _AddLanguageQuestionScreenState extends State<AddLanguageQuestionScreen> {

  final RxList level = [
    "Basic",
    "Conversational",
    "Fluent",
    "Native or Bilingual",
  ].obs;

  ModelLanguageList languages = ModelLanguageList();

  getLanguageData() {
    languagesListRepo().then((value) {
      languages = value;
      if (value.status == true) {
        print(languages);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    languageList.clear();
    getLanguageData();
  }

  RxList<AAA> languageList = <AAA>[].obs;
  final TextEditingController englishLevelController = TextEditingController();
  showBottomSheetForLevel(context,index1) {
    RxString selectedLevel = "".obs;
    if(index1 != -5) {
      selectedLevel.value = languageList[index1].level.toString();
    } else {
      selectedLevel.value = englishLevelController.text;
    }

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
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return RadioListTile(
                    title: Text(
                      level[index].toString(),
                      style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.darkBlueText,
                          fontWeight: FontWeight.w500),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    dense: true,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    value: level[index].toString(),
                    groupValue: selectedLevel.value,
                    onChanged: (value) {
                      setState(() {
                        selectedLevel.value = value.toString();
                        if(index1 != -5){
                          languageList[index1].level = value.toString();
                        } else {
                          englishLevelController.text = value.toString();
                        }
                        Get.back();
                      });
                    },
                  );
                }),
          ],
        ));
  }

  final GlobalKey<FormState> formKey = GlobalKey();

  getMapData() {
    Map<String, dynamic>map = {};
    Map<String, dynamic>map1 = {};
    map["languages"] = map1;
    map1["English"] = englishLevelController.text;
    for(var item in languageList){
      map1[item.language.toString()] = item.level;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AddSize.padding16),
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
            englishLanguage(),
            // Obx(() {
            //   return ListView.builder(
            //       itemCount: languageList.length,
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       itemBuilder: (context, index) {
            //         return Obx(() {
            //           return otherLanguageFields(
            //               language: languageList[index].language
            //                   .toString(),
            //               index: index,
            //               level: languageList[index].level.toString());
            //         });
            //       });
            // })

          ],
        ),
      ),
    );
  }

  otherLanguageFields({
    required language,
    required level,
    required index,
  }) {
    final TextEditingController levelController = TextEditingController();
    levelController.text = level;
    return Padding(
      padding: EdgeInsets.only(bottom: AddSize.size20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                CustomTextField(
                    readOnly: true,
                    enabled: false,
                    obSecure: false.obs,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "$language".obs),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  onTap: (){
                    showBottomSheetForLevel(context,index);
                  },
                  controller: levelController,
                  readOnly: true,
                  obSecure: false.obs,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "".obs,
                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              languageList.removeAt(index);
            },
            child: Container(
              margin: EdgeInsets.only(left: 15),
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
    );
  }

  Column englishLanguage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Language",
                style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.titleText,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(width: AddSize.size16,),
            Expanded(
              child: Text(
                "Proficiency level",
                style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.titleText,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                readOnly: true,
                enabled: false,
                obSecure: false.obs,
                keyboardType: TextInputType.emailAddress,
                hintText: "English".obs,
              ),
            ),
            SizedBox(width: AddSize.size16,),
            Expanded(
              child: CustomTextField(
              readOnly: true,
              obSecure: false.obs,
              onTap: (){
                showBottomSheetForLevel(context, -5);
              },
              controller: null,
              validator: MultiValidator([
                RequiredValidator(errorText: "Language level required")
              ]),
              keyboardType: TextInputType.emailAddress,
              hintText: "".obs,
              suffixIcon: Icon(Icons.keyboard_arrow_down),
            ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        // Text(
        //   "Proficiency level",
        //   style: TextStyle(
        //       fontSize: 14,
        //       color: AppTheme.titleText,
        //       fontWeight: FontWeight.w600),
        // ),
        // SizedBox(
        //   height: 5,
        // ),
        // CustomTextField(
        //   readOnly: true,
        //   obSecure: false.obs,
        //   onTap: (){
        //     showBottomSheetForLevel(context, -5);
        //   },
        //   controller: null,
        //   validator: MultiValidator([
        //     RequiredValidator(errorText: "Language level required")
        //   ]),
        //   keyboardType: TextInputType.emailAddress,
        //   hintText: "".obs,
        //   suffixIcon: Icon(Icons.keyboard_arrow_down),
        // ),
        // SizedBox(
        //   height: 15,
        // ),
        Divider(
          color: AppTheme.pinkText.withOpacity(.29),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
