import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/resources/new_helper.dart';
import 'package:unifyfreelancer/widgets/add_text.dart';

import '../../controller/question_controller.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';

class ProfileImage extends StatefulWidget {
  ProfileImage({Key? key}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final List<String> photoList = [
    " Be a close-up of your face.",
    " Show your face clearly -sunglasses",
    " Be clear and crisp",
    " Have a neural background",
  ];
  final NewHelper newHelper = NewHelper();

  Rx<File> profileImage = File("").obs;

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

  final controller = Get.put(QuestionController());

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AddSize.size20,
                ),
                AddText(
                  text: "Add Profile Photo",
                  fontSize: AddSize.font20,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: AddSize.size30,
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: AddSize.screenWidth,
                      height: AddSize.size200 * .98,
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
                        height: AddSize.size200 * .92,
                        width: AddSize.size200 * .92,
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
                SizedBox(
                  height: AddSize.size40,
                ),
                OutlinedButton(
                    onPressed: () {
                      showPickImageSheet();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryColor,
                      side: BorderSide(
                          width: AddSize.size10 * .1,
                          color: AppTheme.primaryColor),
                      alignment: Alignment.center,
                      minimumSize: Size(AddSize.screenWidth, AddSize.size45),
                      shape: StadiumBorder(),
                    ),
                    child: AddText(
                      text: "  Select Profile Image  ",
                      fontSize: AddSize.font16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    )),
                SizedBox(
                  height: AddSize.size30,
                ),
                Align(
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
                )
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: AddSize.padding16).copyWith(bottom: AddSize.padding14),
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
            SizedBox(width: AddSize.size20,),
            Expanded(
              child: CustomOutlineButton(
                title: "Next",
                backgroundColor: AppTheme.primaryColor,
                textColor: AppTheme.whiteColor,
                expandedValue: false,
                onPressed: () {
                  controller.nextPage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
