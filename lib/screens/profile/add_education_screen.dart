import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/widgets/custom_appbar.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class AddEducationScreen extends StatefulWidget {
  const AddEducationScreen({Key? key}) : super(key: key);

  @override
  State<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  RxList yearsList = [].obs;
  RxList yearsList2 = [].obs;

  @override
  void initState() {
    super.initState();
    yearsList.clear();
    yearsList2.clear();
    var currentYear = DateTime.now().year;
    var currentYear2 = DateTime.now().year;
    for (var i = currentYear - 70; i < currentYear + 8; i++) {
      yearsList.add(i);
    }
    log(yearsList.toString());
    for (var i = currentYear2 - 70; i <= currentYear2; i++) {
      yearsList2.add(i);
    }
    log(yearsList2.toString());
  }

  RxList degree = [
    "BBA- Bachelor of Business Administration"
        "BMS- Bachelor of Management Science",
    "BFA- Bachelor of Fine Arts",
    "BEM- Bachelor of Event Management"
        "BEM- Bachelor of Event Management"
        "BghM- ",
    "ssd- ",
    "sdf- ",
    "xcc- ",
  ].obs;

  Rx time = "".obs;
  Rx time2 = "".obs;
  Rx selectedDegree = "".obs;

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
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 3)),
                    ] // changes position of shadow
                    ,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "School",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          obSecure: false.obs,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Ex: Northwestern University".obs,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Dates Attended (Optional)",
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
                                titleText: "From",
                                widgets: Obx(() {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          reverse: true,
                                          itemCount: yearsList2.length,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Obx(() {
                                              return RadioListTile(
                                                title: Text(
                                                  yearsList2[index].toString(),
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
                                                value: yearsList2[index]
                                                    .toString(),
                                                groupValue: time2.value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    time2.value =
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
                              "${time2.value == '' ? "Form" : time2.value.toString()}"
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
                                          shrinkWrap: true,
                                          reverse: true,
                                          itemCount: yearsList.length,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Obx(() {
                                              return RadioListTile(
                                                title: Text(
                                                  yearsList[index].toString(),
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
                                                    yearsList[index].toString(),
                                                groupValue: time.value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    time.value =
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
                              "${time.value == '' ? "To (or expected graduation year)" : time.value.toString()}"
                                  .obs,
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Degree (Optional)",
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
                                titleText: "Degree",
                                widgets: Obx(() {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          reverse: true,
                                          itemCount: degree.length,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Obx(() {
                                              return RadioListTile(
                                                title: Text(
                                                  degree[index].toString(),
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
                                                value: degree[index].toString(),
                                                groupValue:
                                                    selectedDegree.value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedDegree.value =
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
                              "${selectedDegree.value == '' ? "Degree (Optional)" : selectedDegree.value.toString()}"
                                  .obs,
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Area of Study (Optional)",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          obSecure: false.obs,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Ex: Computer Science".obs,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Description (Optional)",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          isMulti: true,
                          obSecure: false.obs,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Description".obs,
                        ),
                      ])),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomOutlineButton(
                        title: 'Cancel',
                        backgroundColor: AppTheme.whiteColor,
                        onPressed: () {},
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
                        onPressed: () => Get.back(),
                        textColor: AppTheme.whiteColor,
                        expandedValue: false,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
