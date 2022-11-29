import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import '../../controller/profie_screen_controller.dart';
import '../../models/model_degree_list.dart';
import '../../models/model_freelancer_profile.dart';
import '../../repository/add_category_repository.dart';
import '../../repository/add_employment_repository.dart';
import '../../repository/degree_list_repository.dart';
import '../../repository/delete_education_info_repository.dart';
import '../../repository/delete_employment_info_repository.dart';
import '../../repository/edit_designation_info_repository.dart';
import '../../repository/edit_education_info_repository.dart';
import '../../repository/edit_name_info_repository.dart';
import '../../repository/submit_profile_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/new_helper.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/add_text.dart';
import '../../widgets/box_textfield.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class ProfilePreview extends StatefulWidget {
  ProfilePreview({Key? key}) : super(key: key);

  @override
  State<ProfilePreview> createState() => _ProfilePreviewState();
}

class _ProfilePreviewState extends State<ProfilePreview> {
  final controller = Get.put(ProfileScreenController());
  Rx<File> profileImage = File("").obs;
  final List<String> photoList = [
    " Be a close-up of your face.",
    " Show your face clearly -sunglasses",
    " Be clear and crisp",
    " Have a neural background",
  ];
  final NewHelper newHelper = NewHelper();

  showPickImageSheet() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Select Image',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppTheme.primaryColor),
        ),
        // message: const Text('Message'),
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("Cancel");
          },
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () {
              newHelper
                  .addImagePicker(
                      imageSource: ImageSource.gallery, imageQuality: 60)
                  .then((value) {
                profileImage.value = value;
              });
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              newHelper
                  .addImagePicker(
                      imageSource: ImageSource.camera, imageQuality: 60)
                  .then((value) {
                profileImage.value = value;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  showDialogueForProfile() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: AddSize.padding16,
            ),
            child: Obx(() {
              return Form(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Text(
                          "Add Profile Photo",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font20),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    width: AddSize.screenWidth,
                                    height: AddSize.size200 * .90,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade300),
                                      margin:
                                          EdgeInsets.only(top: AddSize.size10),
                                      child: profileImage.value.path == ""
                                          ? Icon(
                                              Icons.person_add_alt_1,
                                              color: Colors.white,
                                              size: AddSize.size30,
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(1000),
                                              child: Image.file(
                                                profileImage.value,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                      height: AddSize.size200 * .72,
                                      width: AddSize.size200 * .72,
                                    ),
                                  ),
                                  if (profileImage.value.path != "")
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: () {
                                              profileImage.value.delete();
                                              profileImage.value = File("");
                                            },
                                            icon: Icon(
                                              Icons.clear_rounded,
                                              size: AddSize.size25,
                                            )))
                                ],
                              ),
                              CustomOutlineButton(
                                  title: "Select Profile Image",
                                  backgroundColor: AppTheme.whiteColor,
                                  textColor: AppTheme.primaryColor,
                                  onPressed: () {
                                    showPickImageSheet();
                                  }),
                              SizedBox(
                                height: AddSize.size30,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: AddText(
                                  text: "Your photo should:",
                                  fontWeight: FontWeight.w600,
                                  fontSize: AddSize.size16,
                                ),
                              ),
                              SizedBox(
                                height: AddSize.size20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      photoList.length,
                                      (index) => Padding(
                                            padding: EdgeInsets.only(
                                                bottom: AddSize.size10 * .8),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: AddSize.size14,
                                                ),
                                                Icon(
                                                  Icons.circle,
                                                  size: AddSize.size10 * .8,
                                                  color: AppTheme.primaryColor,
                                                ),
                                                AddText(
                                                  text: photoList[index],
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: AddSize.size15,
                                                  height: 1.3,
                                                ),
                                              ],
                                            ),
                                          )),
                                ),
                              )
                            ]),
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
                                    if (profileImage.value.path != "") {
                                      Map<String, String> map = {};
                                      map["first_name"] = controller.model.value
                                          .data!.basicInfo!.firstName
                                          .toString();
                                      map["last_name"] = controller
                                          .model.value.data!.basicInfo!.lastName
                                          .toString();
                                      map["occcuption"] = controller.model.value
                                          .data!.basicInfo!.occuption
                                          .toString();
                                      editNameInfoRepo(
                                              mapData: map,
                                              fieldName1: "profile_image",
                                              file1: profileImage.value,
                                              context: context)
                                          .then((value) {
                                        if (value.status == true) {
                                          Get.back();
                                        }
                                        showToast(value.message.toString());
                                        controller.getData();
                                      });
                                    } else {
                                      showToast("Please select a image");
                                    } /*else {
                                    profilePart = true;
                                    check();
                                  }*/
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
              );
            }),
          );
        });
  }

  //Employment Popup
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
                          ],
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.titleText,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                controller: titleController,
                                obSecure: false.obs,
                                keyboardType: TextInputType.emailAddress,
                                hintText: "Web developer".obs,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Title is required'),
                                ]),
                              ),
                              SizedBox(
                                height: AddSize.size15,
                              ),
                              Text(
                                "Company",
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
                                keyboardType: TextInputType.emailAddress,
                                hintText: "Ex: Unify".obs,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Company is required'),
                                ]),
                              ),
                              SizedBox(
                                height: AddSize.size15,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: AddSize.font14,
                                    color: AppTheme.titleText,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: AddSize.size5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: cityController,
                                      obSecure: false.obs,
                                      keyboardType: TextInputType.emailAddress,
                                      hintText: "City".obs,
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: 'city is required'),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(
                                    width: AddSize.size5,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      onTap: () {
                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                        controller.searchList1.clear();
                                        for (var item in controller
                                            .countryList.value.countrylist!) {
                                          controller.searchList1
                                              .add(item.name.toString());
                                        }
                                        showModalBottomSheet<void>(
                                          isScrollControlled: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      AddSize.size30),
                                                  topRight: Radius.circular(
                                                      AddSize.size30))),
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .7,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      icon: Icon(
                                                        Icons.clear,
                                                        color:
                                                            AppTheme.blackColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                            AddSize.size10)
                                                        .copyWith(top: 0),
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        if (value != "") {
                                                          controller.searchList1
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
                                                                .contains(value
                                                                    .toLowerCase())) {
                                                              controller
                                                                  .searchList1
                                                                  .add(item.name
                                                                      .toString());
                                                            }
                                                          }
                                                        } else {
                                                          controller.searchList1
                                                              .clear();
                                                          for (var item
                                                              in controller
                                                                  .countryList
                                                                  .value
                                                                  .countrylist!) {
                                                            controller
                                                                .searchList1
                                                                .add(item.name
                                                                    .toString());
                                                          }
                                                        }
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor: AppTheme
                                                            .primaryColor
                                                            .withOpacity(.05),
                                                        hintText:
                                                            "Select country",
                                                        prefixIcon:
                                                            Icon(Icons.flag),
                                                        hintStyle:
                                                            const TextStyle(
                                                                color: Color(
                                                                    0xff596681),
                                                                fontSize: 15),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 14,
                                                                horizontal: 20),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: AppTheme
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      .15),
                                                              width: 1.0),
                                                          borderRadius: BorderRadius
                                                              .circular(AddSize
                                                                      .size10 *
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
                                                          borderRadius: BorderRadius
                                                              .circular(AddSize
                                                                      .size10 *
                                                                  .8),
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: AppTheme
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        .15),
                                                                width: 1.0),
                                                            borderRadius: BorderRadius
                                                                .circular(AddSize
                                                                        .size10 *
                                                                    .8)),
                                                      ),
                                                    ),
                                                  ),
                                                  Obx(() {
                                                    return Expanded(
                                                      child: ListView.builder(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: controller
                                                              .searchList1
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Obx(() {
                                                              return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    countryController
                                                                            .text =
                                                                        controller
                                                                            .searchList1[index]
                                                                            .toString();
                                                                  });
                                                                  print(
                                                                      countryController
                                                                          .text);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            AddSize
                                                                                .size30,
                                                                        vertical:
                                                                            AddSize.size10),
                                                                    child: Text(
                                                                      controller
                                                                          .searchList1[
                                                                              index]
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize: AddSize
                                                                              .font14,
                                                                          fontWeight:
                                                                              FontWeight.w600),
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
                                        fillColor: AppTheme.whiteColor,
                                        hintText: "Country",
                                        labelStyle: const TextStyle(
                                            color: Colors.black),
                                        suffixIcon:
                                            Icon(Icons.keyboard_arrow_down),
                                        hintStyle: TextStyle(
                                          color: Color(0xff596681),
                                          fontSize: AddSize.size15,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: AddSize.size10),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.primaryColor
                                                  .withOpacity(.15),
                                              width: 1.0),
                                          borderRadius: BorderRadius.circular(
                                              AddSize.size10 * .8),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppTheme.primaryColor
                                                  .withOpacity(.15),
                                              width: 1.0),
                                          borderRadius: BorderRadius.circular(
                                              AddSize.size10 * .8),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppTheme.primaryColor
                                                    .withOpacity(.15),
                                                width: 1.0),
                                            borderRadius: BorderRadius.circular(
                                                AddSize.size10 * .8)),
                                      ),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: 'Country is required'),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Period",
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
                                  DateTime? pickedDate = await showDatePicker(
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
                                      errorText: 'From, date is required'),
                                ]),
                              ),
                              Row(
                                children: [
                                  Obx(() {
                                    return Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: endDatePresent.value,
                                        activeColor: AppTheme.primaryColor,
                                        onChanged: (newValue) {
                                          endDatePresent.value = newValue!;
                                          if (endDatePresent.value == true) {
                                            toController.clear();
                                            dateInput2 = "";
                                          }
                                        });
                                  }),
                                  SizedBox(
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
                                                    firstDate: DateTime(1950),
                                                    lastDate: DateTime.now());
                                            if (pickedDate != null) {
                                              toController.text =
                                                  dateFormat.format(pickedDate);
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
                                          /*validator: MultiValidator([
                                            RequiredValidator(
                                                errorText:
                                                    'To, date is required'),
                                          ]),*/
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'To, date is required';
                                            } else if (DateTime.parse(dateInput)
                                                    .compareTo(DateTime.parse(
                                                        dateInput2)) <
                                                0) {
                                              return null;
                                            } else {
                                              return "End date must be grater then start date";
                                            }
                                          })
                                      : SizedBox(),
                                );
                              }),
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
                                height: AddSize.size5,
                              ),
                              CustomTextField(
                                controller: descriptionController,
                                isMulti: true,
                                obSecure: false.obs,
                                keyboardType: TextInputType.emailAddress,
                                hintText: "Description".obs,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Description is required'),
                                ]),
                              ),
                              SizedBox(
                                height: AddSize.size15,
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
                                          subject: titleController.text.trim(),
                                          description:
                                              descriptionController.text.trim(),
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
                                /*if(DateTime.parse(dateInput).compareTo(DateTime.parse(dateInput2)) < 0){
                                  if (_formKey.currentState!.validate()) {
                                    questionEmployment(
                                        id: item.id ?? "",
                                        subject: titleController.text.trim(),
                                        description:
                                        descriptionController.text.trim(),
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
                                      }
                                      showToast(value.message.toString());
                                    });
                                  }
                                }
                                else{
                                  showToast("End date must be grater then start date");
                                }*/

                                /*  if (_formKey.currentState!.validate()) {
                                  questionEmployment(
                                          id: item.id ?? "",
                                          subject: titleController.text.trim(),
                                          description:
                                              descriptionController.text.trim(),
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
                                    }
                                    showToast(value.message.toString());
                                  });
                                }*/
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
          );
        });
  }

  showDeleteDialogForEducation({
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
                        } else {
                          showToast(value.message.toString());
                        }
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

  RxBool acceptTermsOrPrivacy = false.obs;

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
                        } else {
                          showToast(value.message.toString());
                        }
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
            insetPadding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.size100 * .4),
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
                                                            fontSize:
                                                                AddSize.size15,
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
                                "End date",
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
                                        titleText: "To",
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
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Obx(() {
                                                      return RadioListTile(
                                                        title: Text(
                                                          yearsList[index]
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: AddSize
                                                                  .size15,
                                                              color: AppTheme
                                                                  .darkBlueText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        dense: true,
                                                        visualDensity:
                                                            VisualDensity(
                                                                horizontal: -4,
                                                                vertical: -4),
                                                        value: yearsList[index]
                                                            .toString(),
                                                        groupValue: time.value,
                                                        onChanged: (value) {
                                                          time.value =
                                                              value.toString();
                                                          _toController.text =
                                                              value.toString();
                                                          print(_toController
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
                                  controller: _toController,
                                  hintText: "To".obs,
                                  suffixIcon: Icon(Icons.keyboard_arrow_down),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'To, year is required';
                                    } else if (int.parse(
                                            _fromController.text.toString()) <
                                        int.parse(
                                            _toController.text.toString())) {
                                      return null;
                                    } else {
                                      return "End year must be grater then start date";
                                    }
                                  }
                                  /* validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'To year is required'),
                                ]),*/
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
                                                            fontSize:
                                                                AddSize.size15,
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
                                                      groupValue:
                                                          selectedDegree.value,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedDegree.value =
                                                              value.toString();
                                                          _degreeController
                                                                  .text =
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
                                //   if (int.parse(_fromController.text.toString()) < int.parse(_toController.text.toString())) {
                                if (_formKey.currentState!.validate()) {
                                  questionEducation(
                                          id: item.id ?? "",
                                          school: _schoolController.text.trim(),
                                          start_year:
                                              _fromController.text.trim(),
                                          end_year: _toController.text.trim(),
                                          degree: _degreeController.text.trim(),
                                          area_study:
                                              _areaController.text.trim(),
                                          description: _descriptionController
                                              .text
                                              .trim(),
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
                              }
                              // else {
                              //   showToast(
                              //       "End year must be grater then start year");
                              // }

                              /*  if (_formKey.currentState!.validate()) {
                                  questionEducation(
                                          id: item.id ?? "",
                                          school: _schoolController.text.trim(),
                                          start_year:
                                              _fromController.text.trim(),
                                          end_year: _toController.text.trim(),
                                          degree: _degreeController.text.trim(),
                                          area_study:
                                              _areaController.text.trim(),
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
                                }*/
                              ,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                "Preview Profile",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font20),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Looking good, ${controller.model.value.data!.basicInfo!.firstName.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkBlueText,
                                fontSize: AddSize.font20),
                          ),
                          Text(
                            "Make any edits you want, then submit your profile. You can make more change after it's live.",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkBlueText,
                                fontSize: AddSize.font14),
                          ),
                          SizedBox(
                            height: AddSize.size10,
                          ),
                          CustomOutlineButton(
                            title: "Submit Profile",
                            backgroundColor: AppTheme.whiteColor,
                            textColor: AppTheme.primaryColor,
                            onPressed: () {
                              submitProfileRepo().then((value) async {
                                if (value.status == true) {
                                  Get.toNamed(MyRouter.bottomNavbar);
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setBool('isProfileCompleted', true);
                                }
                                showToast(value.message.toString());
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: AddSize.size10,
                    ),
                    SvgPicture.asset(
                      "assets/images/like.svg",
                      height: 80,
                      width: 80,
                    )
                  ],
                ),
              ),
              profilePreviewData(context),
            ],
          ),
        ),
      ),
    );
  }

  Container employmentData(Employment item) {
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
                        border: Border.all(color: Color(0xff707070))),
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
                  //  showDeleteDialog(item: item);
                },
                child: Container(
                  padding: EdgeInsets.all(AddSize.size5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.whiteColor,
                      border: Border.all(color: Color(0xff707070))),
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
            item.description.toString().capitalizeFirst!,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor,
                fontSize: AddSize.font14),
          ),
          Text(
            "${item.startDate != null ? dateFormat.format(DateTime.parse(item.startDate!)) : ""}"
            " ${item.endDate != null ? "to" : ""}"
            " ${item.endDate != null ? dateFormat.format(DateTime.parse(item.endDate!)) : ""}",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppTheme.textColor,
                fontSize: AddSize.font14),
          ),
        ],
      ),
    );
  }

  profilePreviewData(context) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey.shade300),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: CachedNetworkImage(
                            imageUrl: controller.profileImage.value ?? "",
                            errorWidget: (_, __, ___) => SizedBox(),
                            placeholder: (_, __) => SizedBox(),
                            fit: BoxFit.cover,
                          ) /*Image.file(
                              profileImage.value,
                              fit: BoxFit.cover,
                            ),*/
                          ),
                      height: AddSize.size80 * 1.2,
                      width: AddSize.size80 * 1.2,
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    CustomOutlineButton(
                      title: " Edit Photo ",
                      backgroundColor: AppTheme.whiteColor,
                      textColor: AppTheme.primaryColor,
                      onPressed: () {
                        showDialogueForProfile();
                      },
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.model.value.data!.basicInfo!.firstName
                                .toString() +
                            controller.model.value.data!.basicInfo!.lastName
                                .toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkBlueText,
                            fontSize: AddSize.font20),
                      ),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Color(0xff878787),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Text(
                              controller.model.value.data!.basicInfo!.city
                                      .toString() +
                                  "," +
                                  controller
                                      .model.value.data!.basicInfo!.country
                                      .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff878787),
                                  fontSize: AddSize.font14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      /* Text(
                      "3:30 PM local time",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff878787),
                          fontSize: AddSize.font14),
                    ),*/
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Divider(
              color: AppTheme.pinkText.withOpacity(.39),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.model.value.data!.basicInfo!.occuption.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      final _formKey = GlobalKey<FormState>();
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 20),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          content: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: SizedBox(
                                        height: 15,
                                        width: 20,
                                      ),
                                    ),
                                    Positioned(
                                        top: -15,
                                        right: -15,
                                        child: IconButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          icon: Icon(
                                            Icons.clear,
                                            size: 20,
                                          ),
                                        ))
                                  ],
                                ),
                                Text(
                                  "Edit Your Title",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BoxTextField(
                                  controller: controller.designationController,
                                  obSecure: false.obs,
                                  hintText:
                                      "Website design and development".obs,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText:
                                            'Example: Full StackDeveloper | Web & Mobile'),
                                    MinLengthValidator(5,
                                        errorText: 'Minimum length is 5'),
                                    MaxLengthValidator(50,
                                        errorText: "Maximum length is 100"),
                                  ]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BoxTextField(
                                  controller: controller
                                      .designationDescriptionController,
                                  obSecure: false.obs,
                                  hintText: "description".obs,
                                  isMulti: true,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Please enter description'),
                                  ]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomOutlineButton(
                                  title: "Change",
                                  backgroundColor: AppTheme.primaryColor,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      editDesignationInfoRepo(
                                              title: controller
                                                  .designationController.text
                                                  .trim(),
                                              description: controller
                                                  .designationDescriptionController
                                                  .text
                                                  .trim(),
                                              context: context)
                                          .then((value) {
                                        if (value.status == true) {
                                          showToast(value.message.toString());
                                          Get.back();
                                          print(jsonEncode(value));
                                          controller.getData();
                                        } else {
                                          print(jsonEncode(value));
                                          showToast(value.message.toString());
                                        }
                                      });
                                    }
                                  },
                                  textColor: AppTheme.whiteColor,
                                  expandedValue: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
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
              ],
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Text(
              controller.model.value.data!.basicInfo!.description.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff878787),
                  fontSize: AddSize.font14),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Divider(
              color: AppTheme.pinkText.withOpacity(.39),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hourly Rate",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(MyRouter.hoursPerWeekScreen);
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
              ],
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Text(
              "\$" + controller.model.value.data!.basicInfo!.amount.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff878787),
                  fontSize: AddSize.font14),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Divider(
              color: AppTheme.pinkText.withOpacity(.39),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Skills",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(MyRouter.editSkillsScreen);
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
              ],
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Wrap(
              children: List.generate(
                controller.model.value.data!.skills!.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 5.0, bottom: 2),
                  child: FilterChip(
                    label: Text(
                      controller.model.value.data!.skills![index].skillName
                          .toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppTheme.darkBlueText,
                          fontSize: AddSize.font14),
                    ),
                    backgroundColor: Color(0xffEAEEF2),
                    onSelected: (value) {},
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Divider(
              color: AppTheme.pinkText.withOpacity(.39),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Service",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      services();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.whiteColor,
                          border: Border.all(color: Color(0xff707070))),
                      child: Icon(
                        Icons.add,
                        color: AppTheme.primaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Text(
              controller.serviceController.text.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff878787),
                  fontSize: AddSize.font14),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Divider(
              color: AppTheme.pinkText.withOpacity(.39),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Work Experience",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      showDialogue(item: Employment());
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.whiteColor,
                          border: Border.all(color: Color(0xff707070))),
                      child: Icon(
                        Icons.add,
                        color: AppTheme.primaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AddSize.size20,
            ),
            workExperience(),
            SizedBox(
              height: AddSize.size10,
            ),
            Divider(
              color: AppTheme.pinkText.withOpacity(.39),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Education History",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      showEducationDialog(Education());
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.whiteColor,
                          border: Border.all(color: Color(0xff707070))),
                      child: Icon(
                        Icons.add,
                        color: AppTheme.primaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AddSize.size20,
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            educationList(),
            SizedBox(
              height: AddSize.size20,
            ),
            Divider(
              color: AppTheme.pinkText.withOpacity(.39),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Text(
              "Location",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkBlueText,
                  fontSize: AddSize.font20),
            ),
            Row(
              children: [
                Text(
                  controller.model.value.data!.basicInfo!.city
                          .toString()
                          .isNotEmpty
                      ? controller.model.value.data!.basicInfo!.city
                              .toString() +
                          ","
                      : "",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff878787),
                      fontSize: AddSize.font14),
                ),
                Text(
                  controller.model.value.data!.basicInfo!.country.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff878787),
                      fontSize: AddSize.font14),
                ),
              ],
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Divider(
              color: AppTheme.pinkText.withOpacity(.39),
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            Row(
              children: [
                Text(
                  "Languages",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(MyRouter.addLanguageScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.whiteColor,
                          border: Border.all(color: Color(0xff707070))),
                      child: Icon(
                        Icons.add,
                        color: AppTheme.primaryColor,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(MyRouter.editLanguageScreen);
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
              ],
            ),
            SizedBox(
              height: AddSize.size10,
            ),
            languageList(),
            SizedBox(
              height: AddSize.size20,
            ),
            CustomOutlineButton(
              title: 'Submit Profile',
              backgroundColor: AppTheme.primaryColor,
              onPressed: () {
                submitProfileRepo().then((value) async {
                  if (value.status == true) {
                    Get.toNamed(MyRouter.bottomNavbar);
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setBool('isProfileCompleted', true);
                  }
                  showToast(value.message.toString());
                });
              },
              textColor: AppTheme.whiteColor,
              expandedValue: false,
            ),
          ],
        ),
      );
    });
  }

  void services() {
    return showFilterButtonSheet(
        context: context,
        titleText: "Select a service",
        widgets: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: AppTheme.pinkText.withOpacity(.49),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.modelOfService.value.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Get.back();

                        addCategoryRepo(
                                category_id:controller.modelOfService.value.data![index].id
                                    .toString(),
                                context: context)
                            .then((value) {
                          if (value.status == true) {
                            controller.getData();
                          }
                          //  showToast(value.message.toString());
                        });
                      },
                      child: Text(
                        controller.modelOfService.value.data![index].name
                            .toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkBlueText,
                            fontSize: AddSize.font16),
                      ),
                    ),
                  );
                })
          ],
        ));
  }

  workExperience() {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.model.value.data!.employment!.length,
        itemBuilder: (context, index1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    controller.model.value.data!.employment![index1].company
                        .toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font18),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {
                        showDialogue(
                            item: controller
                                .model.value.data!.employment![index1]);
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
                      showDeleteDialogForEducation(
                          item:
                              controller.model.value.data!.employment![index1]);
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
                height: AddSize.size10,
              ),
              Text(
                controller.model.value.data!.employment![index1].subject
                    .toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor,
                    fontSize: AddSize.font16),
              ),
              Row(
                children: [
                  Text(
                    controller.model.value.data!.employment![index1].startDate
                        .toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font14),
                  ),
                  Text(
                    controller.model.value.data!.employment![index1].endDate
                            .toString()
                            .isNotEmpty
                        ? "-" +
                            controller
                                .model.value.data!.employment![index1].endDate
                                .toString()
                        : "",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font14),
                  ),
                ],
              ),
              SizedBox(
                height: AddSize.size20,
              ),
            ],
          );
        },
      );
    });
  }

  educationList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.model.value.data!.education!.length,
      itemBuilder: (context, index) {
        return Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    controller.model.value.data!.education![index].school
                        .toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font18),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: () {
                        showEducationDialog(
                            controller.model.value.data!.education![index]);
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
                      showDeleteDialog(
                          item: controller.model.value.data!.education![index]);
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
                height: AddSize.size10,
              ),
              Text(
                controller.model.value.data!.education![index].degree
                    .toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor,
                    fontSize: AddSize.font16),
              ),
              Row(
                children: [
                  Text(
                    controller.model.value.data!.education![index].areaStudy
                            .toString() +
                        controller.model.value.data!.education![index].startYear
                            .toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font14),
                  ),
                  Text(
                    controller.model.value.data!.education![index].startYear
                            .toString()
                            .isNotEmpty
                        ? "-" +
                            controller
                                .model.value.data!.education![index].startYear
                                .toString()
                        : "",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font14),
                  ),
                ],
              ),
              SizedBox(
                height: AddSize.size5,
              ),
            ],
          );
        });
      },
    );
  }

  languageList() {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.model.value.data!.language!.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text(
                controller.model.value.data!.language![index].language
                        .toString() +
                    " : ",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font14),
              ),
              Text(
                controller.model.value.data!.language![index].level.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff878787),
                    fontSize: AddSize.font14),
              ),
              SizedBox(
                height: AddSize.size5,
              ),
            ],
          );
        },
      );
    });
  }
}
