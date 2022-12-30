import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:unifyfreelancer/controller/profie_screen_controller.dart';
import 'package:unifyfreelancer/popups/radio_buttons_profile_screen.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';
import 'package:unifyfreelancer/widgets/add_text.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';

import '../../repository/add_category_repository.dart';
import '../../repository/delete_certificate_info_repository.dart';
import '../../repository/delete_education_info_repository.dart';
import '../../repository/delete_employment_info_repository.dart';
import '../../repository/delete_portfolio_info_repository.dart';
import '../../repository/delete_testimonial_info_repository.dart';
import '../../repository/edit_designation_info_repository.dart';
import '../../repository/edit_name_info_repository.dart';
import '../../repository/verification_repository.dart';
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

  // final TextEditingController _occputationController = TextEditingController();

/*  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _designationDescriptionController = TextEditingController();*/

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
          profileController.model.value.data!.basicInfo!.occuption.toString();
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
    map["occcuption"] = controller.titleController.text.trim();
    //  ;
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
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  const Align(
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
                        icon: const Icon(
                          Icons.clear,
                          size: 20,
                        ),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Edit Details",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const AddText(text: "First Name"),
              const SizedBox(
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
              const SizedBox(
                height: 12,
              ),
              const AddText(text: "Last Name"),
              const SizedBox(
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
              const SizedBox(
                height: 12,
              ),
              const AddText(text: "Occupation"),
              const SizedBox(
                height: 6,
              ),
              BoxTextField(
                obSecure: false.obs,
                hintText: "Occupation".obs,
                isMulti: true,
                keyboardType: TextInputType.text,
                controller: controller.titleController,
                onSaved: (value) {
                  setState(() {
                    controller.titleController.text = value.toString();
                  });
                },
              ),
              const SizedBox(
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
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final dateFormat = DateFormat('dd-MMM-yyyy');

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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                                  child: const Text(
                                                    'Image from Camera',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    pickImageFromDevice(
                                                        imageSource: ImageSource
                                                            .gallery);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
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
                                child: /*Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(profileController.model.value.data!.basicInfo!.profileImage.toString()))),
                                )*/
                                    SizedBox(
                                  child: controller.profileImage.value
                                                  .toString() ==
                                              "" ||
                                          controller.profileImage.value
                                                  .toString() ==
                                              "null"
                                      ? SvgPicture.asset(
                                          "assets/images/user.svg",
                                          height: 60,
                                          width: 60,
                                        )
                                      : Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.shade300),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(1000),
                                              child: CachedNetworkImage(
                                                imageUrl: controller
                                                        .profileImage.value ??
                                                    "",
                                                errorWidget: (_, __, ___) =>
                                                    SvgPicture.asset(
                                                  "assets/images/user.svg",
                                                  height: 60,
                                                  width: 60,
                                                ),
                                                placeholder: (_, __) =>
                                                    SvgPicture.asset(
                                                  "assets/images/user.svg",
                                                  height: 60,
                                                  width: 60,
                                                ),
                                                fit: BoxFit.cover,
                                              ) /*Image.file(
                              profileImage.value,
                              fit: BoxFit.cover,
                            ),*/
                                              ),
                                        ),
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: SvgPicture.asset(
                                    "assets/icon/crown2.svg",
                                    height: 16,
                                    width: 16,
                                  ))
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
                                        color: const Color(0xff180095)),
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
                                            ? const Icon(
                                                Icons.star,
                                                color: AppTheme.pinkText,
                                                size: 16,
                                              )
                                            : const Icon(
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
                                      const Icon(
                                        Icons.flag_outlined,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          profileController.model.value.data!
                                              .basicInfo!.country
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppTheme.textColor),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppTheme.whiteColor,
                                            border: Border.all(
                                                color:
                                                    const Color(0xff707070))),
                                        child: InkWell(
                                          onTap: () {
                                            showDialogueUpdateBasicInfo();
                                          },
                                          child: const Icon(
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
                                          insetPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 10),
                                          content: Form(
                                            key: _formKey,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      const Align(
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
                                                            icon: const Icon(
                                                              Icons.clear,
                                                              size: 20,
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                  const Text(
                                                    "Edit Your Title",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppTheme.textColor),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  BoxTextField(
                                                    controller: controller
                                                        .titleController,
                                                    obSecure: false.obs,
                                                    hintText:
                                                        "Website design and development"
                                                            .obs,
                                                    validator: MultiValidator([
                                                      RequiredValidator(
                                                          errorText:
                                                              'Example: Full StackDeveloper | Web & Mobile'),
                                                      MinLengthValidator(5,
                                                          errorText:
                                                              'Minimum length is 5 characters'),
                                                      MaxLengthValidator(50,
                                                          errorText:
                                                              "Maximum length is 50 characters"),
                                                    ]),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  BoxTextField(
                                                    controller: controller
                                                        .descriptionController,
                                                    obSecure: false.obs,
                                                    hintText: "description".obs,
                                                    isMulti: true,
                                                    validator: MultiValidator([
                                                      RequiredValidator(
                                                          errorText:
                                                              'Description required'),
                                                      MinLengthValidator(100,
                                                          errorText:
                                                              'Minimum length is 100 characters'),
                                                      MaxLengthValidator(5000,
                                                          errorText:
                                                              "Max Length is 5000 characters"),
                                                    ]),
                                                  ),
                                                  const SizedBox(
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
                                                                title: controller
                                                                    .titleController
                                                                    .text
                                                                    .trim(),
                                                                description:
                                                                    controller
                                                                        .descriptionController
                                                                        .text
                                                                        .trim(),
                                                                context:
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
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: const Color(0xff707070))),
                                      child: const Icon(
                                        Icons.edit,
                                        color: AppTheme.primaryColor,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              SizedBox(
                                child: profileController
                                        .model.value.data!.basicInfo!.occuption
                                        .toString()
                                        .isEmpty
                                    ? const SizedBox()
                                    : Text(
                                        profileController.model.value.data!
                                            .basicInfo!.occuption
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkBlueText),
                                      ),
                              ),
                              /*         Text(
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
                              ),*/
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
                                      fontSize: 13.sp,
                                      color: AppTheme.textColor),
                                  maxLines: controller.descTextShowFlag.value
                                      ? 10000
                                      : 6),
                              SizedBox(
                                  child: controller.textLength.value <= 200
                                      ? const SizedBox()
                                      : InkWell(
                                          onTap: () {
                                            setState(() {
                                              controller
                                                      .descTextShowFlag.value =
                                                  !controller
                                                      .descTextShowFlag.value;
                                            });
                                          },
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                controller
                                                        .descTextShowFlag.value
                                                    ? const Text(
                                                        "Show Less",
                                                        style: TextStyle(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      )
                                                    : const Text("Show More",
                                                        style: TextStyle(
                                                            color: AppTheme
                                                                .primaryColor))
                                              ]))),
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
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                topRight: Radius.circular(30))),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const RadioButtonsProfileScreen();
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: const Color(0xff707070))),
                                      child: const Icon(
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
                                            ? const Icon(
                                                Icons.star,
                                                color: AppTheme.primaryColor,
                                                size: 17,
                                              )
                                            : const Icon(
                                                Icons.star_border_outlined,
                                                color: Colors.grey,
                                                size: 17,
                                              )),
                                  ),
                                  const SizedBox(
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
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: const Color(0xff707070))),
                                      child: const Icon(
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
                                physics: const NeverScrollableScrollPhysics(),
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
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: const Color(0xff707070))),
                                      child: const Icon(
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
                                    ? const SizedBox()
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: profileController.model.value
                                            .data!.portfolio!.length,
                                        itemBuilder: (context, index) {
                                          print(profileController.model.value
                                              .data!.portfolio![index].image
                                              .toString());
                                          return Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.all(5),
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
                                              const SizedBox(
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
                                                  const SizedBox(
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: AppTheme
                                                              .whiteColor,
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0xff707070))),
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: AppTheme
                                                            .primaryColor,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
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
                                                  const SizedBox(
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
                                              const SizedBox(
                                                height: 10,
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
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: const Color(0xff707070))),
                                      child: const Icon(
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
                              testimonials(),
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
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: const Color(0xff707070))),
                                      child: const Icon(
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
                                          margin: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
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
                                                    color: const Color(
                                                        0xff363636)),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
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
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    /* Container(
                                                        height: 85,
                                                        width: 70,
                                                        child: Image.network(
                                                          "https://cdn.pixabay.com/photo/2016/02/04/12/19/gold-1179100_960_720.png",
                                                        )),
                                                    SizedBox(
                                                      width: 20,
                                                    ),*/
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
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 15),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: AppTheme
                                                                          .whiteColor,
                                                                      border: Border.all(
                                                                          color:
                                                                              const Color(0xff707070))),
                                                                  child:
                                                                      const Icon(
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
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            profileController
                                                                .model
                                                                .value
                                                                .data!
                                                                .certificates![
                                                                    index]
                                                                .description
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppTheme
                                                                    .darkBlueText),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
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
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppTheme.whiteColor,
                                        border: Border.all(
                                            color: const Color(0xff707070))),
                                    child: const Icon(
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
                                physics: const NeverScrollableScrollPhysics(),
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
                                            style: const TextStyle(
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
                                            style: const TextStyle(
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
                                            dateFormat.format(DateTime.parse(
                                                profileController
                                                    .model
                                                    .value
                                                    .data!
                                                    .employment![index]
                                                    .startDate
                                                    .toString())),
                                            style: const TextStyle(
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
                                                        .endDate
                                                        .toString() !=
                                                    "null"
                                                ? " - " +
                                                    dateFormat.format(DateTime
                                                        .parse(profileController
                                                            .model
                                                            .value
                                                            .data!
                                                            .employment![index]
                                                            .endDate
                                                            .toString()))
                                                : " - Currently working",
                                            style: const TextStyle(
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
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppTheme.whiteColor,
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xff707070))),
                                              child: const Icon(
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
                                              margin: const EdgeInsets.only(
                                                  left: 15),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppTheme.whiteColor,
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xff707070))),
                                              child: const Icon(
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
                : const Center(
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
                onTap: () => Get.toNamed(MyRouter.hoursPerWeekScreen),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.whiteColor,
                      border: Border.all(color: const Color(0xff707070))),
                  child: const Icon(
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
            profileController.model.value.data!.hoursPerWeek.toString(),
            style: TextStyle(fontSize: 13.sp, color: AppTheme.textColor),
          ),
          Row(
            children: [
              Text(
                "Hourly Price :",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                    color: AppTheme.textColor),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "\$ " +
                    profileController.model.value.data!.basicInfo!.amount
                        .toString(),
                style: TextStyle(fontSize: 13.sp, color: AppTheme.textColor),
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
                "Service",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText),
              ),
              SizedBox(
                width: 10.w,
              ),
              InkWell(
                onTap: () => services(),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.whiteColor,
                      border: Border.all(color: const Color(0xff707070))),
                  child: const Icon(
                    Icons.add,
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
            profileController.serviceController.text.toString(),
            style: TextStyle(fontSize: 13.sp, color: AppTheme.textColor),
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
                "Language",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText),
              ),
              InkWell(
                onTap: () => Get.toNamed(MyRouter.addLanguageScreen),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.whiteColor,
                      border: Border.all(color: const Color(0xff707070))),
                  child: const Icon(
                    Icons.add,
                    color: AppTheme.primaryColor,
                    size: 15,
                  ),
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(MyRouter.editLanguageScreen),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.whiteColor,
                      border: Border.all(color: const Color(0xff707070))),
                  child: const Icon(
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profileController.model.value.data!.language!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    children: [
                      Text(
                        profileController
                                .model.value.data!.language![index].language
                                .toString()
                                .capitalizeFirst! +
                            " : ",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        profileController
                            .model.value.data!.language![index].level
                            .toString(),
                        style: TextStyle(
                            fontSize: 13.sp, color: AppTheme.textColor),
                      ),
                    ],
                  ),
                );
              }),
          Divider(
            color: AppTheme.pinkText.withOpacity(.29),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Verification",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkBlueText),
            ),
            if (profileController.model.value.data!.basicInfo!.isVerified
                        .toString()
                        .toLowerCase() ==
                    "pending" ||
                profileController.model.value.data!.basicInfo!.isVerified
                        .toString()
                        .toLowerCase() ==
                    "reject")
              InkWell(
                onTap: () {
                  verification();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.whiteColor,
                      border: Border.all(color: const Color(0xff707070))),
                  child: const Icon(
                    Icons.add,
                    color: AppTheme.primaryColor,
                    size: 15,
                  ),
                ),
              ),
          ]),
          SizedBox(
            height: 10.h,
          ),
          Row(children: [
            Text(
              "ID : ",
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkBlueText),
            ),
            Text(
              profileController.model.value.data!.basicInfo!.isVerified
                  .toString(),
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkBlueText),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.verified,
              color: profileController.model.value.data!.basicInfo!.isVerified
                          .toString()
                          .toLowerCase() ==
                      "approve"
                  ? AppTheme.primaryColor
                  : Colors.grey.withOpacity(.49),
              size: 20,
            ),
          ]),

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
                              ),*/ /*
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Text(
                "ID : ",
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor),
              ),
              Text(
                "Verified",
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textColor),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.verified,color: AppTheme.primaryColor,size: 20,)
            ],
          ),*/
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
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.whiteColor,
                      border: Border.all(color: const Color(0xff707070))),
                  child: const Icon(
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
            physics: const NeverScrollableScrollPhysics(),
            itemCount: profileController.model.value.data!.education!.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    profileController.model.value.data!.education![index].school
                        .toString()
                        .capitalizeFirst!,
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff4D4D4D)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          profileController
                              .model.value.data!.education![index].degree
                              .toString(),
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textColor.withOpacity(.63)),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(MyRouter.addEducationScreen,
                                  arguments: index);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.whiteColor,
                                  border: Border.all(
                                      color: const Color(0xff707070))),
                              child: const Icon(
                                Icons.edit,
                                color: AppTheme.primaryColor,
                                size: 15,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              deleteEducationInfoRepo(
                                      profileController.model.value.data!
                                          .education![index].id
                                          .toString(),
                                      context)
                                  .then((value) {
                                if (value.status == true) {
                                  profileController.model.value.data!.education!
                                      .removeAt(index);
                                  profileController.getData();
                                }
                                showToast(value.message.toString());
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 15),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.whiteColor,
                                  border: Border.all(
                                      color: const Color(0xff707070))),
                              child: const Icon(
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
                  RichText(
                      text: TextSpan(
                          text:
                              "${profileController.model.value.data!.education![index].areaStudy} ",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff4D4D4D)),
                          children: [
                        TextSpan(
                          text:
                              "${profileController.model.value.data!.education![index].startYear} - ${profileController.model.value.data!.education![index].endYear}",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff4D4D4D)),
                        ),
                      ])),
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
                        style: const TextStyle(
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
                        style: const TextStyle(
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
                        style: const TextStyle(
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
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          profileController
                              .model.value.data!.basicInfo!.pendingProject
                              .toString(),
                          style: const TextStyle(
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

  services() {
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.modelOfService.value.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Get.back();

                        addCategoryRepo(
                                category_id: controller
                                    .modelOfService.value.data![index].id
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

  verification() {
    List dropDownValues = ["passport", "driving_license", "other"];
    String currentSelectedDocument = dropDownValues.first;
    final _formKey34 = GlobalKey<FormState>();

    Rx<File> documentFile = File("").obs;
    RxString fileName = "".obs;

    pickFileToUpload() async {
      FocusManager.instance.primaryFocus!.unfocus();
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      if (result.files.single.size / (1024 * 1024) > 10) {
        showToast("Your file size is greater then 10 MB");
        setState(() {});
      } else {
        fileName.value = result.files.first.name;
        documentFile.value = File(result.files.single.path!);
        setState(() {});
      }
    }

    Rx<File> documentFile1 = File("").obs;
    RxString fileName1 = "".obs;

    pickFileToUpload1() async {
      FocusManager.instance.primaryFocus!.unfocus();
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      if (result.files.single.size / (1024 * 1024) > 10) {
        showToast("Your file size is greater then 10 MB");
        setState(() {});
      } else {
        fileName1.value = result.files.first.name;
        documentFile1.value = File(result.files.single.path!);
        setState(() {});
      }
    }

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.size100 * .4),
            child: Obx(() {
              return Form(
                key: _formKey34,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, right: 15, left: 15, bottom: 15),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        Text(
                          "User Verification",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText),
                        ),
                        SizedBox(
                          height: AddSize.size20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Id Proof",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkBlueText),
                            ),
                            SizedBox(
                              height: AddSize.size10,
                            ),
                            DropdownButtonFormField<dynamic>(
                              alignment: Alignment.centerLeft,
                              decoration: InputDecoration(
                                hintText: 'Select id',
                                focusColor: AppTheme.textfield.withOpacity(0.5),
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                filled: true,
                                fillColor: AppTheme.whiteColor.withOpacity(0.5),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding12),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppTheme.greyTextColor
                                          .withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.greyTextColor
                                            .withOpacity(0.5)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.greyTextColor
                                            .withOpacity(0.5),
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                              isDense: false,
                              validator: (value) {
                                if (value.toString().trim().isEmpty) {
                                  return "Please select id";
                                } else {
                                  return null;
                                }
                              },
                              value: currentSelectedDocument,
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: List.generate(
                                  dropDownValues.length,
                                  (index) => DropdownMenuItem(
                                      value: dropDownValues[index].toString(),
                                      child: Text(dropDownValues[index]
                                          .toString()
                                          .capitalizeFirst!
                                          .replaceAll("_", " ")))),
                              onChanged: (val) {
                                currentSelectedDocument = val;
                                if (kDebugMode) {
                                  print(currentSelectedDocument);
                                }
                              },
                            ),
                            SizedBox(
                              height: AddSize.size25,
                            ),
                            Text(
                              "Upload Documents",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkBlueText),
                            ),
                            SizedBox(
                              height: AddSize.size10,
                            ),
                            InkWell(
                              onTap: () => pickFileToUpload(),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: const Color(0xffE1EDFB),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: documentFile.value.path == ""
                                      ? RichText(
                                          text: TextSpan(
                                              text: "Upload ",
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppTheme.primaryColor),
                                              children: [
                                                TextSpan(
                                                  text: "document front image",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppTheme
                                                          .darkBlueText),
                                                )
                                              ]),
                                        )
                                      : Text(
                                          fileName.value.toString(),
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.darkBlueText),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AddSize.size10,
                            ),
                            InkWell(
                              onTap: () => pickFileToUpload1(),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: const Color(0xffE1EDFB),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: documentFile1.value.path == ""
                                      ? RichText(
                                          text: TextSpan(
                                              text: "Upload ",
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppTheme.primaryColor),
                                              children: [
                                                TextSpan(
                                                  text: "document back image",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppTheme
                                                          .darkBlueText),
                                                )
                                              ]),
                                        )
                                      : Text(
                                          fileName1.value.toString(),
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.darkBlueText),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AddSize.size25,
                            ),
                            Row(children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomOutlineButton(
                                    title: 'cancel',
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
                                      if (_formKey34.currentState!.validate() &&
                                          documentFile.value.path != "" &&
                                          documentFile1.value.path != "") {
                                        Map map = <String, String>{};
                                        map["type"] =
                                            currentSelectedDocument.toString();
                                        userDocumentVerifyRepo(
                                                mapData: map,
                                                fieldName1: "document_front",
                                                file1: documentFile.value,
                                                fieldName2: "document_back",
                                                file2: documentFile1.value,
                                                context: context)
                                            .then((value) {
                                          if (value.status == true) {
                                            Get.back();
                                            profileController.getData();
                                          }
                                          showToast(value.message.toString());
                                        });
                                      } else {
                                        showToast(
                                            'Please add front and back documents');
                                      }
                                    },
                                    textColor: AppTheme.whiteColor,
                                    expandedValue: false,
                                  ),
                                ),
                              ),
                            ])
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

  testimonials() {
    var deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        width: deviceWidth,
        child: profileController.model.value.data!.testimonial!.isEmpty
            ? Container(
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
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
                            fontWeight: FontWeight.w300,
                            color: const Color(0xff363636)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    profileController.model.value.data!.testimonial!.length,
                itemBuilder: (BuildContext context, int index) {
                  return profileController
                              .model.value.data!.testimonial![index].status
                              .toString() ==
                          "pending"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Message :",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.darkBlueText),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    profileController.model.value.data!
                                        .testimonial![index].message
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.darkBlueText),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Request :",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.darkBlueText),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    profileController.model.value.data!
                                        .testimonial![index].requestSent
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.darkBlueText),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status :",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.darkBlueText),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    profileController.model.value.data!
                                        .testimonial![index].status
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.darkBlueText),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: AppTheme.pinkText.withOpacity(.29),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Name :",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.darkBlueText),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    "${profileController.model.value.data!.testimonial![index].firstName} ${profileController.model.value.data!.testimonial![index].lastName}",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.darkBlueText),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    deleteTestimonialInfoRepo(
                                            profileController.model.value.data!
                                                .testimonial![index].id,
                                            context)
                                        .then((value) {
                                      if (value.status == true) {
                                        print(profileController.model.value
                                            .data!.testimonial![index].id);
                                        profileController
                                            .model.value.data!.testimonial!
                                            .removeAt(index);
                                        profileController.getData();
                                      }
                                      showToast(value.message.toString());
                                      print(profileController.model.value.data!
                                          .testimonial![index].id);
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppTheme.whiteColor,
                                        border: Border.all(
                                            color: const Color(0xff707070))),
                                    child: const Icon(
                                      Icons.delete,
                                      color: AppTheme.primaryColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              maxLines: profileController.model.value.data!
                                          .testimonial![index].showText ==
                                      true
                                  ? 1000
                                  : 4,
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                  text: "Description : ",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.darkBlueText),
                                  children: [
                                    TextSpan(
                                      text: profileController.model.value.data!
                                          .testimonial![index].description
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppTheme.darkBlueText,
                                      ),
                                    )
                                  ]),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                                child: profileController.model.value.data!
                                            .testimonial![index].description
                                            .toString()
                                            .length <=
                                        200
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            profileController
                                                    .model
                                                    .value
                                                    .data!
                                                    .testimonial![index]
                                                    .showText =
                                                !profileController
                                                    .model
                                                    .value
                                                    .data!
                                                    .testimonial![index]
                                                    .showText!;
                                          });
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              profileController
                                                      .model
                                                      .value
                                                      .data!
                                                      .testimonial![index]
                                                      .showText!
                                                  ? const Text(
                                                      "Show Less",
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .primaryColor),
                                                    )
                                                  : const Text("Show More",
                                                      style: TextStyle(
                                                          color: AppTheme
                                                              .primaryColor))
                                            ]))),

                            /*Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Email :",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppTheme
                                                                        .darkBlueText),
                                                              ),
                                                              const SizedBox(
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
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppTheme
                                                                          .darkBlueText),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
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
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppTheme
                                                                        .darkBlueText),
                                                              ),
                                                              const SizedBox(
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
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppTheme
                                                                          .darkBlueText),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
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
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppTheme
                                                                        .darkBlueText),
                                                              ),
                                                              const SizedBox(
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
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppTheme
                                                                          .darkBlueText),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
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
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppTheme
                                                                        .darkBlueText),
                                                              ),
                                                              const SizedBox(
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
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: AppTheme
                                                                          .darkBlueText),
                                                                ),
                                                              ),
                                                            ],
                                                          ),*/
                            const SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: AppTheme.pinkText.withOpacity(.29),
                            ),
                          ],
                        );
                },
              ));
  }
}
