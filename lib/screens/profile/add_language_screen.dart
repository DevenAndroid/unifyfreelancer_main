import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../../controller/profie_screen_controller.dart';
import '../../repository/Add_language_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';
import '../../models/model_language_list.dart';

class AddLanguageScreen extends StatefulWidget {
  const AddLanguageScreen({Key? key}) : super(key: key);

  @override
  State<AddLanguageScreen> createState() => _AddLanguageScreenState();
}

class _AddLanguageScreenState extends State<AddLanguageScreen> {

  final controller = Get.put(ProfileScreenController());

  final TextEditingController languageController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  RxString selectedLanguage = "".obs;
  RxString selectedLevel = "".obs;

  RxList<Data> languageListData = <Data>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey();
  final RxList level = [
    "Basic",
    "Conversational",
    "Fluent",
    "Native or Bilingual",
  ].obs;

  RxList<Data> languageListDataTemp = <Data>[].obs;

  showBottomSheetForLanguage(context) {
    languageListDataTemp.clear();
    languageListDataTemp.addAll(languageListData);
    showFilterButtonSheet1(
        context: context,
        maxHeight: AddSize.screenHeight*.86,
        minimumHeight: AddSize.screenHeight*.85,
        titleText: "Select a language",
        widgets: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            TextFormField(
              onChanged: (value) {
                if (value.trim() != "") {
                  languageListDataTemp.clear();
                  for (var e in languageListData) {
                    if (e.name!.toLowerCase().contains(value.toLowerCase())) {
                      languageListDataTemp.add(e);
                    }
                  }
                } else {
                  languageListDataTemp.addAll(languageListData);
                }
              },
              decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: AddSize.size16),
                  filled: true,
                  hintText: 'Search Language',
                  hintStyle: const TextStyle(color: AppTheme.subText),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide:
                      const BorderSide(color: Colors.white, width: 0)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide:
                      const BorderSide(color: Colors.white, width: 0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide:
                      const BorderSide(color: Colors.white, width: 0)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide:
                      const BorderSide(color: Colors.white, width: 0)),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppTheme.subText.withOpacity(.3),
                    size: AddSize.size30,
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Obx(() {
              return ListView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  shrinkWrap: true,
                  itemCount: languageListDataTemp.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return RadioListTile(
                        title: Text(
                          languageListDataTemp[index].name
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
                        value: languageListDataTemp[index].name.toString(),
                        groupValue: selectedLanguage.value,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage.value = value.toString();
                            languageController.text = value.toString();
                            Get.back();
                          });
                        },
                      );
                    });
                  });
            })
          ],
        ));
  }

  showBottomSheetForLevel(context) {
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
                    contentPadding:
                    const EdgeInsets.all(0),
                    dense: true,
                    visualDensity: VisualDensity(
                        horizontal: -4, vertical: -4),
                    value: level[index].toString(),
                    groupValue: selectedLevel.value,
                    onChanged: (value) {
                      setState(() {
                        selectedLevel.value = value.toString();
                        levelController.text = value.toString();
                        Get.back();
                      });
                    },
                  );
                }),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    languageListData.addAll(controller.languages.data!);
    for (var item = 0; item < languageListData.length; item++) {
      for (var item1 in controller.model.value.data!.language!) {
        if (languageListData[item].name.toString() == item1.language) {
          print(languageListData[item].name.toString());
          languageListData.removeAt(item);
        }
      }
    }
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
        ),
        body: Form(
          key: formKey,
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
                        showBottomSheetForLanguage(context);
                      },
                      readOnly: true,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Please select language")
                      ]),
                      obSecure: false.obs,
                      controller: languageController,
                      hintText: "Select a language".obs,
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
                        showBottomSheetForLevel(context);
                      },
                      readOnly: true,
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "Please select language level")
                      ]),
                      controller: levelController,
                      obSecure: false.obs,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Select proficiency level".obs,
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
                  if (formKey.currentState!.validate()) {
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

  getMapData() {
    Map<String, dynamic>map = {};
    Map<String, dynamic>map1 = {};
    map["languages"] = map1;
    for(var item in controller.model.value.data!.language!){
      map1[item.language.toString()] = item.level.toString();
    }
    map1[selectedLanguage.value.toString()] = selectedLevel.value;
    return map;
  }
}
