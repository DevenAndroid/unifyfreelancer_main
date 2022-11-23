import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/resources/new_helper.dart';

import 'package:unifyfreelancer/widgets/common_outline_button.dart';

import '../../controller/profie_screen_controller.dart';
import '../../models/model_countrylist.dart';
import '../../repository/countrylist_repository.dart';
import '../../repository/edit_location_repository.dart';
import '../../repository/edit_name_info_repository.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/custom_textfield.dart';

class ProfileQuestions extends StatefulWidget {
  ProfileQuestions({Key? key}) : super(key: key);

  @override
  State<ProfileQuestions> createState() => _ProfileQuestionsState();
}

class _ProfileQuestionsState extends State<ProfileQuestions> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryListRepo().then((value) => setState(() {
      countryList = value;
    }));
  }

  final List<String> photoList = [
    " Be a close-up of your face.",
    " Show your face clearly -sunglasses",
    " Be clear and crisp",
    " Have a neural background",
  ];
  final NewHelper newHelper = NewHelper();

  Rx<File> profileImage = File("").obs;
  ModelCountryList countryList = ModelCountryList();
  RxList searchList1 = <String>[].obs;


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

  showDialogue(){


    showDialog(context: context, builder: (context){
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: AddSize.padding16),
        child: Form(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [


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
                            // if (_formKey.currentState!.validate()) {
                            //   editEmploymentInfoRepo(
                            //       id: parentIndex == -10000 ? parentIndex :
                            //       controller.model.value.data!.employment![parentIndex].id.toString(),
                            //       subject: _titleController.text.trim(),
                            //       description:
                            //       _descriptionController.text.trim(),
                            //       company: _companyController.text.trim(),
                            //       city: _cityController.text.trim(),
                            //       country: countryController.text.trim(),
                            //       start_date: _fromController.text.trim(),
                            //       end_date: _toController.text.trim(),
                            //       currently_working:
                            //       acceptTermsOrPrivacy == true ? 1 : 0,
                            //       context: context)
                            //       .then((value) {
                            //     if (value.status == true) {
                            //       Get.back();
                            //       controller.getData();
                            //     }
                            //     showToast(value.message.toString());
                            //   });
                            // }
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



  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ProfileScreenController());

  bool profilePart = false;
  bool formPart = false;

  check(){
    if(profilePart == true && formPart == true ){
      controller.nextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Obx(() {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding14),
            width: AddSize.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AddSize.size20,
                ),
                Text(
                  "A few last details - then you can check and publish your profile.",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "A professional photo helps you build trust with your clients. To keep things safe and simple, they'll pay you through us - which is why we need your personal information.",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font12),
                ),
                SizedBox(
                  height: AddSize.size20,
                ),
               formData(),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomOutlineButton(
                          title: 'Back',
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
                          title: 'Next',
                          backgroundColor: AppTheme.primaryColor,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if(profileImage.value.path != ""){
                                Map<String, String> map = {};
                                map["first_name"] = controller.model.value.data!.basicInfo!.firstName.toString();
                                editNameInfoRepo(mapData: map, fieldName1: "profile_image", file1: profileImage.value, context: context).then((value) {
                                  if (value.status == true) {
                                    profilePart = true;
                                    check();
                                  }
                                  showToast(value.message.toString());
                                });

                              }
                              else{
                                profilePart = true;
                                check();
                              }

                              editLocationRepo(
                                  phone: controller.phoneController.text.trim(),
                                  zip_code: controller.zipController.text.trim(),
                                  address: controller.addressController.text.trim(),
                                  city: controller.cityController.text.trim(),
                                  country: controller.countryController.text.trim(),
                                  context: context).then((value) {
                                print(jsonEncode(value));
                                if (value.status == true) {
                                  controller.nextPage();
                                  formPart = true;
                                  check();
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
                ),

                /*Align(
                  alignment: Alignment.centerLeft,
                  child: AddText(
                    text: "Your photo should:",
                    fontWeight: FontWeight.w600,
                    fontSize: AddSize.size15,
                  ),
                ),
                SizedBox(
                  height: AddSize.size25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        photoList.length,
                        (index) => Padding(
                              padding:
                                  EdgeInsets.only(bottom: AddSize.size10 * .8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: AddSize.size14,
                                  ),
                                  Icon(
                                    Icons.circle,
                                    size: AddSize.size10 * .8,
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
                )*/
              ],
            ),
          );
        }),
      ),
    );
  }

  formData() {
    return   Form(
      key: _formKey,
      child: Container(
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
              offset: const Offset(
                  0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
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
                    margin: EdgeInsets.only(top: AddSize.size10),
                    child: profileImage.value.path == ""
                        ? Icon(
                      Icons.person_add_alt_1,
                      color: Colors.white,
                      size: AddSize.size30,
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
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

            CustomOutlineButton(title: "Upload Photo",
                backgroundColor: AppTheme.whiteColor,
                textColor: AppTheme.primaryColor,
                onPressed: (){
                  showPickImageSheet();
                }),
            SizedBox(
              height: AddSize.size30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Country*",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff393939)),
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
                CustomTextField(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    searchList1.clear();
                    for (var item in countryList.countrylist!) {
                      searchList1.add(item.name.toString());
                    }
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
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
                                  icon: Icon(
                                    Icons.clear,
                                    color: AppTheme.blackColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10)
                                    .copyWith(top: 0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value != "") {
                                      searchList1.clear();
                                      // searchList1.value = countryList.countrylist!.map((e) => e.name!.toLowerCase().contains(value.toLowerCase())).toList();
                                      for (var item in countryList
                                          .countrylist!) {
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
                                          .countrylist!) {
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
                                    prefixIcon: Icon(Icons.flag),
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
                                      BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: searchList1.length,
                                      itemBuilder: (context, index) {
                                        return Obx(() {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                controller.countryController
                                                    .text =
                                                    searchList1[index]
                                                        .toString();
                                              });
                                              print(controller.countryController
                                                  .text);
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    30,
                                                    vertical: 10),
                                                child: Text(
                                                  searchList1[index]
                                                      .toString(),
                                                  style: TextStyle(
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
                  controller: controller.countryController,
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                  obSecure: false.obs,
                  hintText: "".obs,
                  keyboardType: TextInputType.text,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: 'Country is required'),
                  ]),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "Street address* (won't show on profile)",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff393939)),
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
                CustomTextField(
                  controller: controller.addressController,
                  obSecure: false.obs,
                  hintText: "".obs,
                  keyboardType: TextInputType.text,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: 'Street address is required'),
                  ]),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "City*",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff393939)),
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
                CustomTextField(
                  controller: controller.cityController,
                  obSecure: false.obs,
                  hintText: "".obs,
                  keyboardType: TextInputType.text,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: 'City is required'),
                  ]),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "Zip/Postal Code",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff393939)),
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
                CustomTextField(
                  controller: controller.zipController,
                  obSecure: false.obs,
                  hintText: "".obs,
                  keyboardType: TextInputType.text,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: 'Zip/Postal code is required'),
                  ]),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "Phone Number",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff393939)),
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
                CustomTextField(
                  controller: controller.phoneController,
                  obSecure: false.obs,
                  hintText: "".obs,
                  keyboardType: TextInputType.text,
                  validator: MultiValidator([
                    RequiredValidator(
                        errorText: 'Phone number is required'),
                  ]),
                ),

                SizedBox(
                  height: AddSize.size15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
