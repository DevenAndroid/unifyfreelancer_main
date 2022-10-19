import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';
import 'package:unifyfreelancer/widgets/custom_appbar.dart';

import '../../controller/profie_screen_controller.dart';
import '../../models/model_degree_list.dart';
import '../../repository/degree_list_repository.dart';
import '../../repository/edit_education_info_repository.dart';
import '../../resources/app_theme.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class AddEducationScreen extends StatefulWidget {
  const AddEducationScreen({Key? key}) : super(key: key);

  @override
  State<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  final controller = Get.put(ProfileScreenController());

  RxList yearsList = [].obs;
  RxList yearsList2 = [].obs;

  int load = -100;

  Rx<ModelDegreeList> degree = ModelDegreeList().obs;
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

    //For loading data

    if (Get.arguments != null) {
      load = Get.arguments;
      _schoolController.text =
          controller.model.value.data!.education![load].school.toString();
      _fromController.text =
          controller.model.value.data!.education![load].startYear.toString();
      _toController.text =
          controller.model.value.data!.education![load].endYear.toString();
      _degreeController.text =
          controller.model.value.data!.education![load].degree.toString();
      _areaController.text =
          controller.model.value.data!.education![load].areaStudy.toString();
      _descriptionController.text =
          controller.model.value.data!.education![load].description.toString();
    }
  }



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

  getData(){
    degreeListRepo().then((value) {
      degree.value = value ;
      if(value.status == true){
        setState(() {

        });
        if(kDebugMode){
          print(value);
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
            titleText: "Add Education",
          )
          // onPressedForLeading:,
          ),
      body: Form(
        key: _formKey,
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
                          controller: _schoolController,
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "Ex: Northwestern University".obs,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'School is required'),
                          ]),
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
                                                    _fromController.text =
                                                        value.toString();
                                                    print(_fromController.text);
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
                          controller: _fromController,
                          hintText: "From".obs,
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'From year is required'),
                          ]),
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
                                                    _toController.text =
                                                        value.toString();
                                                    print(_toController.text);
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
                          controller: _toController,
                          hintText: "To (or expected graduation year)".obs,
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'To year is required'),
                          ]),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Degree",
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
                                          itemCount: degree.value.data!.length,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Obx(() {
                                              return RadioListTile(
                                                title: Text(
                                                  degree.value.data![index].title.toString(),
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
                                                value:  degree.value.data![index].title.toString(),
                                                groupValue:
                                                    selectedDegree.value,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedDegree.value =
                                                        value.toString();
                                                    _degreeController.text =
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
                          controller: _degreeController,
                          hintText: "Degree".obs,
                          suffixIcon: Icon(Icons.keyboard_arrow_down),
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Degree is required'),
                          ]),
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
                          controller: _areaController,
                          keyboardType: TextInputType.text,
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
                          controller: _descriptionController,
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
                          if (_formKey.currentState!.validate()) {
                            editEducationInfoRepo(
                                    load == -100
                                        ? load
                                        : controller.model.value.data!
                                            .education![load].id,
                                    _schoolController.text.trim(),
                                    _fromController.text.trim(),
                                    _toController.text.trim(),
                                    _degreeController.text.trim(),
                                    _areaController.text.trim(),
                                    _descriptionController.text.trim(),
                                    context)
                                .then((value) {
                              if (value.status == true) {
                                Get.back();
                                controller.getData();
                              }
                              showToast(value.message.toString());
                            });
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
  }
}
