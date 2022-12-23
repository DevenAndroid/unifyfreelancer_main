import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unifyfreelancer/widgets/add_text.dart';

import '../../controller/profie_screen_controller.dart';
import '../../models/model_freelancer_profile.dart';
import '../../repository/add_employment_repository.dart';
import '../../repository/delete_employment_info_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class Page5 extends StatefulWidget {
  Page5({Key? key}) : super(key: key);

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  final controller = Get.put(ProfileScreenController());

  final dateFormat = DateFormat('dd-MMM-yyyy');

  String getFormatDate(String value) {
    return value != "" ? dateFormat.format(DateTime.parse(value)) : value;
  }

  showDialogue({
    required Employment item,
  }) {
    RxBool endDatePresent = false.obs;
    final TextEditingController companyController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController fromController = TextEditingController();
    final TextEditingController toController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey();
    var dateInput = "";
    var dateInput2 = "";

    companyController.text = item.company ?? "";
    cityController.text = item.city ?? "";
    countryController.text = item.country ?? "";
    titleController.text = item.subject ?? "";
    fromController.text = getFormatDate(item.startDate ?? "");
    toController.text = getFormatDate(item.endDate ?? "");
    descriptionController.text = item.description ?? "";
    dateInput = item.startDate ?? "";
    dateInput2 = item.endDate ?? "";
    endDatePresent.value = item.endDate == null ? true : false;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.size100 * .4),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                            ],
                          ),
                          child: Column(
                            children: [
                              const Text(
                                "Add Work Experience",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppTheme.titleText,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Title*",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.titleText,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomTextField(
                                      controller: titleController,
                                      obSecure: false.obs,
                                      keyboardType: TextInputType.emailAddress,
                                      hintText: "Web developer".obs,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                'Please enter your title'),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: AddSize.size15,
                                    ),
                                    Text(
                                      "Company*",
                                      style: TextStyle(
                                          fontSize: AddSize.font14,
                                          color: AppTheme.titleText,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: AddSize.size5,
                                    ),
                                    CustomTextField(
                                      controller: companyController,
                                      obSecure: false.obs,
                                      keyboardType: TextInputType.text,
                                      hintText: "Ex: Unify".obs,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                'Please enter your company'),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: AddSize.size15,
                                    ),
                                    Text(
                                      "Location*",
                                      style: TextStyle(
                                          fontSize: AddSize.font14,
                                          color: AppTheme.titleText,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: AddSize.size5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: CustomTextField(
                                            controller: cityController,
                                            obSecure: false.obs,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            hintText: "City".obs,
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText:
                                                      'Please enter your city'),
                                            ]),
                                          ),
                                        ),
                                        SizedBox(
                                          width: AddSize.size5,
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            onTap: () {
                                              FocusManager
                                                  .instance.primaryFocus!
                                                  .unfocus();
                                              controller.searchList1.clear();
                                              for (var item in controller
                                                  .countryList
                                                  .value
                                                  .countrylist!) {
                                                controller.searchList1
                                                    .add(item.name.toString());
                                              }
                                              showModalBottomSheet<void>(
                                                isScrollControlled: true,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    AddSize
                                                                        .size30),
                                                            topRight: Radius
                                                                .circular(AddSize
                                                                    .size30))),
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .7,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: IconButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            icon: const Icon(
                                                              Icons.clear,
                                                              color: AppTheme
                                                                  .blackColor,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                                  .all(AddSize
                                                                      .size10)
                                                              .copyWith(top: 0),
                                                          child: TextFormField(
                                                            onChanged: (value) {
                                                              if (value != "") {
                                                                controller
                                                                    .searchList1
                                                                    .clear();
                                                                // searchList1.value = countryList.countrylist!.map((e) => e.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                                                for (var item
                                                                    in controller
                                                                        .countryList
                                                                        .value
                                                                        .countrylist!) {
                                                                  if (item.name
                                                                      .toString()
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          value
                                                                              .toLowerCase())) {
                                                                    controller
                                                                        .searchList1
                                                                        .add(item
                                                                            .name
                                                                            .toString());
                                                                  }
                                                                }
                                                              } else {
                                                                controller
                                                                    .searchList1
                                                                    .clear();
                                                                for (var item
                                                                    in controller
                                                                        .countryList
                                                                        .value
                                                                        .countrylist!) {
                                                                  controller
                                                                      .searchList1
                                                                      .add(item
                                                                          .name
                                                                          .toString());
                                                                }
                                                              }
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor: AppTheme
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      .05),
                                                              hintText:
                                                                  "Select country",
                                                              prefixIcon: const Icon(
                                                                  Icons.flag),
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xff596681),
                                                                  fontSize: 15),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          14,
                                                                      horizontal:
                                                                          20),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppTheme
                                                                        .primaryColor
                                                                        .withOpacity(
                                                                            .15),
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        AddSize.size10 *
                                                                            .8),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: AppTheme
                                                                        .primaryColor
                                                                        .withOpacity(
                                                                            .15),
                                                                    width: 1.0),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        AddSize.size10 *
                                                                            .8),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: AppTheme
                                                                          .primaryColor
                                                                          .withOpacity(
                                                                              .15),
                                                                      width:
                                                                          1.0),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          AddSize.size10 *
                                                                              .8)),
                                                            ),
                                                          ),
                                                        ),
                                                        Obx(() {
                                                          return Expanded(
                                                            child: ListView
                                                                .builder(
                                                                    physics:
                                                                        const BouncingScrollPhysics(),
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount: controller
                                                                        .searchList1
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Obx(
                                                                          () {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              countryController.text = controller.searchList1[index].toString();
                                                                            });
                                                                            print(countryController.text);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: AddSize.size30, vertical: AddSize.size10),
                                                                              child: Text(
                                                                                controller.searchList1[index].toString(),
                                                                                style: TextStyle(fontSize: AddSize.font14, fontWeight: FontWeight.w600),
                                                                              )),
                                                                        );
                                                                      });
                                                                    }),
                                                          );
                                                        }),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            readOnly: true,
                                            controller: countryController,
                                            decoration: InputDecoration(
                                              errorMaxLines: 2,
                                              filled: true,
                                              fillColor: AppTheme.whiteColor,
                                              hintText: "Country",
                                              labelStyle: const TextStyle(
                                                  color: Colors.black),
                                              suffixIcon: const Icon(Icons.keyboard_arrow_down),
                                              hintStyle: TextStyle(
                                                color: const Color(0xff596681),
                                                fontSize: AddSize.size15,
                                              ),
                                              contentPadding: EdgeInsets.only(left: AddSize.size10),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(.15),
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AddSize.size10 * .8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppTheme.primaryColor
                                                        .withOpacity(.15),
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AddSize.size10 * .8),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppTheme
                                                          .primaryColor
                                                          .withOpacity(.15),
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AddSize.size10 * .8)),
                                            ),
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText:
                                                      'Please select your country'),
                                            ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Period*",
                                      style: TextStyle(
                                          fontSize: AddSize.size14,
                                          color: AppTheme.titleText,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: AddSize.size5,
                                    ),
                                    CustomTextField(
                                      controller: fromController,
                                      readOnly: true,
                                      onTap: () async {
                                        print(dateInput);
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: dateInput == ""
                                                    ? DateTime.now()
                                                    : DateTime.parse(dateInput),
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime.now());
                                        if (pickedDate != null) {
                                          fromController.text =
                                              dateFormat.format(pickedDate);
                                          setState(() {
                                            dateInput =
                                                "${pickedDate.year}-${pickedDate.month < 10 ? "0" + pickedDate.month.toString() : pickedDate.month}-${pickedDate.day < 10 ? "0" + pickedDate.day.toString() : pickedDate.day}";
                                            print(dateInput);
                                          });
                                        }
                                      },
                                      obSecure: false.obs,
                                      hintText: "From".obs,
                                      suffixIcon: Icon(
                                        Icons.calendar_month_outlined,
                                        size: AddSize.size22,
                                        color: AppTheme.primaryColor,
                                      ),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                'Please select your start date'),
                                      ]),
                                    ),
                                    Row(
                                      children: [
                                        Obx(() {
                                          return Checkbox(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              value: endDatePresent.value,
                                              activeColor:
                                                  AppTheme.primaryColor,
                                              onChanged: (newValue) {
                                                endDatePresent.value =
                                                    newValue!;
                                                if (endDatePresent.value ==
                                                    true) {
                                                  toController.clear();
                                                  dateInput2 = "";
                                                }
                                              });
                                        }),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "I currently work here",
                                          style: TextStyle(
                                              fontSize: AddSize.size12,
                                              color: AppTheme.titleText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Obx(() {
                                      return SizedBox(
                                        child: endDatePresent == false
                                            ? CustomTextField(
                                                controller: toController,
                                                readOnly: true,
                                                onTap: () async {
                                                  DateTime? pickedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate: dateInput2 ==
                                                                  ""
                                                              ? DateTime.now()
                                                              : DateTime.parse(
                                                                  dateInput2),
                                                          firstDate:
                                                              DateTime(1950),
                                                          lastDate:
                                                              DateTime.now());
                                                  if (pickedDate != null) {
                                                    toController.text =
                                                        dateFormat
                                                            .format(pickedDate);
                                                    setState(() {
                                                      dateInput2 =
                                                          "${pickedDate.year}-${pickedDate.month < 10 ? "0" + pickedDate.month.toString() : pickedDate.month}-${pickedDate.day < 10 ? "0" + pickedDate.day.toString() : pickedDate.day}";
                                                    });
                                                  }
                                                },
                                                obSecure: false.obs,
                                                hintText: "To".obs,
                                                suffixIcon: Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: AddSize.size22,
                                                  color: AppTheme.primaryColor,
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please select your end date';
                                                  } else if (DateTime.parse(
                                                              dateInput)
                                                          .compareTo(
                                                              DateTime.parse(
                                                                  dateInput2)) <
                                                      0) {
                                                    return null;
                                                  } else {
                                                    return "End date must be grater then start date";
                                                  }
                                                })
                                            : const SizedBox(),
                                      );
                                    }),
                                    SizedBox(
                                      height: AddSize.size15,
                                    ),
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                          fontSize: AddSize.size14,
                                          color: AppTheme.titleText,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: AddSize.size5,
                                    ),
                                    CustomTextField(
                                      controller: descriptionController,
                                      isMulti: true,
                                      obSecure: false.obs,
                                      keyboardType: TextInputType.emailAddress,
                                      hintText: "Description".obs,
                                      validator: MultiValidator([
                                        MaxLengthValidator(200, errorText: "Description maximum length is 200 characters")
                                      ]),
                                      /*validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: 'Description is required'),
                                      ]),*/
                                    ),
                                    SizedBox(
                                      height: AddSize.size15,
                                    ),
                                  ]),
                            ],
                          )),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(AddSize.size10),
                              child: CustomOutlineButton(
                                title: 'Cancel',
                                backgroundColor: AppTheme.whiteColor,
                                onPressed: () {
                                  Get.back();
                                },
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
                                  if (_formKey.currentState!.validate()) {
                                    questionEmployment(
                                            id: item.id ?? "",
                                            subject:
                                                titleController.text.trim(),
                                            description: descriptionController
                                                .text
                                                .trim(),
                                            company:
                                                companyController.text.trim(),
                                            city: cityController.text.trim(),
                                            country:
                                                countryController.text.trim(),
                                            start_date: dateInput,
                                            end_date: dateInput2,
                                            currently_working:
                                                endDatePresent == true ? 1 : 0,
                                            context: context)
                                        .then((value) {
                                      if (value.status == true) {
                                        Get.back();
                                        controller.getData();
                                      } else {
                                        showToast(value.message.toString());
                                      }
                                    });
                                  }
                                },
                                textColor: AppTheme.whiteColor,
                                expandedValue: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  showDeleteDialog({
    required Employment item,
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
                      deleteEmploymentInfoRepo(item.id.toString(), context)
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
                      deleteEmploymentInfoRepo(item.id.toString(), context)
                          .then((value) {
                        if (value.status == true) {
                          controller.model.value.data!.employment!.remove(item);
                          controller.getData();
                          Get.back();
                        } else {
                          showToast(value.message.toString());
                        }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          padding: EdgeInsets.all(AddSize.size12),
          height: AddSize.screenHeight,
          width: AddSize.screenWidth,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AddSize.size10,
                ),
                Text(
                  controller.model.value.data!.basicInfo!.firstName.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                Text(
                  "Tell us about your experience...",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "Add any information here about previous work experience, or freelance projects. If you're just starting out, no problem - you can leave this blank.",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font12),
                ),
                SizedBox(
                  height: AddSize.size20,
                ),
                if (controller.status.value.isSuccess)
                  ListView.builder(
                    itemCount: controller.model.value.data!.employment!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => employmentData(
                        controller.model.value.data!.employment![index]),
                  ),
                SizedBox(
                  height: AddSize.size15,
                ),
                CustomOutlineButton(
                  title: '+  Add Experience',
                  backgroundColor: AppTheme.whiteColor,
                  onPressed: () {
                    showDialogue(item: Employment());
                  },
                  textColor: AppTheme.primaryColor,
                  expandedValue: true,
                ),
                SizedBox(
                  height: AddSize.size20,
                ),
                if (controller.model.value.data!.employment!.isEmpty)
                  Row(
                    children: [
                      Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: controller.nothingToAddForExperience.value,
                          activeColor: AppTheme.primaryColor,
                          onChanged: (newValue) {
                            setState(() {
                              controller.nothingToAddForExperience.value =
                                  newValue!;
                            });
                          }),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          "Nothing to add? check the box and keep going",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font14),
                        ),
                      ),
                    ],
                  )

                /*Row(
                  children: [
                    Obx(() {
                      return Checkbox(
                          materialTapTargetSize: MaterialTapTargetSize
                              .shrinkWrap,
                          value: controller.acceptTermsOrPrivacy.value,
                          activeColor: AppTheme.primaryColor,
                          onChanged: (newValue) {
                            controller.acceptTermsOrPrivacy.value = newValue!;
                          });
                    }),
                    SizedBox(
                      width: AddSize.size5,
                    ),
                    Expanded(
                      child: Text(
                        "Nothing to Add? Check the box and keep going.",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
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
                  if (controller.nothingToAddForExperience.value == false) {
                    showToast("Please select the checkbox");
                  } else {
                    controller.nextPage();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container employmentData(Employment item) {
    return Container(
      padding: EdgeInsets.all(AddSize.padding16),
      decoration: const BoxDecoration(color: AppTheme.whiteColor),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.subject.toString().capitalize!,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AddSize.size15),
                  child: InkWell(
                    onTap: () {
                      showDialogue(item: item);
                    },
                    child: Container(
                      padding: EdgeInsets.all(AddSize.size5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.whiteColor,
                          border: Border.all(color: const Color(0xff707070))),
                      child: Icon(
                        Icons.edit,
                        color: AppTheme.primaryColor,
                        size: AddSize.size15,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDeleteDialog(item: item);
                  },
                  child: Container(
                    padding: EdgeInsets.all(AddSize.size5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.whiteColor,
                        border: Border.all(color: const Color(0xff707070))),
                    child: Icon(
                      Icons.delete,
                      color: AppTheme.primaryColor,
                      size: AddSize.size15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Text(
              item.company.toString().capitalizeFirst!,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor,
                  fontSize: AddSize.font14),
            ),
            SizedBox(
              height: AddSize.size5,
            ),
            Text(
              "${item.startDate != null ? dateFormat.format(DateTime.parse(item.startDate!)) : ""}"
              " ${item.endDate != null ? "to" : ""}"
              " ${item.endDate != null ? dateFormat.format(DateTime.parse(item.endDate!)) : ""}"
              " ${item.endDate != null ? "," : "- Present"}"
              " ${item.city != null ? "${item.city}," : ""}"
              " ${item.country != null ? item.country.toString() : ""}",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppTheme.textColor,
                  fontSize: AddSize.font14),
            ),
          ],
        ),
      ),
    );
  }
}
