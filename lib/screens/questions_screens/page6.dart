import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/models/model_freelancer_profile.dart';
import 'package:unifyfreelancer/repository/delete_education_info_repository.dart';
import '../../controller/profie_screen_controller.dart';
import '../../models/model_degree_list.dart';
import '../../repository/degree_list_repository.dart';
import '../../repository/edit_education_info_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/add_text.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class Page6 extends StatefulWidget {
  Page6({Key? key}) : super(key: key);

  @override
  State<Page6> createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  RxBool acceptTermsOrPrivacy = false.obs;

  final controller = Get.put(ProfileScreenController());

  RxList yearsList = [].obs;
  RxList yearsList2 = [].obs;


  showDeleteDialog({
    required Education item,
  }) {
    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: AddText(
                text: "Are you sure you want to delete this?",
                fontSize: AddSize.font16,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: AppTheme.primaryColor,
                        backgroundColor: AppTheme.primaryColor,
                        padding:
                        EdgeInsets.symmetric(horizontal: AddSize.size20)),
                    child: AddText(
                      text: "Cancel",
                      color: Colors.white,
                      fontSize: AddSize.font16,
                    )),
                SizedBox(
                  width: AddSize.size5,
                ),
                ElevatedButton(
                    onPressed: () {
                      deleteEducationInfoRepo(item.id.toString(), context)
                          .then((value) {
                        if (value.status == true) {
                          controller.model.value.data!.employment!.remove(item);
                          controller.getData();
                          Get.back();
                        }
                        showToast(value.message.toString());
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.red,
                        padding:
                        EdgeInsets.symmetric(horizontal: AddSize.size20)),
                    child: AddText(
                      text: "Delete",
                      color: Colors.white,
                      fontSize: AddSize.font16,
                    )),
              ],
            );
          });
    } else {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: AddText(
                text: "Are you sure you want to delete this?",
                fontSize: AddSize.font16,
              ),
              actions: [
                CupertinoButton(
                    onPressed: () {
                      Get.back();
                    },
                    // style: TextButton.styleFrom(
                    //     foregroundColor: AppTheme.primaryColor,
                    //     backgroundColor: AppTheme.primaryColor,
                    //     padding: EdgeInsets.symmetric(horizontal: AddSize.size20)
                    // ),
                    child: AddText(
                      text: "Cancel",
                      color: AppTheme.primaryColor,
                      fontSize: AddSize.font16,
                    )),
                CupertinoButton(
                    onPressed: () {
                      deleteEducationInfoRepo(item.id.toString(), context)
                          .then((value) {
                        if (value.status == true) {
                          controller.model.value.data!.employment!.remove(item);
                          controller.getData();
                          Get.back();
                        }
                        showToast(value.message.toString());
                      });
                    },
                    child: AddText(
                      text: "Delete",
                      color: AppTheme.primaryColor,
                      fontSize: AddSize.font16,
                    )),
              ],
            );
          });
    }
  }

  Rx<ModelDegreeList> degree = ModelDegreeList().obs;

  showEducationDialog(Education item) {
    Rx time = "".obs;
    Rx time2 = "".obs;
    Rx selectedDegree = "".obs;

    final _formKey = GlobalKey<FormState>();
    TextEditingController _schoolController = TextEditingController();
    TextEditingController _fromController = TextEditingController();
    TextEditingController _toController = TextEditingController();
    TextEditingController _degreeController = TextEditingController();
    TextEditingController _areaController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();

    _schoolController.text = item.school ?? "";
    _fromController.text = item.startYear ?? "";
    time.value = item.startYear ?? "";
    _toController.text = item.endYear ?? "";
    time2.value = item.endYear ?? "";
    _degreeController.text = item.degree ?? "";
    selectedDegree.value = item.degree ?? "";
    _areaController.text = item.areaStudy ?? "";
    _descriptionController.text = item.description ?? "";

    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: AddSize.padding16,vertical: AddSize.size100 * .4),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(AddSize.size10),
                        margin: EdgeInsets.all(AddSize.size10),
                        decoration: BoxDecoration(
                          color: AppTheme.whiteColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AddSize.size10),
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
                                    fontSize: AddSize.size14,
                                    color: AppTheme.titleText,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: AddSize.size5,
                              ),
                              CustomTextField(
                                controller: _schoolController,
                                obSecure: false.obs,
                                keyboardType: TextInputType.text,
                                hintText: "Ex: Northwestern University".obs,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'School is required'),
                                ]),
                              ),
                              SizedBox(
                                height: AddSize.size15,
                              ),
                              Text(
                                "Start date",
                                style: TextStyle(
                                    fontSize: AddSize.size14,
                                    color: AppTheme.titleText,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: AddSize.size5,
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
                                              height: AddSize.size15,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                reverse: true,
                                                itemCount: yearsList2.length,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Obx(() {
                                                    return RadioListTile(
                                                      title: Text(
                                                        yearsList2[index]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: AddSize.size15,
                                                            color: AppTheme
                                                                .darkBlueText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      dense: true,
                                                      visualDensity:
                                                          VisualDensity(
                                                              horizontal: -4,
                                                              vertical: -4),
                                                      value: yearsList2[index]
                                                          .toString(),
                                                      groupValue: time2.value,
                                                      onChanged: (value) {
                                                          time2.value =
                                                              value.toString();
                                                          _fromController.text =
                                                              value.toString();
                                                          print(_fromController
                                                              .text);
                                                          Get.back();
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
                                controller: _fromController,
                                hintText: "From".obs,
                                suffixIcon: Icon(Icons.keyboard_arrow_down),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'From year is required'),
                                ]),
                              ),
                              SizedBox(
                                height: AddSize.size15,
                              ),
                              Text(
                                "Proficiency level",
                                style: TextStyle(
                                    fontSize: AddSize.size14,
                                    color: AppTheme.titleText,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: AddSize.size5,
                              ),
                              CustomTextField(
                                onTap: () {
                                  showFilterButtonSheet(
                                      context: context,
                                      titleText:
                                          "To (or expected graduation year)",
                                      widgets: Obx(() {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: AddSize.size15,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                reverse: true,
                                                itemCount: yearsList.length,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Obx(() {
                                                    return RadioListTile(
                                                      title: Text(
                                                        yearsList[index]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: AddSize.size15,
                                                            color: AppTheme
                                                                .darkBlueText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      contentPadding: const EdgeInsets.all(0),
                                                      dense: true,
                                                      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                                      value: yearsList[index].toString(),
                                                      groupValue: time.value,
                                                      onChanged: (value) {
                                                          time.value = value.toString();
                                                          _toController.text = value.toString();
                                                          print(_toController.text);
                                                          Get.back();
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
                                controller: _toController,
                                hintText:
                                    "To (or expected graduation year)".obs,
                                suffixIcon: Icon(Icons.keyboard_arrow_down),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'To year is required'),
                                ]),
                              ),
                              SizedBox(
                                height: AddSize.size15,
                              ),
                              Text(
                                "Degree",
                                style: TextStyle(
                                    fontSize: AddSize.size14,
                                    color: AppTheme.titleText,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: AddSize.size5,
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
                                              height: AddSize.size15,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                reverse: true,
                                                itemCount:
                                                    degree.value.data!.length,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return Obx(() {
                                                    return RadioListTile(
                                                      title: Text(
                                                        degree.value
                                                            .data![index].title
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: AddSize.size15,
                                                            color: AppTheme
                                                                .darkBlueText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      dense: true,
                                                      visualDensity:
                                                          VisualDensity(
                                                              horizontal: -4,
                                                              vertical: -4),
                                                      value: degree.value
                                                          .data![index].title
                                                          .toString(),
                                                      groupValue: selectedDegree.value,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedDegree.value = value.toString();
                                                          _degreeController.text = value.toString();
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
                                controller: _degreeController,
                                hintText: "Degree".obs,
                                suffixIcon: Icon(Icons.keyboard_arrow_down),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Degree is required'),
                                ]),
                              ),
                              SizedBox(
                                height: AddSize.size15,
                              ),
                              Text(
                                "Area of Study (Optional)",
                                style: TextStyle(
                                    fontSize: AddSize.size14,
                                    color: AppTheme.titleText,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: AddSize.size15,
                              ),
                              CustomTextField(
                                obSecure: false.obs,
                                controller: _areaController,
                                keyboardType: TextInputType.text,
                                hintText: "Ex: Computer Science".obs,
                              ),
                              SizedBox(
                                height: AddSize.size15,
                              ),
                              Text(
                                "Description (Optional)",
                                style: TextStyle(
                                    fontSize: AddSize.size14,
                                    color: AppTheme.titleText,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: AddSize.size14,
                              ),
                              CustomTextField(
                                isMulti: true,
                                obSecure: false.obs,
                                controller: _descriptionController,
                                hintText: "Description".obs,
                              ),
                            ])),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(AddSize.size10),
                            child: CustomOutlineButton(
                              title: 'Cancel',
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
                            padding: EdgeInsets.all(AddSize.size10),
                            child: CustomOutlineButton(
                              title: 'Save',
                              backgroundColor: AppTheme.primaryColor,
                              onPressed: () {
                                if(int.parse(_fromController.text.toString()) < int.parse(_toController.text.toString())
                                ){
                                  if (_formKey.currentState!.validate()) {
                                    questionEducation(
                                        id: item.id ?? "",
                                        school: _schoolController.text.trim(),
                                        start_year: _fromController.text.trim(),
                                        end_year: _toController.text.trim(),
                                        degree: _degreeController.text.trim(),
                                        area_study: _areaController.text.trim(),
                                        description: _descriptionController
                                            .text
                                            .trim(),
                                        context: context)
                                        .then((value) {
                                      if (value.status == true) {
                                        Get.back();
                                        controller.getData();
                                      }
                                      showToast(value.message.toString());
                                    });
                                  } else{
                                    showToast("End year must be grater then start year");
                                  }

                                }







                               
                              },
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
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
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

  getData() {
    degreeListRepo().then((value) {
      degree.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
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
                  "Clients like to know what you know - add your education here.",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "You don't have to have a degree. Adding any relevant education helps make your profile visible",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font12),
                ),
                SizedBox(
                  height: AddSize.size20,
                ),
                ListView.builder(
                    itemCount: controller.model.value.data!.education!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => educationData(
                        controller.model.value.data!.education![index])),
                SizedBox(
                  height: AddSize.size15,
                ),
                CustomOutlineButton(
                  title: '+  Add Education',
                  backgroundColor: AppTheme.whiteColor,
                  onPressed: () {
                    showEducationDialog(Education());
                  },
                  textColor: AppTheme.primaryColor,
                  expandedValue: true,
                ),
                SizedBox(
                  height: AddSize.size20,
                ),
                /*Row(
                  children: [
                    Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: acceptTermsOrPrivacy.value,
                        activeColor: AppTheme.primaryColor,
                        onChanged: (newValue) {
                          acceptTermsOrPrivacy.value = newValue!;
                          print(acceptTermsOrPrivacy.value);
                        }),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        "Nothing to Add? Check the box and keep going.",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textColor,
                            fontSize: AddSize.font14),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AddSize.size20,
                ),*/
              ],
            ),
          ),
        );
      }),
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
                  if (controller.model.value.data!.education!.isNotEmpty ) {
                  controller.nextPage();
                }
                else{
                  showToast("Please add at least one education");
                }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container educationData(Education item) {
    return Container(
      padding: EdgeInsets.all(AddSize.padding16),
      decoration: BoxDecoration(color: AppTheme.whiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.school ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: InkWell(
                  onTap: () {
                    showEducationDialog(item);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.whiteColor,
                        border: Border.all(color: Color(0xff707070))),
                    child: Icon(
                      Icons.edit,
                      color: AppTheme.primaryColor,
                      size: 15,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showDeleteDialog(item: item);
                },
                child: Container(
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
          SizedBox(
            height: AddSize.size20,
          ),
          Text(
            item.degree ?? "",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor,
                fontSize: AddSize.font16),
          ),
          Text(
            "${item.areaStudy ?? ""} ${item.startYear ?? ""} ${item.endYear != null ? "-" : ""} ${item.endYear ?? ""}",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppTheme.textColor,
                fontSize: AddSize.font14),
          ),
          // Text(
          //   "(BEng), Computer Science 2016-2017",
          //   style: TextStyle(
          //       fontWeight: FontWeight.w400,
          //       color: AppTheme.textColor,
          //       fontSize: AddSize.font14),
          // ),
        ],
      ),
    );
  }
}
