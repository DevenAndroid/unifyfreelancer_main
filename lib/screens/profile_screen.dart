import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/controller/profie_screen_controller.dart';
import 'package:unifyfreelancer/popups/radio_buttons_profile_screen.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';

import '../resources/app_theme.dart';
import '../widgets/box_textfield.dart';
import '../widgets/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<File> _files01 = [];
  var loading = null;
  int ratingValue = 0;
  final controller = Get.put(ProfileScreenController());
  String? time;

  @override
  void _pickMultipleFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> _files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        _files01 = _files;
        loading = 1;
      });
    } else {
      // User canceled the picker
    }
  }

  FilePickerResult? uploadDocument1;
  String? uploadDocumentFileName1;
  PlatformFile? uploadDocumentPickedFile1;
  bool uploadDocumentLoading1 = false;
  File? uploadDocumentDisplay1;
  String? sendingDocumentInAPI1;

  void uploadDocumentFunction1() async {
    try {
      setState(() {
        uploadDocumentLoading1 = true;
      });
      uploadDocument1 = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'docx', 'doc']);
      if (uploadDocument1 != null) {
        uploadDocumentFileName1 = uploadDocument1!.files.first.name;
        uploadDocumentPickedFile1 = uploadDocument1!.files.first;
        uploadDocumentDisplay1 =
            File(uploadDocumentPickedFile1!.path.toString());

        List<int> uploadDocument64 = uploadDocumentDisplay1!.readAsBytesSync();

        sendingDocumentInAPI1 = base64Encode(uploadDocument64);

        print("Base 64 image===> $sendingDocumentInAPI1");

        if (kDebugMode) {
          print("File name $uploadDocumentFileName1");
        }
      }

      setState(() {
        uploadDocumentLoading1 = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  FilePickerResult? uploadDocument2;
  String? uploadDocumentFileName2;
  PlatformFile? uploadDocumentPickedFile2;
  bool uploadDocumentLoading2 = false;
  File? uploadDocumentDisplay2;
  String? sendingDocumentInAPI2;

  void uploadDocumentFunction2() async {
    try {
      setState(() {
        uploadDocumentLoading2 = true;
      });
      uploadDocument2 = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'docx', 'doc']);
      if (uploadDocument2 != null) {
        uploadDocumentFileName2 = uploadDocument2!.files.first.name;
        uploadDocumentPickedFile2 = uploadDocument2!.files.first;
        uploadDocumentDisplay2 =
            File(uploadDocumentPickedFile2!.path.toString());

        List<int> uploadDocument64 = uploadDocumentDisplay2!.readAsBytesSync();

        sendingDocumentInAPI2 = base64Encode(uploadDocument64);

        print("Base 64 image===> $sendingDocumentInAPI2");

        if (kDebugMode) {
          print("File name $uploadDocumentFileName2");
        }
      }

      setState(() {
        uploadDocumentLoading2 = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  FilePickerResult? uploadDocument3;
  String? uploadDocumentFileName3;
  PlatformFile? uploadDocumentPickedFile3;
  bool uploadDocumentLoading3 = false;
  File? uploadDocumentDisplay3;
  String? sendingDocumentInAPI3;

  void uploadDocumentFunction3() async {
    try {
      setState(() {
        uploadDocumentLoading3 = true;
      });
      uploadDocument3 = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'docx', 'doc']);
      if (uploadDocument3 != null) {
        uploadDocumentFileName3 = uploadDocument3!.files.first.name;
        uploadDocumentPickedFile3 = uploadDocument3!.files.first;
        uploadDocumentDisplay3 =
            File(uploadDocumentPickedFile3!.path.toString());

        List<int> uploadDocument64 = uploadDocumentDisplay3!.readAsBytesSync();

        sendingDocumentInAPI3 = base64Encode(uploadDocument64);

        print("Base 64 image===> $sendingDocumentInAPI3");

        if (kDebugMode) {
          print("File name $uploadDocumentFileName3");
        }
      }

      setState(() {
        uploadDocumentLoading3 = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
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
      body: SingleChildScrollView(
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://images.unsplash.com/photo-1520635360276-79f3dbd809f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"))),
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: Image.asset("assets/icon/crown.png"))
                  ]),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hannah Finn",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff180095)),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          /*RatingBar.builder(
                            itemSize: 20,
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 3,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_rate_rounded,
                              color: AppTheme.pinkText,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),*/
                          Wrap(
                            children: List.generate(
                                3,
                                (index) => 3 > index
                                    ? Icon(
                                        Icons.star,
                                        color: AppTheme.pinkText,
                                      )
                                    : Icon(
                                        Icons.star_border_outlined,
                                        color: Colors.grey,
                                      )),
                          ),
                        ],
                      ),
                      Text(
                        "Website designer and developer",
                        style: TextStyle(
                            fontSize: 14.sp, color: AppTheme.textColor),
                      ),
                      Row(
                        children: [
                          Icon(Icons.flag),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "Victoria, Australia",
                            style: TextStyle(
                                fontSize: 14.sp, color: AppTheme.textColor),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.whiteColor,
                                border: Border.all(color: Color(0xff707070))),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    content: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                            "Edit Name",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.textColor),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          BoxTextField(
                                            obSecure: false.obs,
                                            hintText: "First Name".obs,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          BoxTextField(
                                            obSecure: false.obs,
                                            hintText: "Last Name".obs,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          BoxTextField(
                                            obSecure: false.obs,
                                            hintText: "description".obs,
                                            isMulti: true,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomOutlineButton(
                                            title: "Change",
                                            backgroundColor:
                                                AppTheme.primaryColor,
                                            onPressed: () {},
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
                                    color: AppTheme.darkBlueText
                                        .withOpacity(0.47)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "\$100K",
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
                                    color: AppTheme.darkBlueText
                                        .withOpacity(0.47)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "26",
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
                                    color: AppTheme.darkBlueText
                                        .withOpacity(0.47)),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "2065",
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
                                    color: AppTheme.darkBlueText
                                        .withOpacity(0.47)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("26",
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
                        Expanded(
                          child: Text(
                            "Website designer and developer",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkBlueText),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                content: Column(
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
                                      obSecure: false.obs,
                                      hintText:
                                          "Website design and development".obs,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    BoxTextField(
                                      obSecure: false.obs,
                                      hintText: "description".obs,
                                      isMulti: true,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomOutlineButton(
                                      title: "Change",
                                      backgroundColor: AppTheme.primaryColor,
                                      onPressed: () {},
                                      textColor: AppTheme.whiteColor,
                                      expandedValue: true,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
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
                                border: Border.all(color: Color(0xff707070))),
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
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the1500s, when an unknown",
                      style:
                          TextStyle(fontSize: 13.sp, color: AppTheme.textColor),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "View More",
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor),
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
                                border: Border.all(color: Color(0xff707070))),
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
                      "Experienced Developer for Wellenss",
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
                        /* RatingBar.builder(
                          itemSize: 20,
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star_rate_rounded,
                            color: AppTheme.primaryColor,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),*/

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
                              fontSize: 13.sp, color: AppTheme.textColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
                      style:
                          TextStyle(fontSize: 13.sp, color: AppTheme.textColor),
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
                          onTap: () => Get.toNamed(MyRouter.editSkillsScreen),
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
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Mobile App Development",
                      style:
                          TextStyle(fontSize: 13.sp, color: AppTheme.textColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Full Stack Development",
                      style:
                          TextStyle(fontSize: 13.sp, color: AppTheme.textColor),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "All Work",
                      style:
                          TextStyle(fontSize: 13.sp, color: AppTheme.textColor),
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
                          onTap: () => Get.toNamed(MyRouter.addPortFolioScreen),
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
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 120.h,
                      child: loading == null
                          ? InkWell(
                              onTap: () => _pickMultipleFiles(),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: AppTheme.whiteColor,
                                    border: Border.all(
                                      color: Color(0xff707070),
                                    ),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://images.unsplash.com/photo-1659686353676-8699585ff4c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"))),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: _files01.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => _pickMultipleFiles(),
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: AppTheme.whiteColor,
                                      image: DecorationImage(
                                          image: FileImage(_files01[index]),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
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
                      offset: const Offset(0, 3), // changes position of shadow
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
                          onTap: () =>
                              Get.toNamed(MyRouter.addTestimonialsScreen),
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
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                        child: uploadDocument1 == null
                            ? Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: AppTheme.whiteColor,
                                ),
                                child: InkWell(
                                  onTap: () => uploadDocumentFunction1(),
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
                                              uploadDocumentDisplay1!),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Showcase your skills with non-Unify client testimonials",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w300,
                                        color: Color(0xff363636)),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
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
                      offset: const Offset(0, 3), // changes position of shadow
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
                          onTap: () =>
                              Get.toNamed(MyRouter.addCertificationsScreen),
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
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                        child: uploadDocument2 == null
                            ? Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: AppTheme.whiteColor,
                                ),
                                child: InkWell(
                                  onTap: () => uploadDocumentFunction2(),
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
                                              uploadDocumentDisplay2!),
                                          fit: BoxFit.cover),
                                    ),
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Other Experiences",
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
                              Get.toNamed(MyRouter.addOtherExperiencesScreen),
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
                                  onTap: () => uploadDocumentFunction3(),
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
                                            fontWeight: FontWeight.w300,
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
                )),
          ],
        ),
      )),
    );
  }
}
