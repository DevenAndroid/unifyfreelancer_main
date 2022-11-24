import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import '../../controller/profie_screen_controller.dart';
import '../../models/model_language_list.dart';
import '../../repository/languages_list_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';
import '../profile/edit_language_screen.dart';

class Page7 extends StatefulWidget {
  const Page7({Key? key}) : super(key: key);

  @override
  State<Page7> createState() => _Page7State();
}

class _Page7State extends State<Page7> {
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

  showBottomSheetForLevel(context, index1) {
    RxString selectedLevel = "".obs;
    if (index1 != -5) {
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
                        if (index1 != -5) {
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
    Map<String, dynamic> map = {};
    Map<String, dynamic> map1 = {};
    map["languages"] = map1;
    map1["English"] = englishLevelController.text;
    for (var item in languageList) {
      map1[item.language.toString()] = item.level;
    }
    return map;
  }

  final controller = Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                  "Looking good. Next, tell us which languages you speak.",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "Unify is global, so clients are often interested to know what languages you speak. English is a must, but do you speak any other languages?",
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
// <<<<<<< HEAD:lib/screens/questions_screens/add_language_screen.dart
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
                    controller.nextPage();
                  },
                ),
              ),
            ],
            // =======
            //             ],
          ),
        )
        // >>>>>>> dev_branch:lib/screens/questions_screens/page7.dart
        //         ),
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
                  onTap: () {
                    showBottomSheetForLevel(context, index);
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
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(.04),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Languages",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: AddSize.size16,
              ),
              InkWell(
                onTap: () {
                 Get.toNamed(MyRouter.editLanguageScreen);
                },
                child: Container(
                  padding: EdgeInsets.all(AddSize.size5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.whiteColor,
                      border:
                      Border.all(color: Color(0xff707070))),
                  child: Icon(
                    Icons.edit,
                    color: AppTheme.primaryColor,
                    size: AddSize.size15,
                  ),
                ),
              ),
             /* Expanded(
                child: Text(
                  "Proficiency level",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
              ),*/
            ],
          ),
        ),
        /*SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "English",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleText,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                width: AddSize.size16,
              ),
              Expanded(
                child: CustomTextField(
                  readOnly: true,
                  obSecure: false.obs,
                  onTap: () {
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
        ),

        SizedBox(
          height: 10,
        ),*/
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
        /*Divider(
          color: AppTheme.pinkText.withOpacity(.29),
        ),*/

        SizedBox(
          height: AddSize.size15,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.model.value.data!.language!.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(bottom: 10),
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller
                            .model.value.data!.language![index].language
                            .toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkBlueText,
                            fontSize: AddSize.font14),
                      ),
                      Text(
                        controller
                            .model.value.data!.language![index].level.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textColor,
                            fontSize: AddSize.font14),
                      ),
                     /* InkWell(
                        onTap: () {
                          //   showDeleteDialog();
                        },
                        child: Container(
                          padding: EdgeInsets.all(AddSize.size5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.whiteColor,
                              border:
                              Border.all(color: Color(0xff707070))),
                          child: Icon(
                            Icons.delete,
                            color: AppTheme.primaryColor,
                            size: AddSize.size15,
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              );
            }),
        SizedBox(
          height: AddSize.size15,
        ),
        CustomOutlineButton(
          title: '+  Add a language',
          backgroundColor: AppTheme.whiteColor,
          onPressed: () {
            Get.toNamed(MyRouter.addLanguageScreen);
          },
          textColor: AppTheme.primaryColor,
          expandedValue: true,
        ),
        SizedBox(
          height: AddSize.size20,
        ),
      ],
    );
  }
}
