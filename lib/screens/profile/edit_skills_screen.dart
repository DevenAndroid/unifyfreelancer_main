
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/controller/profie_screen_controller.dart';
import '../../models/model_skill_list_response.dart';
import '../../repository/skill_list_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
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
  RxList<Data> skillListData = <Data>[].obs;
  RxList<Data> currentListData = <Data>[].obs;
  Rx<RxStatus> status = RxStatus.empty().obs;

  TextEditingController textEditingController = TextEditingController();

  RxBool showSkillsList = false.obs;

  @override
  void initState() {
    super.initState();
    getData();

    for (var item in controller.model.value.data!.skills!) {
      currentListData.add(Data(id: item.skillId, name: item.skillName));
    }

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
      skillListData.clear();
      if (value.status == true) {
        if (skillList.data!.isNotEmpty) {
          skillListData.addAll(skillList.data!);
        }
        status.value = RxStatus.success();
      } else {
        status.value = RxStatus.error();
      }
      for (var i = 0; i < skillListData.length; i++) {
        for (var item2 in currentListData) {
          if (skillListData[i].id.toString() == item2.id.toString()) {
            skillListData.removeAt(i);
          }
        }
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
                          onTap: (){
                            showFilterButtonSheet(context: context, titleText: "Search skills", widgets: Column(
                              children: [
                                Wrap(
                                    children: List.generate(
                                        currentListData.length,
                                            (index) => Padding(
                                          padding: const EdgeInsets.only(right: 4.0),
                                          child: Chip(
                                            elevation: 1,
                                            backgroundColor: Color(0xffEAEEF2),
                                            label: Text(
                                              "${currentListData[index].name.toString()}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff393939)),
                                            ),
                                            deleteIcon: Icon(
                                              Icons.clear,
                                              size: 15,
                                            ),
                                            onDeleted: () {
                                              for (var item in skillList.data!) {
                                                if (currentListData[index]
                                                    .id
                                                    .toString() ==
                                                    item.id.toString()) {
                                                  print(item.id);
                                                  currentListData.removeAt(index);
                                                  skillListData.add(item);
                                                  break;
                                                }
                                              }
                                            },
                                          ),
                                        ))),
                                SizedBox(
                                  height: 20,
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

                                    controller: textEditingController,
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
                                  height: MediaQuery.of(context).size.height,
                                ),
                              ],
                            ));
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
                      if (showSkillsList.value)
                        Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * .5,
                              minHeight: 0),
                          // height: MediaQuery.of(context).size.height*.5,
                          color: Colors.red,
                          child: ListView.builder(
                              itemCount: skillListData.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    currentListData.add(Data(
                                        name: skillListData[index].name,
                                        id: skillListData[index].id));
                                    skillListData.removeAt(index);
                                  },
                                  child: Card(
                                      child: Text(skillListData[index]
                                          .name
                                          .toString()
                                          .capitalizeFirst!)),
                                );
                              }),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      Wrap(
                          children: List.generate(
                              currentListData.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Chip(
                                      elevation: 1,
                                      backgroundColor: Color(0xffEAEEF2),
                                      label: Text(
                                        "${currentListData[index].name.toString()}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff393939)),
                                      ),
                                      deleteIcon: Icon(
                                        Icons.clear,
                                        size: 15,
                                      ),
                                      onDeleted: () {
                                        for (var item in skillList.data!) {
                                          if (currentListData[index]
                                                  .id
                                                  .toString() ==
                                              item.id.toString()) {
                                            print(item.id);
                                            currentListData.removeAt(index);
                                            skillListData.add(item);
                                            break;
                                          }
                                        }
                                      },
                                    ),
                                  ))),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "maximum 15 skills",
                        style:
                            TextStyle(fontSize: 12, color: AppTheme.textColor),
                      ),
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
                          String ids = "";
                          for (var item in currentListData) {
                            if (ids == "") {
                              ids = item.id.toString();
                            } else {
                              ids = ids + "," + item.id.toString();
                            }
                          }
                          print(ids);
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
