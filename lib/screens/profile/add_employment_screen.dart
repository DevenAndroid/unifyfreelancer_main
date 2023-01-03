import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/profie_screen_controller.dart';
import '../../models/model_countrylist.dart';
import '../../repository/add_employment_repository.dart';
import '../../repository/countrylist_repository.dart';
import '../../resources/app_theme.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class AddEmploymentScreen extends StatefulWidget {
  const AddEmploymentScreen({Key? key}) : super(key: key);

  @override
  State<AddEmploymentScreen> createState() => _AddEmploymentScreenState();
}

class _AddEmploymentScreenState extends State<AddEmploymentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool acceptTermsOrPrivacy = true;
  int dateInput = 0;
  int dateInput2 = 0;

  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();


  final controller  = Get.put(ProfileScreenController());
  int parentIndex = -10000;

  ModelCountryList countryList = ModelCountryList();
  RxList searchList1 = <String>[].obs;

  final dateFormat = DateFormat('dd-MMM-yyyy');
  final dateFormat2 = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    countryListRepo().then((value) => setState(() {
      countryList = value;
    }));

    if(Get.arguments != null ){
      parentIndex = Get.arguments;
      _companyController.text = controller.model.value.data!.employment![parentIndex].company.toString();
      _cityController.text = controller.model.value.data!.employment![parentIndex].city.toString();
      countryController.text = controller.model.value.data!.employment![parentIndex].country.toString();
      _titleController.text = controller.model.value.data!.employment![parentIndex].subject.toString();
      _fromController.text = dateFormat.format(DateTime.parse(controller.model.value.data!.employment![parentIndex].startDate.toString()));

     if(controller.model.value.data!.employment![parentIndex].currentlyWorking == 0){
       _toController.text = dateFormat.format(DateTime.parse(controller.model.value.data!.employment![parentIndex].endDate.toString()));
       dateInput2 = DateTime.parse(controller.model.value.data!.employment![parentIndex].endDate!).millisecondsSinceEpoch;
     }
      _descriptionController.text = controller.model.value.data!.employment![parentIndex].description ?? "";
      dateInput = DateTime.parse(controller.model.value.data!.employment![parentIndex].startDate!).millisecondsSinceEpoch;


      setState(() {
        acceptTermsOrPrivacy = controller.model.value.data!.employment![parentIndex].currentlyWorking == 1 ? true :false;
        acceptTermsOrPrivacy == true ?  _toController.text = "": controller.model.value.data!.employment![parentIndex].endDate.toString();
        if (dateInput > dateInput2 ){
          dateInput2 = 0;
          _toController.text = "";
        }
      });
    }
  }

  ///
  /// dateInput = editDataTimeStamp
  /// textController = D



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Add Employment",
          // onPressedForLeading:,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
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
                        const Text(
                          "Company*",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          controller: _companyController,
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "Ex: Unify".obs,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Please enter your company'),
                          ]),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Location*",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: _cityController,
                                obSecure: false.obs,
                                keyboardType: TextInputType.emailAddress,
                                hintText: "City".obs,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter your city'),
                                ]),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child:  TextFormField(
                                onTap: () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                  searchList1.clear();
                                  for (var item in countryList.countryListData!) {
                                    searchList1.add(item.name.toString());
                                  }
                                  showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: MediaQuery.of(context).size.height * .7,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                icon: const Icon(
                                                  Icons.clear,
                                                  color: AppTheme.blackColor,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10)
                                                  .copyWith(top: 0),
                                              child: TextFormField(
                                                onChanged: (value) {
                                                  if (value != "") {
                                                    searchList1.clear();
                                                    // searchList1.value = countryList.countrylist!.map((e) => e.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                                    for (var item in countryList
                                                        .countryListData!) {
                                                      if (item.name
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(value
                                                          .toLowerCase())) {
                                                        searchList1.add(
                                                            item.name.toString());
                                                      }
                                                    }
                                                  } else {
                                                    searchList1.clear();
                                                    for (var item in countryList
                                                        .countryListData!) {
                                                      searchList1.add(
                                                          item.name.toString());
                                                    }
                                                  }
                                                  log("jsonEncode(searchList1)");
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppTheme.primaryColor
                                                      .withOpacity(.05),
                                                  hintText: "Select country",
                                                  prefixIcon: const Icon(Icons.flag),
                                                  hintStyle: const TextStyle(
                                                      color: Color(0xff596681),
                                                      fontSize: 15),
                                                  contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                      horizontal: 20),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: AppTheme.primaryColor
                                                            .withOpacity(.15),
                                                        width: 1.0),
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: AppTheme.primaryColor
                                                            .withOpacity(.15),
                                                        width: 1.0),
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppTheme
                                                              .primaryColor
                                                              .withOpacity(.15),
                                                          width: 1.0),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                                ),
                                              ),
                                            ),
                                            Obx(() {
                                              return Expanded(
                                                child: ListView.builder(
                                                    physics:
                                                    const BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: searchList1.length,
                                                    itemBuilder: (context, index) {
                                                      return Obx(() {
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              countryController
                                                                  .text =
                                                                  searchList1[index]
                                                                      .toString();
                                                            });
                                                            if (kDebugMode) {
                                                              print(countryController
                                                                .text);
                                                            }
                                                            Navigator.pop(context);
                                                          },
                                                          child: Padding(
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  30,
                                                                  vertical: 10),
                                                              child: Text(
                                                                searchList1[index]
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w600),
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
                                  filled: true,
                                  errorMaxLines: 2,
                                  fillColor: AppTheme.whiteColor,
                                  hintText: "Country",
                                  labelStyle: const TextStyle(color: Colors.black),
                                  suffixIcon:  const Icon(Icons.keyboard_arrow_down),
                                  hintStyle: const TextStyle(
                                    color: Color(0xff596681),
                                    fontSize: 15,
                                  ),
                                  contentPadding: const EdgeInsets.only(left: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                                      borderRadius: BorderRadius.circular(8.0)),
                                ),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please select your country'),
                                ]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
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
                          controller: _titleController,
                          obSecure: false.obs,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Web developer".obs,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Please enter your title'),
                          ]),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Period*",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          controller: _fromController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: dateInput == 0 ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(dateInput),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now());
                            if (pickedDate != null) {
                              print(pickedDate);
                              _fromController.text = dateFormat.format(pickedDate);
                              print(pickedDate.millisecondsSinceEpoch);
                              setState(() {
                                dateInput = pickedDate.millisecondsSinceEpoch;
                                if (dateInput > dateInput2 ){
                                  dateInput2 = 0;
                                  _toController.text = "";
                                }
                              });
                            } else {
                              return null;
                            }
                          },
                          obSecure: false.obs,
                          hintText: "Form".obs,
                          suffixIcon: const Icon(
                            Icons.calendar_month_outlined,
                            size: 22,
                            color: AppTheme.primaryColor,
                          ),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please select your start date'),
                          ]),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: acceptTermsOrPrivacy,
                                activeColor: AppTheme.primaryColor,
                                onChanged: (newValue) {
                                  setState(() {
                                    acceptTermsOrPrivacy = newValue!;
                                    acceptTermsOrPrivacy == true ?  _toController.text = "" : _toController.text = "";
                                  });
                                }),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "I currently work here",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.titleText,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: acceptTermsOrPrivacy == false
                              ? CustomTextField(
                              controller: _toController,
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: dateInput2 == 0 ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(dateInput2),
                                    firstDate: dateInput == 0 ? DateTime(1950) : DateTime.fromMillisecondsSinceEpoch(dateInput),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now());

                                if (pickedDate != null) {
                                  print(pickedDate);
                                  _toController.text = dateFormat.format(pickedDate);
                                  setState(() {
                                    dateInput2 = pickedDate.millisecondsSinceEpoch;//set output date to TextField value.
                                    print(dateInput2);
                                  });
                                } else {}
                              },
                              obSecure: false.obs,
                              hintText: "To".obs,
                              suffixIcon: const Icon(
                                Icons.calendar_month_outlined,
                                size: 22,
                                color: AppTheme.primaryColor,
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return 'Please select your end date';
                                } else if (int.parse(dateInput.toString()).compareTo(int.parse(dateInput2.toString())) < 0) {
                                  return null;
                                } else {
                                  return "End date must be grater then start date";
                                }
                              }
                            /* validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'To, date is required'),
                            ]),*/
                          )
                              : const SizedBox(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.titleText,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          controller: _descriptionController,
                          isMulti: true,
                          obSecure: false.obs,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Description".obs,
                          /*validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Description is required'),
                          ]),*/
                          validator: MultiValidator([
                            MaxLengthValidator(200, errorText: "Description maximum length is 200 characters")
                          ]),
                        ),
                        const SizedBox(
                          height: 15,
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
                      padding: const EdgeInsets.all(10.0),
                      child: CustomOutlineButton(
                        title: 'Save',
                        backgroundColor: AppTheme.primaryColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            editEmploymentInfoRepo(
                                id: parentIndex == -10000 ? parentIndex :
                                controller.model.value.data!.employment![parentIndex].id.toString(),
                                subject: _titleController.text.trim(),
                                description: _descriptionController.text.trim(),
                                company: _companyController.text.trim(),
                                city: _cityController.text.trim(),
                                country: countryController.text.trim(),
                                start_date: dateFormat2.format(DateTime.fromMillisecondsSinceEpoch(dateInput)),
                                end_date: dateFormat2.format(DateTime.fromMillisecondsSinceEpoch(dateInput2)),
                                currently_working: acceptTermsOrPrivacy == true ? 1 : 0,
                                context: context)
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