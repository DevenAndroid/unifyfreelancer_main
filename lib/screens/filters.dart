import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../controller/search_controller.dart';
import '../resources/app_theme.dart';
import '../resources/size.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_textfield.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RxString jobType = "".obs;

  List jobTypeList = [
    "Short term",
    "Long term",
  ];

  RxString projectDuration = "".obs;

  List projectDurationList = [
    "More than 6 months",
    "3 to 6 months",
    "1 to 3 months",
    "Less than 1 month",
  ];

  RxString budgetType = "".obs;

  List budgetTypeList = [
    "Fixed",
    "Hourly",
  ];
  final controller = Get.put(SearchJobListController());
  RangeValues _currentRangeValues = const RangeValues(0, 90);

  String? englishLevel;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
            isLikeButton: false, isProfileImage: false, titleText: "Filters"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.whiteColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Job type",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText)),
              const SizedBox(
                height: 5,
              ),
              DropdownButtonFormField<dynamic>(
                isExpanded: true,
                menuMaxHeight: AddSize.screenHeight * .54,
                value: jobType.value == "" ? null : jobType.value,
                validator: (value) {
                  if (value == null) {
                    return 'Please select reason';
                  }
                },
                decoration: InputDecoration(
                  hintText: "Select job type",
                  hintStyle:
                      const TextStyle(fontSize: 13, color: Color(0xff596681)),
                  counterText: "",
                  filled: true,
                  fillColor: AppTheme.whiteColor,
                  focusColor: AppTheme.whiteColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppTheme.primaryColor.withOpacity(.15),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppTheme.primaryColor.withOpacity(.15),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppTheme.primaryColor.withOpacity(.15),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Down Arrow Icon
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
                items: List.generate(
                    jobTypeList.length,
                    (index) => DropdownMenuItem(
                          value: jobTypeList[index].toString(),
                          child: Text(
                            jobTypeList[index].toString(),
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xff596681)),
                          ),
                          // onTap: (){
                          //      setState(() {
                          //        timezoneValue = controller.timezoneList.data![index].timezone.toString();
                          //        print(timezoneValue);
                          //      });
                          //
                          // },
                        )),
                onChanged: (newValue) {
                  jobType.value = newValue;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text("Skills",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText)),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                //      controller: _lNameController,
                obSecure: false.obs,
                keyboardType: TextInputType.text,
                hintText: "Search skills".obs,
                validator: MultiValidator(
                    [RequiredValidator(errorText: 'Please enter last name')]),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text("Project duration",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText)),
              const SizedBox(
                height: 5,
              ),
              DropdownButtonFormField<dynamic>(
                isExpanded: true,
                menuMaxHeight: AddSize.screenHeight * .54,
                value:
                    projectDuration.value == "" ? null : projectDuration.value,
                validator: (value) {
                  if (value == null) {
                    return 'Please select reason';
                  }
                },
                decoration: InputDecoration(
                  hintText: "Select a duration",
                  hintStyle:
                      const TextStyle(fontSize: 13, color: Color(0xff596681)),
                  counterText: "",
                  filled: true,
                  fillColor: AppTheme.whiteColor,
                  focusColor: AppTheme.whiteColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppTheme.primaryColor.withOpacity(.15),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppTheme.primaryColor.withOpacity(.15),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppTheme.primaryColor.withOpacity(.15),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Down Arrow Icon
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
                items: List.generate(
                    projectDurationList.length,
                    (index) => DropdownMenuItem(
                          value: projectDurationList[index].toString(),
                          child: Text(
                            projectDurationList[index].toString(),
                            style: const TextStyle(
                                fontSize: 13, color: Color(0xff596681)),
                          ),
                          // onTap: (){
                          //      setState(() {
                          //        timezoneValue = controller.timezoneList.data![index].timezone.toString();
                          //        print(timezoneValue);
                          //      });
                          //
                          // },
                        )),
                onChanged: (newValue) {
                  projectDuration.value = newValue;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text("Budget type",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText)),
              const SizedBox(
                height: 5,
              ),
              DropdownButtonFormField<dynamic>(
                isExpanded: true,
                menuMaxHeight: AddSize.screenHeight * .54,
                value:
                projectDuration.value == "" ? null : projectDuration.value,
                validator: (value) {
                  if (value == null) {
                    return 'Please select budget type';
                  }
                },
                decoration: InputDecoration(
                  hintText: "Select budget type",
                  hintStyle:
                  const TextStyle(fontSize: 13, color: Color(0xff596681)),
                  counterText: "",
                  filled: true,
                  fillColor: AppTheme.whiteColor,
                  focusColor: AppTheme.whiteColor,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppTheme.primaryColor.withOpacity(.15),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppTheme.primaryColor.withOpacity(.15),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppTheme.primaryColor.withOpacity(.15),
                        width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Down Arrow Icon
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
                items: List.generate(
                    budgetTypeList.length,
                        (index) => DropdownMenuItem(
                      value: budgetTypeList[index].toString(),
                      child: Text(
                        budgetTypeList[index].toString(),
                        style: const TextStyle(
                            fontSize: 13, color: Color(0xff596681)),
                      ),
                      // onTap: (){
                      //      setState(() {
                      //        timezoneValue = controller.timezoneList.data![index].timezone.toString();
                      //        print(timezoneValue);
                      //      });
                      //
                      // },
                    )),
                onChanged: (newValue) {
                  projectDuration.value = newValue;
                },
              ),
              Theme(
                data: ThemeData(
                        expansionTileTheme: const ExpansionTileThemeData(
                            textColor: AppTheme.primaryColor,
                            iconColor: AppTheme.primaryColor))
                    .copyWith(dividerColor: Colors.transparent),
                child: ListTileTheme(
                  contentPadding: EdgeInsets.zero,
                  child: ExpansionTile(
                      title: const Text("Category",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText)),
                      children: List.generate(
                          controller.modelCategory.value.data!.length,
                          (index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          value: controller.modelCategory.value
                                              .data![index].checkboxData!,
                                          activeColor: AppTheme.primaryColor,
                                          onChanged: (newValue) {
                                            setState(() {
                                              controller
                                                  .modelCategory
                                                  .value
                                                  .data![index]
                                                  .checkboxData = newValue;
                                            });
                                          }),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          controller.modelCategory.value
                                              .data![index].name
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.darkBlueText)),
                                    ],
                                  ),
                                  /* CheckboxListTile(
                                    title: Text(
                          controller.modelCategory.value.data![index].name.toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.darkBlueText)),
                                    value: false,
                                    contentPadding: const EdgeInsets.all(0),
                                    dense: true,
                                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                    onChanged: (bool? value) {  },

                                  ),*/
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ))),
                ),
              ),
              Divider(
                color: AppTheme.primaryColor.withOpacity(.49),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Price",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText)),
              const SizedBox(
                height: 10,
              ),
              RangeSlider(
                values: _currentRangeValues,
                max: 100,
                //   divisions: 5,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      readOnly: true,
                      //      controller: _lNameController,
                      obSecure: false.obs,
                      keyboardType: TextInputType.text,
                      hintText: "3".obs,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter last name')
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CustomTextField(
                      readOnly: true,
                      //      controller: _lNameController,
                      obSecure: false.obs,
                      keyboardType: TextInputType.text,
                      hintText: "999".obs,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Please enter last name')
                      ]),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: AppTheme.primaryColor.withOpacity(.49),
              ),
              Theme(
                data: ThemeData(
                    expansionTileTheme: const ExpansionTileThemeData(
                        textColor: AppTheme.primaryColor,
                        iconColor: AppTheme.primaryColor))
                    .copyWith(dividerColor: Colors.transparent),
                child: ListTileTheme(
                  contentPadding: EdgeInsets.zero,
                  child: ExpansionTile(
                      title: const Text("English level",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText)),
                            children: [
                              RadioListTile(
                                title: const Text(
                                  "Fluent",
                                  style: TextStyle(fontSize: 14, color: AppTheme.settingsTextColor),
                                ),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                value: "More than 6 Month",
                                groupValue: englishLevel,
                                onChanged: (value) {
                                  setState(() {
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text(
                                  "Native",
                                  style: TextStyle(fontSize: 14, color: AppTheme.settingsTextColor),
                                ),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                value: "More than 6 Month",
                                groupValue: englishLevel,
                                onChanged: (value) {
                                  setState(() {
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text(
                                  "Conversational",
                                  style: TextStyle(fontSize: 14, color: AppTheme.settingsTextColor),
                                ),
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                value: "More than 6 Month",
                                groupValue: englishLevel,
                                onChanged: (value) {
                                  setState(() {
                                  });
                                },
                              ),
                            ],
                          )),
                ),

            ],
          ),
        ),
      ),
        bottomNavigationBar: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(15.0).copyWith(top: 5),
                child: CustomOutlineButton(
                  title: 'Filter Result',
                  backgroundColor: AppTheme.primaryColor,
                  onPressed: () {

                  },
                  textColor: AppTheme.whiteColor,
                  expandedValue: false,
                ),
              ),
            ),
          ],
        )
    );
  }
}

