import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/widgets/error_widget.dart';
import 'package:unifyfreelancer/widgets/progress_indicator.dart';

import '../controller/search_controller.dart';
import '../resources/app_theme.dart';
import '../resources/size.dart';
import '../utils/api_contant.dart';
import '../widgets/add_text.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_textfield.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List jobTypeList = [
    "long_term",
    "short_term",
  ];

  List projectDurationList = [
    "More than 6 months",
    "3 to 6 months",
    "1 to 3 months",
    "Less than 1 month",
  ];

  List budgetTypeList = [
    "Fixed",
    "Hourly",
  ];
  final controller = Get.put(SearchJobListController());

  showSkillsBottomSheet(context) {
    controller.tempList.clear();
    controller.tempList.addAll(controller.skillList.data!);
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
                  controller.tempList.clear();
                  for (var e in controller.skillList.data!) {
                    if (e.name!.toLowerCase().contains(value.toLowerCase())) {
                      controller.tempList.add(e);
                    }
                  }
                } else {
                  controller.tempList.addAll(controller.skillList.data!);
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
                    controller.tempList.length,
                    (index) => Obx(() {
                          return FilterChip(
                              label: AddText(
                                text:
                                    controller.tempList[index].name.toString(),
                                color:
                                    controller.tempList[index].isSelected!.value
                                        ? Colors.white
                                        : Colors.black,
                              ),
                              checkmarkColor: Colors.white,
                              selected:
                                  controller.tempList[index].isSelected!.value,
                              selectedColor: AppTheme.primaryColor,
                              backgroundColor: Colors.white,
                              onSelected: (value) {
                                if (value == true &&
                                        validateNumber() == false ||
                                    value == false) {
                                  controller.tempList[index].isSelected!.value =
                                      value;
                                  for (var i = 0;
                                      i < controller.skillList.data!.length;
                                      i++) {
                                    if (controller.tempList[index].id
                                            .toString() ==
                                        controller.skillList.data![i].id
                                            .toString()) {
                                      controller.skillList.data![i].isSelected!
                                          .value = value;
                                      break;
                                    }
                                  }
                                  filterSelectedSkills();
                                } else {
                                  showToast("Max limit is 10 skills");
                                }
                              });
                        })),
              );
            })
          ],
        ));
  }

  bool validateNumber() {
    int value = 0;
    for (var item in controller.skillList.data!) {
      if (item.isSelected!.value == true) {
        value++;
      }
    }
    if (kDebugMode) {
      print(value);
    }
    return value < 10 ? false : true;
  }

  filterSelectedSkills() {
    controller.selectedList.clear();
    for (var item in controller.skillList.data!) {
      if (item.isSelected!.value == true) {
        controller.selectedList.add(item);
      }
    }
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
              isLikeButton: false, isProfileImage: false, titleText: "Filters"),
        ),
        body: Obx(() {
          return controller.statusCategory.value.isSuccess &&
              controller.statusSkills.value.isSuccess ? Form(
            key: _formKey,
                child: SingleChildScrollView(
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
                            offset:
                                const Offset(0, 3), // changes position of shadow
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
                            value: controller.jobType.value == ""
                                ? null
                                : controller.jobType.value,
                            /*validator: (value) {
                              if (value == null) {
                                return 'Please select reason';
                              }
                            },*/
                            decoration: InputDecoration(
                              hintText: "Select job type",
                              hintStyle: const TextStyle(
                                  fontSize: 13, color: Color(0xff596681)),
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
                                        jobTypeList[index]
                                            .toString()
                                            .capitalizeFirst!
                                            .replaceAll("_", " "),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xff596681)),
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
                              controller.jobType.value = newValue;
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
                          /*CustomTextField(
                            //      controller: _lNameController,
                            obSecure: false.obs,
                            keyboardType: TextInputType.text,
                            hintText: "Search skills".obs,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please enter last name')
                            ]),
                          ),*/
                          InkWell(
                            onTap: () {
                              showSkillsBottomSheet(context);
                            },
                            child: Container(
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
                                child: controller.selectedList.isEmpty
                                    ? Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                         Text(
                                              " Enter skills",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xff596681)),
                                            ),
                                      /*  Icon(
                                            Icons.keyboard_arrow_down,
                                          ),*/
                                        ],
                                      ),
                                    )
                                    : ListView.builder(
                                        itemCount: controller.selectedList.length,
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8.0),
                                            child: Chip(
                                              label: AddText(
                                                  text: controller
                                                      .selectedList[index].name
                                                      .toString()),
                                            ),
                                          );
                                        }),
                              ),
                            ),
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
                            value: controller.projectDuration.value == ""
                                ? null
                                : controller.projectDuration.value,
                            /*validator: (value) {
                              if (value == null) {
                                return 'Please select reason';
                              }
                            },*/
                            decoration: InputDecoration(
                              hintText: "Select a duration",
                              hintStyle: const TextStyle(
                                  fontSize: 13, color: Color(0xff596681)),
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
                                      value:
                                          projectDurationList[index].toString(),
                                      child: Text(
                                        projectDurationList[index].toString(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xff596681)),
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
                              controller.projectDuration.value = newValue;
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
                            value: controller.budgetType.value == ""
                                ? null
                                : controller.budgetType.value,
                            /*validator: (value) {
                              if (value == null) {
                                return 'Please select budget type';
                              }
                            },*/
                            decoration: InputDecoration(
                              hintText: "Select budget type",
                              hintStyle: const TextStyle(
                                  fontSize: 13, color: Color(0xff596681)),
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
                                            fontSize: 13,
                                            color: Color(0xff596681)),
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
                              controller.budgetType.value = newValue;
                            },
                          ),
                          categoryList(),
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
                            values: controller.currentRangeValues,
                            max: 10000,
                            //   divisions: 5,
                            labels: RangeLabels(
                              controller.currentRangeValues.start
                                  .round()
                                  .toString(),
                              controller.currentRangeValues.end
                                  .round()
                                  .toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                controller.currentRangeValues = values;
                                controller.firstRangeController.text = controller
                                    .currentRangeValues.start
                                    .toInt()
                                    .toString();
                                controller.secondRangeController.text = controller
                                    .currentRangeValues.end
                                    .toInt()
                                    .toString();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  readOnly: true,
                                  //      prefix: Icon(Icons.attach_money,color: AppTheme.primaryColor,),
                                  controller: controller.firstRangeController,
                                  inputFormatters1: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  obSecure: false.obs,
                                  keyboardType: TextInputType.text,
                                  hintText: "3".obs,
                                  validator: (value){
                                    if(double.parse(value.toString())<3.00){
                                      return "Start price must be 3 \$";
                                    }
                                    else{
                                      return null;
                                    }

                    },
                                  onChanged: (value) {
                                    //  controller.currentRangeValues.start = double.parse(value.toString());
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: CustomTextField(
                                  controller: controller.secondRangeController,
                                  obSecure: false.obs,
                                  keyboardType: TextInputType.text,
                                  hintText: "9999".obs,
                                 /* validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Please start price')
                                  ]),*/
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
                                    expansionTileTheme:
                                        const ExpansionTileThemeData(
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
                                      activeColor: AppTheme.primaryColor,
                                      title: const Text(
                                        "Fluent",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppTheme.settingsTextColor),
                                      ),
                                      contentPadding: const EdgeInsets.all(0),
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      value: "fluent",
                                      groupValue: controller.englishLevel.value,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.englishLevel.value =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      activeColor: AppTheme.primaryColor,
                                      title: const Text(
                                        "Native",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppTheme.settingsTextColor),
                                      ),
                                      contentPadding: const EdgeInsets.all(0),
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      value: "native",
                                      groupValue: controller.englishLevel.value,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.englishLevel.value =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      activeColor: AppTheme.primaryColor,
                                      title: const Text(
                                        "Conversational",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppTheme.settingsTextColor),
                                      ),
                                      contentPadding: const EdgeInsets.all(0),
                                      dense: true,
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      value: "conversational",
                                      groupValue: controller.englishLevel.value,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.englishLevel.value =
                                              value.toString();
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
              )
              : controller.statusCategory.value.isError && controller.statusSkills.value.isError
                  ? CommonErrorWidget(
                      errorText:
                          controller.modelCategory.value.message.toString(),
                      onTap: () {
                        controller.getCategoryList();
                      })
                  : const CommonProgressIndicator();
        }),
        bottomNavigationBar: Obx(() {
          return controller.statusCategory.value.isSuccess &&
              controller.statusSkills.value.isSuccess
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: CustomOutlineButton(
                          title: 'Clear All',
                          backgroundColor: AppTheme.whiteColor,
                          onPressed: () {
                            /* controller.modelForPagination.clear();
                            controller.getData();
                            Get.back();*/
                            setState(() {
                              for(int i = 0; i< controller.modelCategory.value.data!.length!;i++){
                                controller.modelCategory.value.data![i]?.checkboxData = false;
                              }
                              controller.jobType = "".obs;
                              controller.projectDuration = "".obs;
                              controller.budgetType = "".obs;
                              controller.englishLevel = "".obs;
                              controller.selectedList.clear();
                              controller.catId.clear();
                              controller.currentRangeValues = const RangeValues(3.00, 10000.00);
                              controller.firstRangeController.text =  controller.currentRangeValues.start.toString();
                              controller.secondRangeController.text =  controller.currentRangeValues.end.toString();
                            });
                          },
                          textColor: AppTheme.primaryColor,
                          expandedValue: false,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: CustomOutlineButton(
                          title: 'Filter Result',
                          backgroundColor: AppTheme.primaryColor,
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                            controller.modelForPagination.clear();
                            controller.getData();
                            Get.back();
                            }
                          },
                          textColor: AppTheme.whiteColor,
                          expandedValue: false,
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox();
        }));
  }

  categoryList() {
    return Theme(
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
                                    controller.modelCategory.value.data![index].checkboxData = newValue;
                                    if (newValue == true) {
                                      controller.catId.add(controller
                                          .modelCategory.value.data![index].id
                                          .toString());
                                    } else {
                                      controller.catId.removeWhere((element) =>
                                          element ==
                                          controller.modelCategory.value
                                              .data![index].id
                                              .toString());
                                    }
                                    if (kDebugMode) {
                                      print(controller.catId);
                                    }
                                  });
                                }),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                controller.modelCategory.value.data![index].name
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
    );
  }
}
