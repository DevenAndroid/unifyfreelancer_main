import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../../controller/profie_screen_controller.dart';
import '../../models/model_language_list.dart';
import '../../repository/Add_language_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class EditLanguageScreen extends StatefulWidget {
  const EditLanguageScreen({Key? key}) : super(key: key);

  @override
  State<EditLanguageScreen> createState() => _EditLanguageScreenState();
}

class _EditLanguageScreenState extends State<EditLanguageScreen> {
  final controller = Get.put(ProfileScreenController());

  final RxList level = [
    "Basic",
    "Conversational",
    "Fluent",
    "Native or Bilingual",
  ].obs;

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

  @override
  void initState() {
    super.initState();
    languageList.clear();
    for (var item in controller.model.value.data!.language!) {
      if (item.language.toString().toLowerCase() != "english") {
        languageList.add(
            AAA(language: item.language.toString(), level: item.level.toString())
        );
      } else {
        englishLevelController.text = item.level.toString();
      }
    }
  }

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
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar(
              isLikeButton: false,
              isProfileImage: false,
              titleText: "Edit Language",
            )),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    englishLanguage(),
                    Obx(() {
                      return ListView.builder(
                          itemCount: languageList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return otherLanguageFields(
                                  language: languageList[index].language
                                      .toString(),
                                  index: index,
                                  level: languageList[index].level.toString());
                            });
                          });
                    })
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
                  if(formKey.currentState!.validate()){
                    editLanguageRepo(getMapData(), context).then((value) {
                      if (value.status == true) {
                        Get.back();
                        controller.getData();
                      }
                      showToast(value.message.toString());
                    });
                    if (kDebugMode) {
                      print(getMapData());
                    }
                  }
                },
                textColor: AppTheme.whiteColor,
                expandedValue: false,
              ),
            ),
          ),
        ]));
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
          readOnly: true,
          enabled: false,
          obSecure: false.obs,
          keyboardType: TextInputType.emailAddress,
          hintText: "English".obs,
        ),
        SizedBox(
          height: 10,
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
          readOnly: true,
          obSecure: false.obs,
          onTap: (){
            showBottomSheetForLevel(context, -5);
          },
          controller: englishLevelController,
          validator: MultiValidator([
            RequiredValidator(errorText: "Language level required")
          ]),
          keyboardType: TextInputType.emailAddress,
          hintText: "".obs,
          suffixIcon: Icon(Icons.keyboard_arrow_down),
        ),
        SizedBox(
          height: 15,
        ),
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


class AAA {
  String? language;
  String? level;

  AAA({this.language, this.level});
}
