import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unifyfreelancer/controller/jobs_list_controller.dart';
import 'package:unifyfreelancer/popups/radio_buttons_job_details.dart';
import '../../resources/app_theme.dart';
import '../../widgets/custom_appbar.dart';
import '../Controller/jobs_detail_controller.dart';
import '../repository/send_proposal_repository.dart';
import '../routers/my_router.dart';
import '../utils/api_contant.dart';
import '../widgets/appDrawer.dart';
import '../widgets/common_outline_button.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bidController = TextEditingController();
  final _receiveController = TextEditingController();
  final _letterController = TextEditingController();

  String? time;

  final controller = Get.put(JobsDetailController());
  final jobController = Get.put(JobListController());
  int pageIndex = -1000;
  var name;
  var budgetType;
  var projectDuration;
  var experienceLevel;
  var description;
  var skills = [];
  var price;
  var id;

  @override
  void initState() {
    super.initState();
    pageIndex = Get.arguments[0];
    name = Get.arguments[1];
    budgetType = Get.arguments[2];
    projectDuration = Get.arguments[3];
    experienceLevel = Get.arguments[4];
    description = Get.arguments[5];
    skills = Get.arguments[6];
    price = Get.arguments[7];
    id = Get.arguments[8];
  }

  File imageFileToPick = File("");

  pickImageFromDevice({required imageSource}) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      imageFileToPick = File(image.path);
      setState(() {});
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: true,
          isProfileImage: false,
          titleText: "Job Details",
        ),
      ),
      drawer: AppDrawerScreen(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 10),
                  width: deviceWidth,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
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
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: deviceWidth * .01,
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkBlueText,
                              ),
                            ),
                            SizedBox(
                              height: deviceHeight * .03,
                            ),
                            /*Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: AppTheme.pinkText,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "Remote",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff180D31)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset("assets/icon/script.png"),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      " Digital Marketing",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff180D31)),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: deviceHeight * .01,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.watch_later_outlined,
                                      color: AppTheme.pinkText,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "January 15, 2021",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff180D31)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: deviceHeight * .03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Freelancer Type",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color(0xff180D31)),
                                    ),
                                    SizedBox(
                                      height: deviceHeight * .01,
                                    ),
                                    Text(
                                      "Individual",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff180D31)),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Project Duration",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color(0xff180D31)),
                                    ),
                                    SizedBox(
                                      height: deviceHeight * .01,
                                    ),
                                    Text(
                                      "1-5 Days",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff180D31)),
                                    )
                                  ],
                                ),
                              ],
                            ),*/

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Less then 30hr/week",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff6B6B6B)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      budgetType,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff170048)),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Project Duration",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff6B6B6B)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      projectDuration,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff170048)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Experience Level",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff6B6B6B)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      experienceLevel,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff170048)),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      const Divider(
                        color: Color(0xff6D2EF1),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff170048)),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Text(
                        experienceLevel,
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xff6B6B6B)),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      const Divider(
                        color: Color(0xff6D2EF1),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Text(
                        "Skills Required",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff170048)),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Wrap(
                        children: List.generate(
                            skills.length,
                            (index) => Container(
                                margin: EdgeInsets.only(right: 4, bottom: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.whiteColor,
                                      side: const BorderSide(
                                        color: Color(0xff6D2EF1),
                                      ),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      )),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  onPressed: () {},
                                  child: Text(
                                    skills[index].name.toString(),
                                    style:
                                        TextStyle(color: AppTheme.primaryColor),
                                  ),
                                ))),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      const Divider(
                        color: Color(0xff6D2EF1),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Text(
                        "Terms",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff170048)),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      Text(
                        "Client's budget: \$$price USD",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xff180D31),
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      Text(
                        "What is the full amount you like to bid for this job?",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff180D31)),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      Text(
                        "Bid",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff180D31)),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      Text(
                        "Total amount the client will see on your proposal",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xff170048),
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: _bidController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                                new BorderSide(color: AppTheme.primaryColor),
                          ),
                          hintText: '\$',
                          focusColor: AppTheme.primaryColor,
                          suffixIcon: _bidController.text.length == 0
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "200.00",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppTheme.hintTextColor),
                                    ),
                                  ))
                              : SizedBox(),
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.hintTextColor),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                                new BorderSide(color: AppTheme.primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                                new BorderSide(color: AppTheme.primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                                new BorderSide(color: AppTheme.primaryColor),
                          ),
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Bid is required'),
                        ]),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      const Divider(
                        color: Color(0xff6D2EF1),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Row(
                        children: [
                          Text(
                            "Unify service fees ",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: AppTheme.darkBlueText,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Explain this",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Row(
                        children: [
                          Text(
                            "\$",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: AppTheme.darkBlueText,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 135.w,
                          ),
                          Text(
                            "-40.00",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppTheme.darkBlueText,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      const Divider(
                        color: Color(0xff6D2EF1),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Text(
                        "You Receive",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppTheme.darkBlueText,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      Text(
                        "This estimated amount you receiver after service",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w300,
                          color: AppTheme.textColor2,
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      TextFormField(
                          onChanged: (value) {
                            setState(() {});
                          },
                          readOnly: true,
                          controller: _receiveController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide:
                                  new BorderSide(color: AppTheme.primaryColor),
                            ),
                            hintText: '\$',
                            focusColor: AppTheme.primaryColor,
                            suffixIcon: _receiveController.text.length == 0
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "150.00",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppTheme.hintTextColor),
                                      ),
                                    ))
                                : SizedBox(),
                            hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.hintTextColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide:
                                  new BorderSide(color: AppTheme.primaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide:
                                  new BorderSide(color: AppTheme.primaryColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide:
                                  new BorderSide(color: AppTheme.primaryColor),
                            ),
                          )),
                      SizedBox(
                        height: deviceHeight * .025,
                      ),
                      Text(
                        "Cover Letter",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppTheme.darkBlueText,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: deviceHeight * .010,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: _letterController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                                new BorderSide(color: AppTheme.primaryColor),
                          ),
                          focusColor: AppTheme.primaryColor,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                                new BorderSide(color: AppTheme.primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                                new BorderSide(color: AppTheme.primaryColor),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                                new BorderSide(color: AppTheme.primaryColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                                new BorderSide(color: AppTheme.primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:
                                new BorderSide(color: AppTheme.primaryColor),
                          ),
                        ),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Cover letter is required'),
                        ]),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Text(
                        "How long will this project take?",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppTheme.darkBlueText,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RadioButtonsJobDetails();
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppTheme.primaryColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Text(
                                  controller.coverLaterText.isEmpty
                                      ? 'Select a duration'
                                      : controller.coverLaterText.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xff431444)),
                                );
                              }),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppTheme.blackColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * .025,
                      ),
                      InkWell(
                        onTap: () {
                          pickImageFromDevice(imageSource: ImageSource.gallery);
                        },
                        child: Container(
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppTheme.primaryColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Image.asset("assets/icon/script.png"),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Expanded(
                                        child: Text(
                                          imageFileToPick.path == ""
                                              ? "Attach Files"
                                              : imageFileToPick.path.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  color: AppTheme.pinkText,
                                  child: Text(
                                    "Choose File",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.whiteColor),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: deviceHeight * .025,
                      ),
                      CustomOutlineButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              imageFileToPick.path != "") {
                            if (controller.coverLaterText.isNotEmpty) {
                              Map<String, String> map = {};
                              map["job_id"] = id;
                               map["bid_amount"] = _bidController.text.trim();
                               map["cover_letter"] = _bidController.text.trim();
                               map["project_duration"] = controller.coverLaterText.toString();
                              sendProposalRepo(
                                mapData: map,
                                fieldName1: "image",
                                file1: imageFileToPick,
                                context: context,
                              ).then((value) {
                                if (value.status == true) {
                                  Get.back();
                                }
                                showToast(value.message.toString());
                              });
                            }
                            else{
                              showToast("Please select duration");
                            }
                          } else {
                            showToast("Please add a file");
                          }
                        },
                        title: "Send Proposal",
                        textColor: AppTheme.whiteColor,
                        expandedValue: true,
                        backgroundColor: AppTheme.primaryColor,
                      ),
                      SizedBox(
                        height: deviceHeight * .025,
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
