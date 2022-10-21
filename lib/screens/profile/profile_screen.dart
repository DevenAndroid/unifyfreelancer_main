import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unifyfreelancer/controller/profie_screen_controller.dart';
import 'package:unifyfreelancer/popups/radio_buttons_profile_screen.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';
import 'package:unifyfreelancer/widgets/add_text.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';

import '../../repository/delete_certificate_info_repository.dart';
import '../../repository/delete_education_info_repository.dart';
import '../../repository/delete_employment_info_repository.dart';
import '../../repository/delete_portfolio_info_repository.dart';
import '../../repository/delete_testimonial_info_repository.dart';
import '../../repository/edit_designation_info_repository.dart';
import '../../repository/edit_name_info_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/box_textfield.dart';
import '../../widgets/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int ratingValue = 0;
  final controller = Get.put(ProfileScreenController());
  String? time;
  final profileController = Get.put(ProfileScreenController());
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _designationDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    profileController.getData();
    profileController.getLanguageData();
  }

  File imageFileToPick = File("");

  pickImageFromDevice({required imageSource}) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      imageFileToPick = File(image.path);
      setState(() {});
      Map<String, String> map = {};
      map["first_name"] =
          profileController.model.value.data!.basicInfo!.firstName.toString();
      map["last_name"] =
          profileController.model.value.data!.basicInfo!.lastName.toString();
      map["occcuption"] =
          profileController.model.value.data!.basicInfo!.description.toString();
      editNameInfoRepo(
              mapData: map,
              fieldName1: "profile_image",
              file1: imageFileToPick,
              context: context)
          .then((value) {
        imageFileToPick.delete();
        imageFileToPick = File("");
        if (value.status == true) {
          profileController.getData();
        }
        showToast(value.message.toString());
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  RxBool showMoreCertificate = false.obs;
  RxBool showDescriptionCertificate = false.obs;

  updateProfileBasicDetails() {
    Map<String, String> map = {};
    map["first_name"] = _fNameController.text.trim();
    map["last_name"] = _lNameController.text.trim();
    map["occcuption"] = _descriptionController.text.trim();
    editNameInfoRepo(
            mapData: map,
            fieldName1: "profile_image",
            file1: imageFileToPick,
            context: context)
        .then((value) {
      if (value.status == true) {
        profileController.getData();
        Get.back();
      }
      showToast(value.message.toString());
    });
  }

  showDialogueUpdateBasicInfo() {
    _fNameController.text =
        profileController.model.value.data!.basicInfo!.firstName.toString();
    _lNameController.text =
        profileController.model.value.data!.basicInfo!.lastName.toString();
    _descriptionController.text =
        profileController.model.value.data!.basicInfo!.occuption.toString();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.clear,
                          size: 20,
                        ),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Edit Details",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              AddText(text: "First Name"),
              SizedBox(
                height: 6,
              ),
              BoxTextField(
                obSecure: false.obs,
                hintText: "First Name".obs,
                keyboardType: TextInputType.text,
                controller: _fNameController,
                onSaved: (value) {
                  setState(() {
                    _fNameController.text = value.toString();
                  });
                },
              ),
              SizedBox(
                height: 12,
              ),
              AddText(text: "Last Name"),
              SizedBox(
                height: 6,
              ),
              BoxTextField(
                obSecure: false.obs,
                hintText: "Last Name".obs,
                keyboardType: TextInputType.text,
                controller: _lNameController,
                onSaved: (value) {
                  setState(() {
                    _lNameController.text = value.toString();
                  });
                },
              ),
              SizedBox(
                height: 12,
              ),
              AddText(text: "Occupation"),
              SizedBox(
                height: 6,
              ),
              BoxTextField(
                obSecure: false.obs,
                hintText: "Occupation".obs,
                isMulti: true,
                keyboardType: TextInputType.text,
                controller: _descriptionController,
                onSaved: (value) {
                  setState(() {
                    _descriptionController.text = value.toString();
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomOutlineButton(
                title: "Change",
                backgroundColor: AppTheme.primaryColor,
                onPressed: () {
                  updateProfileBasicDetails();
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
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Freelance Profile",
        ),
      ),
      body: Obx(() {
        return profileController.status.value.isSuccess
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 10),
                        width: deviceWidth,
                        padding: const EdgeInsets.all(10),
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 100,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    pickImageFromDevice(
                                                        imageSource:
                                                            ImageSource.camera);

                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Image from Camera',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    pickImageFromDevice(
                                                        imageSource: ImageSource
                                                            .gallery);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Image from Gallery',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(profileController
                                              .model
                                              .value
                                              .data!
                                              .basicInfo!
                                              .profileImage
                                              .toString()))),
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Image.asset("assets/icon/crown.png"))
                            ]),
                            SizedBox(
                              width: 16.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profileController.model.value.data!
                                            .basicInfo!.firstName
                                            .toString() +
                                        " " +
                                        profileController.model.value.data!
                                            .basicInfo!.lastName
                                            .toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff180095)),
                                  ),
                                  Wrap(
                                    children: List.generate(
                                        5,
                                        (index) => double.parse(
                                                    profileController
                                                        .model
                                                        .value
                                                        .data!
                                                        .basicInfo!
                                                        .rating
                                                        .toString()) >
                                                index
                                            ? Icon(
                                                Icons.star,
                                                color: AppTheme.pinkText,
                                                size: 16,
                                              )
                                            : Icon(
                                                Icons.star_border_outlined,
                                                color: Colors.grey,
                                                size: 16,
                                              )),
                                  ),
                                  Text(
                                    profileController.model.value.data!
                                            .basicInfo!.occuption
                                            .toString()
                                            .isEmpty
                                        ? "Occupation"
                                        : profileController.model.value.data!
                                            .basicInfo!.occuption
                                            .toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppTheme.textColor),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.flag_outlined,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        profileController.model.value.data!
                                            .basicInfo!.country
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppTheme.textColor),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppTheme.whiteColor,
                                            border: Border.all(
                                                color: Color(0xff707070))),
                                        child: InkWell(
                                          onTap: () {
                                            showDialogueUpdateBasicInfo();
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: AppTheme.primaryColor,
                                            size: 15,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      /*  Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: deviceWidth,
                padding: const EdgeInsets.all(10),
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.darkBlueText
                                          .withOpacity(0.47)),
                                ),
                                Text(
                                  "Earning",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.darkBlueText
                                          .withOpacity(0.47)),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              "\$100K",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff0777FD)),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.darkBlueText
                                            .withOpacity(0.47)),
                                  ),
                                  Text(
                                    "Jobs",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.darkBlueText
                                            .withOpacity(0.47)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Text(
                                "26",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff6B428B)),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(
                      color: AppTheme.pinkText.withOpacity(.29),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.darkBlueText
                                          .withOpacity(0.47)),
                                ),
                                Text(
                                  "Hours",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.darkBlueText
                                          .withOpacity(0.47)),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              "2065",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffF66C6C)),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pending",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.darkBlueText
                                          .withOpacity(0.47)),
                                ),
                                Text(
                                  "Project",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.darkBlueText
                                          .withOpacity(0.47)),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Text("26",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.pinkText,
                                ))
                          ],
                        ),
                      ],
                    ),
                  ],
                )),*/
                      /// Earning Section
                      earningSection(deviceWidth),
                      /// Hours Language and Education
                      hoursLanguageEducation(deviceWidth),

                      /// Occupation Work History  Skills and portfolio
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: deviceWidth,
                          padding: const EdgeInsets.all(10),
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Occupation",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkBlueText),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final _formKey = GlobalKey<FormState>();
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          content: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
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
                                                              Navigator.pop(
                                                                  context),
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppTheme.textColor),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                BoxTextField(
                                                  controller:
                                                      _designationController,
                                                  obSecure: false.obs,
                                                  hintText:
                                                      "Website design and development"
                                                          .obs,
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            'Please enter designation'),
                                                  ]),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                BoxTextField(
                                                  controller:
                                                      _designationDescriptionController,
                                                  obSecure: false.obs,
                                                  hintText: "description".obs,
                                                  isMulti: true,
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            'Please enter description'),
                                                  ]),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                CustomOutlineButton(
                                                  title: "Change",
                                                  backgroundColor:
                                                      AppTheme.primaryColor,
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      editDesignationInfoRepo(
                                                              _designationController
                                                                  .text
                                                                  .trim(),
                                                              _designationDescriptionController
                                                                  .text
                                                                  .trim(),
                                                              context)
                                                          .then((value) {
                                                        if (value.status ==
                                                            true) {
                                                          showToast(value
                                                              .message
                                                              .toString());
                                                          Get.back();
                                                          print(jsonEncode(
                                                              value));
                                                          profileController
                                                              .getData();
                                                        } else {
                                                          print(jsonEncode(
                                                              value));
                                                          showToast(value
                                                              .message
                                                              .toString());
                                                        }
                                                      });
                                                    }
                                                  },
                                                  textColor:
                                                      AppTheme.whiteColor,
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
                                      margin: EdgeInsets.only(left: 20),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: Color(0xff707070))),
                                      child: Icon(
                                        Icons.edit,
                                        color: AppTheme.primaryColor,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                profileController
                                        .model.value.data!.basicInfo!.occuption
                                        .toString()
                                        .isEmpty
                                    ? "Enter your occupation"
                                    : profileController
                                        .model.value.data!.basicInfo!.occuption
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkBlueText),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                profileController.model.value.data!.basicInfo!
                                        .description
                                        .toString()
                                        .isEmpty
                                    ? "Description"
                                    : profileController.model.value.data!
                                        .basicInfo!.description
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 13.sp, color: AppTheme.textColor),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              // Text(
                              //   "View More",
                              //   style: TextStyle(
                              //       fontSize: 13.sp,
                              //       fontWeight: FontWeight.w600,
                              //       color: AppTheme.primaryColor),
                              // ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                color: AppTheme.pinkText.withOpacity(.29),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Work History",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkBlueText),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30))),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return RadioButtonsProfileScreen();
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: Color(0xff707070))),
                                      child: Icon(
                                        Icons.edit,
                                        color: AppTheme.primaryColor,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Experienced Developer for Wellness",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkBlueText),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Wrap(
                                    children: List.generate(
                                        5,
                                        (index) => 5 > index
                                            ? Icon(
                                                Icons.star,
                                                color: AppTheme.primaryColor,
                                                size: 17,
                                              )
                                            : Icon(
                                                Icons.star_border_outlined,
                                                color: Colors.grey,
                                                size: 17,
                                              )),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "5.00 Oct 29, 2021 - Dec 3, 2021",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: AppTheme.textColor),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
                                style: TextStyle(
                                    fontSize: 13.sp, color: AppTheme.textColor),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$3.000",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkBlueText),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  Text(
                                    "Fixed Price",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkBlueText),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                color: AppTheme.pinkText.withOpacity(.29),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "My Skills",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkBlueText),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        Get.toNamed(MyRouter.editSkillsScreen),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: Color(0xff707070))),
                                      child: Icon(
                                        Icons.edit,
                                        color: AppTheme.primaryColor,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: profileController
                                    .model.value.data!.skills!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profileController.model.value.data!
                                            .skills![index].skillName
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: AppTheme.textColor),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  );
                                },
                              ),

                              Divider(
                                color: AppTheme.pinkText.withOpacity(.29),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "My Portfolio",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkBlueText),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                        MyRouter.addPortFolioScreen),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: Color(0xff707070))),
                                      child: Icon(
                                        Icons.add,
                                        color: AppTheme.primaryColor,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                child: profileController.model.value.data!
                                            .portfolio!.length ==
                                        0
                                    ? SizedBox()
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount: profileController.model.value
                                            .data!.portfolio!.length,
                                        itemBuilder: (context, index) {
                                          print(profileController.model.value
                                              .data!.portfolio![index].image
                                              .toString());
                                          return Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(5),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .2,
                                                width: deviceWidth * .8,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: AppTheme.whiteColor,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          profileController
                                                              .model
                                                              .value
                                                              .data!
                                                              .portfolio![index]
                                                              .image
                                                              .toString()),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Title :",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppTheme
                                                            .darkBlueText),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      profileController
                                                          .model
                                                          .value
                                                          .data!
                                                          .portfolio![index]
                                                          .name
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppTheme
                                                              .darkBlueText),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      deletePortfolioInfoRepo(
                                                              profileController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .portfolio![
                                                                      index]
                                                                  .id,
                                                              context)
                                                          .then((value) {
                                                        if (value.status ==
                                                            true) {
                                                          print(
                                                              profileController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .portfolio![
                                                                      index]
                                                                  .id);
                                                          profileController
                                                              .model
                                                              .value
                                                              .data!
                                                              .portfolio!
                                                              .removeAt(index);
                                                          profileController
                                                              .getData();
                                                        }
                                                        showToast(value.message
                                                            .toString());
                                                        print(profileController
                                                            .model
                                                            .value
                                                            .data!
                                                            .portfolio![index]
                                                            .id);
                                                      });
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 15),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: AppTheme
                                                              .whiteColor,
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xff707070))),
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: AppTheme
                                                            .primaryColor,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Description :",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppTheme
                                                            .darkBlueText),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      profileController
                                                          .model
                                                          .value
                                                          .data!
                                                          .portfolio![index]
                                                          .description
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppTheme
                                                              .darkBlueText),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Divider(
                                                color: AppTheme.pinkText
                                                    .withOpacity(.29),
                                              ),
                                            ],
                                          );
                                        }),
                              )
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: deviceWidth,
                          padding: const EdgeInsets.all(10),
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Testimonials",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkBlueText),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                        MyRouter.addTestimonialsScreen),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: Color(0xff707070))),
                                      child: Icon(
                                        Icons.add,
                                        color: AppTheme.primaryColor,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                  width: deviceWidth,
                                  child: profileController.model.value.data!
                                              .testimonial!.length ==
                                          0
                                      ? Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: AppTheme.whiteColor,
                                          ),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/testimonials.png",
                                                  height: 100,
                                                  width: 100,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  "Showcase your skills with non-Unify client testimonials",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Color(0xff363636)),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: profileController.model
                                              .value.data!.testimonial!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Name :",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppTheme
                                                                .darkBlueText),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          profileController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .testimonial![
                                                                      index]
                                                                  .firstName
                                                                  .toString() +
                                                              " " +
                                                              profileController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .testimonial![
                                                                      index]
                                                                  .lastName
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppTheme
                                                                  .darkBlueText),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          deleteTestimonialInfoRepo(
                                                                  profileController
                                                                      .model
                                                                      .value
                                                                      .data!
                                                                      .testimonial![
                                                                          index]
                                                                      .id,
                                                                  context)
                                                              .then((value) {
                                                            if (value.status ==
                                                                true) {
                                                              print(profileController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .testimonial![
                                                                      index]
                                                                  .id);
                                                              profileController
                                                                  .model
                                                                  .value
                                                                  .data!
                                                                  .testimonial!
                                                                  .removeAt(
                                                                      index);
                                                              profileController
                                                                  .getData();
                                                            }
                                                            showToast(value
                                                                .message
                                                                .toString());
                                                            print(profileController
                                                                .model
                                                                .value
                                                                .data!
                                                                .testimonial![
                                                                    index]
                                                                .id);
                                                          });
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 15),
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: AppTheme
                                                                  .whiteColor,
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xff707070))),
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: AppTheme
                                                                .primaryColor,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Email :",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppTheme
                                                                .darkBlueText),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          profileController
                                                              .model
                                                              .value
                                                              .data!
                                                              .testimonial![
                                                                  index]
                                                              .email
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppTheme
                                                                  .darkBlueText),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Linkedin Profile :",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppTheme
                                                                .darkBlueText),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          profileController
                                                              .model
                                                              .value
                                                              .data!
                                                              .testimonial![
                                                                  index]
                                                              .linkdinUrl
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppTheme
                                                                  .darkBlueText),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Title :",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppTheme
                                                                .darkBlueText),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          profileController
                                                              .model
                                                              .value
                                                              .data!
                                                              .testimonial![
                                                                  index]
                                                              .title
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppTheme
                                                                  .darkBlueText),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Type :",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppTheme
                                                                .darkBlueText),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          profileController
                                                              .model
                                                              .value
                                                              .data!
                                                              .testimonial![
                                                                  index]
                                                              .type
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppTheme
                                                                  .darkBlueText),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Description :",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppTheme
                                                                .darkBlueText),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          profileController
                                                              .model
                                                              .value
                                                              .data!
                                                              .testimonial![
                                                                  index]
                                                              .description
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppTheme
                                                                  .darkBlueText),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Divider(
                                                    color: AppTheme.pinkText
                                                        .withOpacity(.29),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        )),
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: deviceWidth,
                          padding: const EdgeInsets.all(10),
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Certifications",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkBlueText),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                        MyRouter.addCertificationsScreen),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: Color(0xff707070))),
                                      child: Icon(
                                        Icons.add,
                                        color: AppTheme.primaryColor,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                  child: profileController.model.value.data!
                                              .certificates!.length ==
                                          0
                                      ? Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: AppTheme.whiteColor,
                                          ),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                "assets/images/certification.png",
                                                height: 100,
                                                width: 100,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                "Listing your certifications can help prove your specific knowledge or abilities. (+10%) You can add them manually",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color: Color(0xff363636)),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: showMoreCertificate.value
                                              ? profileController.model.value
                                                  .data!.certificates!.length
                                              : profileController
                                                          .model
                                                          .value
                                                          .data!
                                                          .certificates!
                                                          .length <
                                                      4
                                                  ? profileController
                                                      .model
                                                      .value
                                                      .data!
                                                      .certificates!
                                                      .length
                                                  : 4,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        height: 85,
                                                        width: 70,
                                                        child: Image.network(
                                                          "https://cdn.pixabay.com/photo/2016/02/04/12/19/gold-1179100_960_720.png",
                                                        )),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  profileController
                                                                      .model
                                                                      .value
                                                                      .data!
                                                                      .certificates![
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppTheme
                                                                          .darkBlueText),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  deleteCertificateInfoRepo(
                                                                          profileController
                                                                              .model
                                                                              .value
                                                                              .data!
                                                                              .certificates![index]
                                                                              .id,
                                                                          context)
                                                                      .then((value) {
                                                                    if (value
                                                                            .status ==
                                                                        true) {
                                                                      showToast(value
                                                                          .message
                                                                          .toString());
                                                                      profileController
                                                                          .model
                                                                          .value
                                                                          .data!
                                                                          .certificates!
                                                                          .removeAt(
                                                                              index);
                                                                      profileController
                                                                          .getData();
                                                                    } else {
                                                                      showToast(value
                                                                          .message
                                                                          .toString());
                                                                    }
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              15),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: AppTheme
                                                                          .whiteColor,
                                                                      border: Border.all(
                                                                          color:
                                                                              Color(0xff707070))),
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: AppTheme
                                                                        .primaryColor,
                                                                    size: 15,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.verified,
                                                                size: 15,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Pending verification",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppTheme
                                                                        .darkBlueText),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Divider(
                                                  color: AppTheme.pinkText
                                                      .withOpacity(.29),
                                                ),
                                              ],
                                            );
                                          })),
                            ],
                          )),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: deviceWidth,
                        padding: const EdgeInsets.all(10),
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
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Employment history",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.darkBlueText),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                  onTap: () =>
                                      Get.toNamed(MyRouter.addEmploymentScreen),
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppTheme.whiteColor,
                                        border: Border.all(
                                            color: Color(0xff707070))),
                                    child: Icon(
                                      Icons.add,
                                      color: AppTheme.primaryColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: profileController
                                    .model.value.data!.employment!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            profileController.model.value.data!
                                                .employment![index].subject
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff363636)),
                                          ),
                                          Text(
                                            profileController
                                                        .model
                                                        .value
                                                        .data!
                                                        .employment![index]
                                                        .company
                                                        .toString() !=
                                                    "null"
                                                ? " | " +
                                                    profileController
                                                        .model
                                                        .value
                                                        .data!
                                                        .employment![index]
                                                        .company
                                                        .toString()
                                                : "",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff363636)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            profileController.model.value.data!
                                                .employment![index].startDate
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff363636)),
                                          ),
                                          Text(
                                            profileController
                                                        .model
                                                        .value
                                                        .data!
                                                        .employment![index]
                                                        .startDate
                                                        .toString() !=
                                                    "null"
                                                ? " - " +
                                                    profileController
                                                        .model
                                                        .value
                                                        .data!
                                                        .employment![index]
                                                        .startDate
                                                        .toString()
                                                : "",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff363636)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () => Get.toNamed(
                                                MyRouter.addEmploymentScreen,
                                                arguments: index),
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppTheme.whiteColor,
                                                  border: Border.all(
                                                      color:
                                                          Color(0xff707070))),
                                              child: Icon(
                                                Icons.edit,
                                                color: AppTheme.primaryColor,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              deleteEmploymentInfoRepo(
                                                      profileController
                                                          .model
                                                          .value
                                                          .data!
                                                          .employment![index]
                                                          .id
                                                          .toString(),
                                                      context)
                                                  .then((value) {
                                                if (value.status == true) {
                                                  profileController.model.value
                                                      .data!.employment!
                                                      .removeAt(index);
                                                  profileController.getData();
                                                }
                                                showToast(
                                                    value.message.toString());
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 15),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppTheme.whiteColor,
                                                  border: Border.all(
                                                      color:
                                                          Color(0xff707070))),
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
                                        height: 10.h,
                                      ),
                                      Divider(
                                        color:
                                            AppTheme.pinkText.withOpacity(.29),
                                      ),
                                    ],
                                  );
                                })
                          ],
                        ),
                      ),
                      /*               Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: deviceWidth,
                          padding: const EdgeInsets.all(10),
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Employment history",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkBlueText),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                        MyRouter.addOtherExperiencesScreen),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: Color(0xff707070))),
                                      child: Icon(
                                        Icons.add,
                                        color: AppTheme.primaryColor,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                  child: uploadDocument3 == null
                                      ? Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: AppTheme.whiteColor,
                                          ),
                                          child: InkWell(
                                            onTap: () =>
                                                uploadDocumentFunction3(),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/files.png",
                                                  height: 100,
                                                  width: 100,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  "Add any other experiences that help you stand out",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Color(0xff363636)),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: AppTheme.whiteColor,
                                                image: DecorationImage(
                                                    image: FileImage(
                                                        uploadDocumentDisplay3!),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              "Add any other experiences that help you stand out",
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w300,
                                                  color: Color(0xff363636)),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )),
                            ],
                          )),*/
                    ],
                  ),
                ))
            : profileController.status.value.isError
                ? SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.model.value.message.toString(),
                          // fontSize: AddSize.font16,
                        ),
                        IconButton(
                            onPressed: () {
                              controller.getData();
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
    );
  }

  Container hoursLanguageEducation(double deviceWidth) {
    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: deviceWidth,
                      padding: const EdgeInsets.all(10),
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hours per week",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkBlueText),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              InkWell(
                                onTap: () =>
                                    Get.toNamed(MyRouter.hoursPerWeekScreen),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.whiteColor,
                                      border: Border.all(
                                          color: Color(0xff707070))),
                                  child: Icon(
                                    Icons.edit,
                                    color: AppTheme.primaryColor,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            profileController.model.value.data!.hoursPerWeek.toString(),
                            style: TextStyle(
                                fontSize: 13.sp, color: AppTheme.textColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Language",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkBlueText),
                              ),
                              InkWell(
                                onTap: () =>
                                    Get.toNamed(MyRouter.addLanguageScreen),
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.whiteColor,
                                      border: Border.all(
                                          color: Color(0xff707070))),
                                  child: Icon(
                                    Icons.add,
                                    color: AppTheme.primaryColor,
                                    size: 15,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () =>
                                    Get.toNamed(MyRouter.editLanguageScreen),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.whiteColor,
                                      border: Border.all(
                                          color: Color(0xff707070))),
                                  child: Icon(
                                    Icons.edit,
                                    color: AppTheme.primaryColor,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: profileController
                                  .model.value.data!.language!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 4.h),
                                  child: Row(
                                    children: [
                                      Text(
                                        profileController.model.value.data!
                                                .language![index].language
                                                .toString()
                                                .capitalizeFirst! +
                                            " : ",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.textColor),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        profileController.model.value.data!
                                            .language![index].level
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: AppTheme.textColor),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Education",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkBlueText),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(MyRouter.addEducationScreen);
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.whiteColor,
                                      border: Border.all(
                                          color: Color(0xff707070))),
                                  child: Icon(
                                    Icons.add,
                                    color: AppTheme.primaryColor,
                                    size: 15,
                                  ),
                                ),
                              ),
                              /* InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.whiteColor,
                                      border: Border.all(
                                          color: Color(0xff707070))),
                                  child: Icon(
                                    Icons.edit,
                                    color: AppTheme.primaryColor,
                                    size: 15,
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: profileController
                                .model.value.data!.education!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    profileController.model.value.data!
                                        .education![index].school
                                        .toString().capitalizeFirst!,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff4D4D4D)),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          profileController.model.value.data!
                                              .education![index].degree
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.textColor
                                                  .withOpacity(.63)),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                  MyRouter.addEducationScreen,
                                                  arguments: index);
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 15),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppTheme.whiteColor,
                                                  border: Border.all(
                                                      color:
                                                          Color(0xff707070))),
                                              child: Icon(
                                                Icons.edit,
                                                color: AppTheme.primaryColor,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              deleteEducationInfoRepo(
                                                      profileController
                                                          .model
                                                          .value
                                                          .data!
                                                          .education![index]
                                                          .id
                                                          .toString(),
                                                      context)
                                                  .then((value) {
                                                if (value.status == true) {
                                                  profileController.model
                                                      .value.data!.education!
                                                      .removeAt(index);
                                                  profileController.getData();
                                                }
                                                showToast(
                                                    value.message.toString());
                                              });
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 15),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppTheme.whiteColor,
                                                  border: Border.all(
                                                      color:
                                                          Color(0xff707070))),
                                              child: Icon(
                                                Icons.delete,
                                                color: AppTheme.primaryColor,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Divider(
                                    color: AppTheme.pinkText.withOpacity(.29),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
  }

  Container earningSection(double deviceWidth) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: deviceWidth,
        padding: const EdgeInsets.all(10),
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
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Earning",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.darkBlueText.withOpacity(0.47)),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        profileController
                            .model.value.data!.basicInfo!.totalEarning
                            .toString(),
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0777FD)),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Jobs",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.darkBlueText.withOpacity(0.47)),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        profileController.model.value.data!.basicInfo!.totalJobs
                            .toString(),
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff6B428B)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: AppTheme.pinkText.withOpacity(.29),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Hours",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.darkBlueText.withOpacity(0.47)),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        profileController
                            .model.value.data!.basicInfo!.totalHours
                            .toString(),
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffF66C6C)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pending Project",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.darkBlueText.withOpacity(0.47)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          profileController
                              .model.value.data!.basicInfo!.pendingProject
                              .toString(),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.pinkText,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
