import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/controller/profie_screen_controller.dart';
import '../../models/model_skill_list_response.dart';
import '../../repository/edit_skills_info_repository.dart';
import '../../repository/skill_list_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/add_text.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class EditSkillsScreen extends StatefulWidget {
  const EditSkillsScreen({Key? key}) : super(key: key);

  @override
  State<EditSkillsScreen> createState() => _EditSkillsScreenState();
}

class _EditSkillsScreenState extends State<EditSkillsScreen> {
  final controller = Get.put(ProfileScreenController());

  ModelSkillListResponse skillList = ModelSkillListResponse();
  RxList<Data> selectedList = <Data>[].obs;
  RxList<Data> tempList = <Data>[].obs;
  Rx<RxStatus> status = RxStatus.empty().obs;

  TextEditingController textEditingController = TextEditingController();

  RxBool showSkillsList = false.obs;

  @override
  void initState() {
    super.initState();
    getData();

    textEditingController.addListener(() {
      if (textEditingController.text.trim() != "") {
        showSkillsList.value = true;
      } else {
        showSkillsList.value = false;
      }
    });
  }

  getData() {
    skillListRepo().then((value) {
      skillList = value;
      if (value.status == true) {
        for(var item in controller.model.value.data!.skills!){
          log(item.skillId.toString());
          for(var i = 0; i<skillList.data!.length; i++){
            if(item.skillId.toString() == skillList.data![i].id.toString()){
              skillList.data![i].isSelected!.value = true;
              selectedList.add(skillList.data![i]);
            }
          }
        }
        status.value = RxStatus.success();
      } else {
        status.value = RxStatus.error();
      }
    });
  }

  showSkillsBottomSheet(context) {
    tempList.clear();
    tempList.addAll(skillList.data!);
    showFilterButtonSheet1(
        context: context,
        titleText: "Select Skills",
        minimumHeight: AddSize.screenHeight * .7,
        maxHeight: AddSize.screenHeight * .8,
        widgets: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                if (value.trim() != "") {
                  tempList.clear();
                  for (var e in skillList.data!) {
                    if (e.name!.toLowerCase().contains(value.toLowerCase())) {
                      tempList.add(e);
                    }
                  }
                } else {
                  tempList.addAll(skillList.data!);
                }
              },
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: AddSize.size16),
                  filled: true,
                  hintText: 'Search Skills',
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
              height: AddSize.size16,
            ),
            Obx(() {
              return Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.start,
                spacing: AddSize.size10,
                children: List.generate(
                    tempList.length,
                    (index) => Obx(() {
                          return FilterChip(
                              label: AddText(
                                text: tempList[index].name.toString(),
                                color: tempList[index].isSelected!.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              checkmarkColor: Colors.white,
                              selected: tempList[index].isSelected!.value,
                              selectedColor: AppTheme.primaryColor,
                              backgroundColor: Colors.white,
                              onSelected: (value) {
                                tempList[index].isSelected!.value = value;
                                for (var i = 0;
                                    i < skillList.data!.length;
                                    i++) {
                                  if (tempList[index].id.toString() ==
                                      skillList.data![i].id.toString()) {
                                    skillList.data![i].isSelected!.value =
                                        value;
                                    break;
                                  }
                                }
                                filterSelectedSkills();
                              });
                        })),
              );
            })
          ],
        ));
  }

  filterSelectedSkills() {
    selectedList.clear();
    for (var item in skillList.data!) {
      if (item.isSelected!.value == true) {
        selectedList.add(item);
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
          titleText: "Edit Skills",
          // onPressedForLeading:,
        ),
      ),
      body: Obx(() {
        return status.value.isSuccess
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Skills",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Keeping your skills up to date helps you get the jobs you want,",
                        style:
                            TextStyle(fontSize: 12, color: AppTheme.textColor),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.whiteColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: TextFormField(
                          onTap: () {
                            showSkillsBottomSheet(context);
                          },

                          readOnly: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: AppTheme.textColor, fontSize: 14),
                              filled: true,
                              fillColor: Colors.white24,
                              hintText: 'Search skills or add your own',
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              prefixIcon: Container(
                                padding: EdgeInsets.all(15),
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                  'assets/icon/Search.svg',
                                  color: Color(0xff756C87),
                                ),
                              )),
                          onChanged: (value) {},
                        ),
                      ),


                      SizedBox(
                        height: 20,
                      ),

                      Obx(() {
                        return Wrap(
                          spacing: AddSize.size10 * .82,
                          children: List.generate(
                              selectedList.length,
                              (index) => Chip(
                                  label: AddText(
                                    text: selectedList[index]
                                        .name
                                        .toString()
                                        .capitalizeFirst!,
                                  ),
                                  onDeleted: () {
                                    for (var i = 0;
                                        i < skillList.data!.length;
                                        i++) {
                                      if (selectedList[index].id.toString() ==
                                          skillList.data![i].id.toString()) {
                                        skillList.data![i].isSelected!.value =
                                            false;
                                        break;
                                      }
                                    }
                                    selectedList.removeAt(index);
                                  })),
                        );
                      }),

                    ],
                  ),
                ),
              )
            : status.value.isError
                ? SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(skillList.message.toString()
                            // fontSize: AddSize.font16,
                            ),
                        IconButton(
                            onPressed: () {
                              getData();
                            },
                            icon: Icon(
                              Icons.change_circle_outlined,
                              size: AddSize.size30,
                            ))
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
      }),
      bottomNavigationBar: Obx(() {
        return status.value.isSuccess
            ? Row(
                children: [
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
                          String skillIds = "";
                          for(var item in selectedList){
                            if(item.isSelected!.value == true){
                              if(skillIds == ""){
                                skillIds = item.id.toString();
                              } else {
                                skillIds = skillIds+","+item.id.toString();
                              }
                            }
                          }
                          log(skillIds);
                          editSkillsInfoRepo(
                            context: context,
                            skill_id: skillIds
                          ).then((value) {
                            if(value.status == true){
                              Get.back();
                              controller.getData();
                            }
                            showToast(value.message.toString());
                          });
                        },
                        textColor: AppTheme.whiteColor,
                        expandedValue: false,
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox();
      }),
    );
  }
}
