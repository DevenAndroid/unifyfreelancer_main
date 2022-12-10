import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../../controller/profie_screen_controller.dart';
import '../../models/model_skill_list_response.dart';
import '../../repository/skill_list_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/add_text.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/progress_indicator.dart';

class Page8 extends StatefulWidget {
  Page8({Key? key}) : super(key: key);

  @override
  State<Page8> createState() => _Page8State();
}

class _Page8State extends State<Page8> {
  final controller = Get.put(ProfileScreenController());

  ModelSkillListResponse skillList = ModelSkillListResponse();
  Rx<RxStatus> status = RxStatus.empty().obs;

  @override
  void initState() {
    super.initState();
    getData();

  }

  getData() {
    skillListRepo().then((value) {
      skillList = value;
      if (value.status == true) {

        status.value = RxStatus.success();
      } else {
        status.value = RxStatus.error();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: status.value.isSuccess
            ? Container(
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
                        "Time to show off your skills!",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkBlueText,
                            fontSize: AddSize.font20),
                      ),
                      SizedBox(
                        height: AddSize.size15,
                      ),
                      Text(
                        "Skills will show up on your profile and help you stand out to clients. It'll also help us recommend jobs for you.",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textColor,
                            fontSize: AddSize.font12),
                      ),
                      SizedBox(
                        height: AddSize.size20,
                      ),
                      Text(
                        "We've pre-populated this based on the information you've given us, but feel free to add more!",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textColor,
                            fontSize: AddSize.font12),
                      ),
                      SizedBox(
                        height: AddSize.size20,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(.04),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Your skills*",
                                style: TextStyle(
                                    fontSize: AddSize.font18,
                                    color: AppTheme.titleText,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              width: AddSize.size16,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(MyRouter.editSkillsScreen);
                              },
                              child: Container(
                                padding: EdgeInsets.all(AddSize.size5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.whiteColor,
                                    border:
                                    Border.all(color: Color(0xff707070))),
                                child: Icon(
                                  Icons.add,
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
                      SizedBox(
                        height: AddSize.size20,
                      ),
                      /*  CustomTextField(
                onTap: () {
                  Get.toNamed(MyRouter.editSkillsScreen);
                },
                readOnly: true,
                obSecure: false.obs,
                hintText: "Example: Full StackDeveloper | Web & Mobile".obs,
              ),*/
                      Container(
                        padding: EdgeInsets.all(AddSize.padding12 * .3),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                          color: AppTheme.whiteColor,
                          border: Border.all(
                              color: AppTheme.primaryColor.withOpacity(.15),
                              width: 1.0),
                        ),
                        child: SizedBox(
                          height: 35,
                          child: ListView.builder(
                            itemCount: controller.model.value.data!.skills!.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Chip(
                                    label: AddText(
                                      text: controller.model.value.data!.skills![index].skillName.toString()
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "Max 10 Skills",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font14),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size20,
                      ),
                      Text(
                        "Suggested skills",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkBlueText,
                            fontSize: AddSize.font18),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child:
                              Text(
                                  skillList.data![index]
                                      .name
                                      .toString()
                                      .capitalizeFirst!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.textColor,
                                    fontSize: AddSize.font12),
                              ),
                            /*  Chip(
                                label: AddText(
                                  text: skillList.data![index]
                                      .name
                                      .toString()
                                      .capitalizeFirst!,
                                ),
                              ),*/
                            );
                          })
                    ],
                  ),
                ),
              )
            : status.value.isError
                ? CommonErrorWidget(
                    errorText: skillList.message.toString(),
                    onTap: () {
                      getData();
                    },
                  )
                : CommonProgressIndicator(),
        bottomNavigationBar: Obx(() {
          return status.value.isSuccess ? Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomOutlineButton(
                    title: 'Back',
                    backgroundColor: AppTheme.whiteColor,
                    onPressed: () {
                     controller.previousPage();
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
                      if (controller.model.value.data!.skills!.isNotEmpty ) {
                        controller.nextPage();
                      }
                      else{
                        showToast("Please add at least one skill");
                      }
                    },
                    textColor: AppTheme.whiteColor,
                    expandedValue: false,
                  ),
                ),
              ),
            ],
          ) : SizedBox();
        }),
      );
    });
  }
}
