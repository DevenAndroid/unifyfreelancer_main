import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unifyfreelancer/controller/profie_screen_controller.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/widgets/error_widget.dart';
import 'package:unifyfreelancer/widgets/progress_indicator.dart';

import '../Controller/jobs_detail_controller.dart';
import '../controller/proposals_screen_controller.dart';
import '../models/model_milestones.dart';
import '../popups/radio_buttons_job_details.dart';
import '../repository/job_module/send_proposal_repository.dart';
import '../resources/app_theme.dart';
import '../utils/api_contant.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_textfield.dart';

class SubmitProposalScreen extends StatefulWidget {
  const SubmitProposalScreen({Key? key}) : super(key: key);

  @override
  State<SubmitProposalScreen> createState() => _SubmitProposalScreenState();
}

class _SubmitProposalScreenState extends State<SubmitProposalScreen> {
  int? id;
  dynamic name;
  dynamic description;
  dynamic price;
  dynamic type = "";
  dynamic forInterview = "";
  dynamic proposalId = "";
  dynamic clientID = "";
  List<ModelMilestones> milestone = <ModelMilestones>[
    ModelMilestones(description: "", amount: "", dueDate: "")
  ];

  String? radioProjectType = "By project";

  @override
  void initState() {
    super.initState();
    id = Get.arguments[0];
    name = Get.arguments[1];
    description = Get.arguments[2];
    price = Get.arguments[3];
    type = Get.arguments[4];
    forInterview = Get.arguments[5];
    proposalId = Get.arguments[6];
    textLength = description.length;
    if (profileController.status.value.isSuccess &&
        type.toString().toLowerCase() == "hourly") {
      _bidController.text =
          profileController.model.value.data!.basicInfo!.amount.toString();
      hourlyPrice = double.parse(
          profileController.model.value.data!.basicInfo!.amount.toString());
      unifyFree = ((hourlyPrice! * 20) / 100).toString();
      _receiveController.text =
          (hourlyPrice! - double.parse(unifyFree!)).toString();
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bidController = TextEditingController();
  final TextEditingController _receiveController = TextEditingController();
  final TextEditingController _letterController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

/*  File imageFileToPick = File("");

  pickImageFromDevice({required imageSource}) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      imageFileToPick = File(image.path);
      setState(() {});
    } catch (e) {
      throw Exception(e);
    }
  }*/

  dynamic dateInput = 0;
  final dateFormatForShow = DateFormat('dd-MMM-yyyy');

  final dateFormatForSend = DateFormat('yyyy-MM-dd');

  final controller = Get.put(JobsDetailController());
  String descText = "";
  bool descTextShowFlag = false;
  int textLength = 0;

  double hourlyPrice = 0;
  String? unifyFree = "0";

  final profileController = Get.put(ProfileScreenController());

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
      documentFile.value = File(result.files.single.path!);
      fileName.value = result.names.first.toString();
      setState(() {});
    }
  }

  final proposalController = Get.put(ProposalScreenController());

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Submit Proposal",
        ),
      ),
      body: Obx(() {
        return profileController.status.value.isSuccess
            ? Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          name!,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff170048)),
                        ),
                        SizedBox(
                          height: deviceHeight * .02,
                        ),
                        Text(description!,
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff170048)),
                            maxLines: descTextShowFlag ? 10000 : 6),
                        SizedBox(
                            child: textLength <= 200
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        descTextShowFlag = !descTextShowFlag;
                                      });
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          descTextShowFlag
                                              ? Text(
                                                  "Show Less",
                                                  style: TextStyle(
                                                      color: AppTheme
                                                          .primaryColor),
                                                )
                                              : Text("Show More",
                                                  style: TextStyle(
                                                      color: AppTheme
                                                          .primaryColor))
                                        ]))),
                        SizedBox(
                          height: deviceHeight * .02,
                        ),
                        const Divider(
                          color: Color(0xff6D2EF1),
                        ),
                        SizedBox(
                          height: deviceHeight * .02,
                        ),
                        SizedBox(
                            child: type == "hourly"
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "What is the rate you'd like to bid for this job?",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff180D31)),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      Text(
                                        "Client's budget: \$${price!.isEmpty ? " -" : price} USD",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: const Color(0xff180D31),
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .02,
                                      ),
                                      Text(
                                        "Hourly rate",
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
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        onFieldSubmitted: (value) {
                                          hourlyPrice = double.parse(value);
                                          unifyFree =
                                              ((hourlyPrice! * 20) / 100)
                                                  .toString();
                                          _receiveController.text =
                                              (hourlyPrice! -
                                                      double.parse(unifyFree!))
                                                  .toString();
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            hourlyPrice = double.parse(value);
                                            unifyFree =
                                                ((hourlyPrice! * 20) / 100)
                                                    .toString();
                                            _receiveController
                                                .text = (hourlyPrice! -
                                                    double.parse(unifyFree!))
                                                .toString();
                                          });
                                        },
                                        controller: _bidController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          hintText: '\$',
                                          focusColor: AppTheme.primaryColor,
                                          suffixIcon: _bidController
                                                      .text.length ==
                                                  0
                                              ? Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Text(
                                                      "200.00",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: AppTheme
                                                              .hintTextColor),
                                                    ),
                                                  ))
                                              : SizedBox(),
                                          hintStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.hintTextColor),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  "Please enter hourly price"),
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
                                            unifyFree.toString()!,
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
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0),
                                              borderSide: new BorderSide(
                                                  color: AppTheme.primaryColor),
                                            ),
                                            hintText: '\$',
                                            focusColor: AppTheme.primaryColor,
                                            suffixIcon: _receiveController
                                                        .text.length ==
                                                    0
                                                ? Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: Text(
                                                        "150.00",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: AppTheme
                                                                .hintTextColor),
                                                      ),
                                                    ))
                                                : SizedBox(),
                                            hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.hintTextColor),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0),
                                              borderSide: new BorderSide(
                                                  color: AppTheme.primaryColor),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0),
                                              borderSide: new BorderSide(
                                                  color: AppTheme.primaryColor),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0),
                                              borderSide: new BorderSide(
                                                  color: AppTheme.primaryColor),
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
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          focusColor: AppTheme.primaryColor,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: new BorderSide(
                                                color: AppTheme.primaryColor),
                                          ),
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  'Please enter cover letter'),
                                        ]),
                                      ),
                                      /*SizedBox(
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
                              border:
                              Border.all(color: AppTheme.primaryColor),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Text(
                                  controller.coverLaterText.isEmpty
                                      ? 'Select a duration'
                                      : controller.coverLaterText
                                      .toString(),
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
                      ),*/
                                      SizedBox(
                                        height: deviceHeight * .025,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          pickFileToUpload();
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppTheme.primaryColor)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        child: documentFile
                                                                    .value
                                                                    .path ==
                                                                ""
                                                            ? Image.asset(
                                                                "assets/icon/script.png")
                                                            : InkWell(
                                                                onTap: () {
                                                                  documentFile
                                                                          .value =
                                                                      File("");
                                                                },
                                                                child: Icon(Icons
                                                                    .clear, color: AppTheme.pinkText,)),
                                                      ),
                                                      SizedBox(
                                                        width: 15.w,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          documentFile.value
                                                                      .path ==
                                                                  ""
                                                              ? "Attach Files"
                                                              : fileName.value
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300),
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppTheme
                                                            .whiteColor),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .02,
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                        "Client's budget: \$${price!.isEmpty ? " -" : price} USD",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: const Color(0xff180D31),
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .02,
                                      ),
                                      RadioListTile(
                                          title: Text(
                                            "By project",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppTheme.darkBlueText,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          subtitle: Text(
                                            "Get your entire payment at the end, when all work has been delivered",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppTheme.darkBlueText,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          dense: true,
                                          visualDensity: const VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          value: "By project",
                                          groupValue: radioProjectType,
                                          onChanged: (value) {
                                            setState(() {
                                              radioProjectType =
                                                  value.toString();
                                              print(radioProjectType);
                                              milestone.clear();
                                            });
                                          }),
                                      RadioListTile(
                                          title: Text(
                                            "By milestone",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppTheme.darkBlueText,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          subtitle: Text(
                                            "Divide the project into smaller segments, called milestones. You'll be paid for milestones as they are completed and approved",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppTheme.darkBlueText,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          dense: true,
                                          visualDensity: const VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          value: "By milestone",
                                          groupValue: radioProjectType,
                                          onChanged: (value) {
                                            setState(() {
                                              radioProjectType =
                                                  value.toString();
                                              print(radioProjectType);
                                              // milestone.add(ModelMilestones(description: "", amount: "", dueDate: ""));
                                            });
                                          }),
                                      SizedBox(
                                        height: deviceHeight * .02,
                                      ),
                                      SizedBox(
                                        child: radioProjectType ==
                                                "By milestone"
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "How many milestones do you want to include?",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xff180D31)),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .01,
                                                  ),
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          milestone.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        print(milestone.length);
                                                        print(milestone);
                                                        return mileStones(
                                                            deviceHeight,
                                                            index,
                                                            milestone[index]);
                                                      }),
                                                  SizedBox(
                                                    height: deviceHeight * .03,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        milestone.add(
                                                            ModelMilestones(
                                                                description: "",
                                                                amount: "",
                                                                dueDate: ""));
                                                      });
                                                    },
                                                    child: Text(
                                                        "+ Add milestone",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppTheme
                                                                .primaryColor)),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .025,
                                                  ),
                                                  Text(
                                                    "Cover Letter",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: AppTheme
                                                            .darkBlueText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .010,
                                                  ),
                                                  TextFormField(
                                                    onChanged: (value) {
                                                      setState(() {});
                                                    },
                                                    controller:
                                                        _letterController,
                                                    maxLines: 4,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      border:
                                                          new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      focusColor:
                                                          AppTheme.primaryColor,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                    ),
                                                    validator: MultiValidator([
                                                      RequiredValidator(
                                                          errorText:
                                                              'Please enter cover letter'),
                                                    ]),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .02,
                                                  ),
                                                  Text(
                                                    "How long will this project take?",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: AppTheme
                                                            .darkBlueText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .01,
                                                  ),
                                                  TextFormField(
                                                    onChanged: (value) {
                                                      setState(() {});
                                                    },
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return RadioButtonsJobDetails();
                                                        },
                                                      );
                                                    },
                                                    readOnly: true,
                                                    controller: controller
                                                        .durationController,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      border:
                                                          new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      hintText:
                                                          "Select a duration",
                                                      focusColor:
                                                          AppTheme.primaryColor,
                                                      suffixIcon: Icon(Icons
                                                          .keyboard_arrow_down_outlined),
                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppTheme
                                                              .hintTextColor),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                    ),
                                                    validator: MultiValidator([
                                                      RequiredValidator(
                                                          errorText:
                                                              'Select a duration'),
                                                    ]),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .025,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      pickFileToUpload();
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: AppTheme
                                                                    .primaryColor)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    child: documentFile
                                                                        .value
                                                                        .path ==
                                                                        ""
                                                                        ? Image.asset(
                                                                        "assets/icon/script.png")
                                                                        : InkWell(
                                                                        onTap: () {
                                                                          documentFile
                                                                              .value =
                                                                              File("");
                                                                        },
                                                                        child: Icon(Icons
                                                                            .clear, color: AppTheme.pinkText,)),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15.w,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      documentFile.value.path ==
                                                                              ""
                                                                          ? "Attach Files"
                                                                          : fileName
                                                                              .value
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w300),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              color: AppTheme
                                                                  .pinkText,
                                                              child: Text(
                                                                "Choose File",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppTheme
                                                                        .whiteColor),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "What is the full amount you like to bid for this job ?",
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: const Color(
                                                            0xff180D31)),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .01,
                                                  ),
                                                  Text(
                                                    "Bid",
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: const Color(
                                                            0xff180D31)),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .01,
                                                  ),
                                                  Text(
                                                    "Total amount the client will see on your proposal",
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: const Color(
                                                            0xff170048),
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .01,
                                                  ),
                                                  TextFormField(
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onFieldSubmitted: (value) {
                                                      hourlyPrice =
                                                          double.parse(value);
                                                      unifyFree =
                                                          ((hourlyPrice! * 20) /
                                                                  100)
                                                              .toString();
                                                      _receiveController
                                                          .text = (hourlyPrice! -
                                                              double.parse(
                                                                  unifyFree!))
                                                          .toString();
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        hourlyPrice =
                                                            double.parse(value);
                                                        unifyFree =
                                                            ((hourlyPrice! *
                                                                        20) /
                                                                    100)
                                                                .toString();
                                                        _receiveController
                                                            .text = (hourlyPrice! -
                                                                double.parse(
                                                                    unifyFree!))
                                                            .toString();
                                                      });
                                                    },
                                                    controller: _bidController,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      border:
                                                          new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      hintText: '\$',
                                                      focusColor:
                                                          AppTheme.primaryColor,
                                                      suffixIcon: _bidController
                                                                  .text
                                                                  .length ==
                                                              0
                                                          ? Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10.0),
                                                                child: Text(
                                                                  "200.00",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: AppTheme
                                                                          .hintTextColor),
                                                                ),
                                                              ))
                                                          : SizedBox(),
                                                      hintStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppTheme
                                                              .hintTextColor),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                    ),
                                                    validator: MultiValidator([
                                                      RequiredValidator(
                                                          errorText:
                                                              'Please enter bid'),
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
                                                            color: AppTheme
                                                                .darkBlueText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        "Explain this",
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: AppTheme
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                                            color: AppTheme
                                                                .darkBlueText,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        width: 135.w,
                                                      ),
                                                      Text(
                                                        unifyFree!,
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: AppTheme
                                                              .darkBlueText,
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
                                                        color: AppTheme
                                                            .darkBlueText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .01,
                                                  ),
                                                  Text(
                                                    "This estimated amount you receiver after service",
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color:
                                                          AppTheme.textColor2,
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
                                                      controller:
                                                          _receiveController,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        10),
                                                        border:
                                                            new OutlineInputBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  5.0),
                                                          borderSide: new BorderSide(
                                                              color: AppTheme
                                                                  .primaryColor),
                                                        ),
                                                        hintText: '\$',
                                                        focusColor: AppTheme
                                                            .primaryColor,
                                                        suffixIcon: _receiveController
                                                                    .text
                                                                    .length ==
                                                                0
                                                            ? Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10.0),
                                                                  child: Text(
                                                                    "150.00",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: AppTheme
                                                                            .hintTextColor),
                                                                  ),
                                                                ))
                                                            : SizedBox(),
                                                        hintStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppTheme
                                                                .hintTextColor),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  5.0),
                                                          borderSide: new BorderSide(
                                                              color: AppTheme
                                                                  .primaryColor),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  5.0),
                                                          borderSide: new BorderSide(
                                                              color: AppTheme
                                                                  .primaryColor),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  5.0),
                                                          borderSide: new BorderSide(
                                                              color: AppTheme
                                                                  .primaryColor),
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    height: deviceHeight * .025,
                                                  ),
                                                  Text(
                                                    "Cover Letter",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: AppTheme
                                                            .darkBlueText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .010,
                                                  ),
                                                  TextFormField(
                                                    onChanged: (value) {
                                                      setState(() {});
                                                    },
                                                    controller:
                                                        _letterController,
                                                    maxLines: 4,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      border:
                                                          new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      focusColor:
                                                          AppTheme.primaryColor,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                    ),
                                                    validator: MultiValidator([
                                                      RequiredValidator(
                                                          errorText:
                                                              'Please enter cover letter'),
                                                    ]),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .02,
                                                  ),
                                                  Text(
                                                    "How long will this project take?",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: AppTheme
                                                            .darkBlueText,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .01,
                                                  ),
                                                  /*    InkWell(
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
                                    border:
                                    Border.all(color: AppTheme.primaryColor),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() {
                                      return Text(
                                        controller.duration.isEmpty
                                            ? 'Select a duration'
                                            : controller.duration
                                            .toString(),
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
                            ),*/

                                                  TextFormField(
                                                    onChanged: (value) {
                                                      setState(() {});
                                                    },
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return RadioButtonsJobDetails();
                                                        },
                                                      );
                                                    },
                                                    readOnly: true,
                                                    controller: controller
                                                        .durationController,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      border:
                                                          new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      hintText:
                                                          "Select a duration",
                                                      focusColor:
                                                          AppTheme.primaryColor,
                                                      suffixIcon: Icon(Icons
                                                          .keyboard_arrow_down_outlined),
                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppTheme
                                                              .hintTextColor),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: new BorderSide(
                                                            color: AppTheme
                                                                .primaryColor),
                                                      ),
                                                    ),
                                                    validator: MultiValidator([
                                                      RequiredValidator(
                                                          errorText:
                                                              'Select a duration'),
                                                    ]),
                                                  ),
                                                  SizedBox(
                                                    height: deviceHeight * .025,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      pickFileToUpload();
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: AppTheme
                                                                    .primaryColor)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    child: documentFile
                                                                        .value
                                                                        .path ==
                                                                        ""
                                                                        ? Image.asset(
                                                                        "assets/icon/script.png")
                                                                        : InkWell(
                                                                        onTap: () {
                                                                          documentFile
                                                                              .value =
                                                                              File("");
                                                                        },
                                                                        child: Icon(Icons
                                                                            .clear, color: AppTheme.pinkText,)),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15.w,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      documentFile.value.path ==
                                                                              ""
                                                                          ? "Attach Files"
                                                                          : fileName
                                                                              .value
                                                                              .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w300),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              color: AppTheme
                                                                  .pinkText,
                                                              child: Text(
                                                                "Choose File",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppTheme
                                                                        .whiteColor),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .025,
                                      ),
                                    ],
                                  )),
                        CustomOutlineButton(
                          onPressed: () {
                            /*for(var item in milestone){
                              print(item.dueDate.toString());
                            }*/
                            if( radioProjectType == "By milestone"){
                              for(int i = 0; i < milestone.length; i++){
                                milestone[i].dueDate = dateFormatForSend.format(DateTime.parse(milestone[i].dueDate.toString())).toString();
                                print(milestone[i].dueDate);
                              }
                            }
                            if (_formKey.currentState!.validate()) {
                              Map map = <String, String>{};
                              map['job_id'] = id.toString();
                              // map['client_id'] = clientID.toString();
                              if (radioProjectType == "By project") {
                                map['bid_amount'] = _bidController.text.trim();
                              }
                              map['cover_letter'] =
                                  _letterController.text.trim();
                              if (type.toString().toLowerCase() == "fixed") {
                                map['milestone_type'] =
                                    radioProjectType == "By milestone"
                                        ? "multiple"
                                        : "single";
                              }

                              if (radioProjectType == "By milestone") {
                                map["milestone_data"] = jsonEncode(milestone);
                              }

                              // map['budget_type'] = type.toString();
                              if (type.toString().toLowerCase() == "fixed") {
                                map['project_duration'] = controller.duration.toString()!;
                              }
                              if(forInterview == "fromInvite"){
                                map['invite_id'] = proposalId.toString();
                              }
                              print(map);
                              sendProposalRepo(
                                      mapData: map,
                                      fieldName1: "image",
                                      file1: documentFile.value,
                                      context: context)
                                  .then((value) {
                                if (value.status == true) {
                                  Get.offNamed(MyRouter.bottomNavbar);
                                  proposalController.getData();
                                }
                                showToast(value.message.toString());
                              });
                            }
                          },
                          title: "Submit Proposal",
                          textColor: AppTheme.whiteColor,
                          expandedValue: true,
                          backgroundColor: AppTheme.primaryColor,
                        ),
                        SizedBox(
                          height: deviceHeight * .025,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : profileController.status.value.isError
                ? CommonErrorWidget(
                    errorText: profileController.model.value.message.toString(),
                    onTap: () {
                      profileController.getData();
                    })
                : CommonProgressIndicator();
      }),
    );
  }

  Column mileStones(double deviceHeight, int index, listIndex) {
    final TextEditingController _descriptionController = TextEditingController();
    final TextEditingController _dueDateController = TextEditingController();
    final TextEditingController _amountController = TextEditingController();

    /*   Map map = <String,dynamic>{};
    map["description"] = _descriptionController.text;
    map["Due date"] = _dueDateController.text;
    map["amount"] = _amountController.text;*/
    // milestone.contains(index,ModelMilestones(description: _descriptionController.text.trim() ,amount: _amountController.text.trim(),dueDate:_dueDateController.text.trim()));
    _descriptionController.text = milestone[index].description.toString();
    _dueDateController.text = milestone[index].dueDate.toString() != "" ? dateFormatForShow.format(DateTime.parse(milestone[index].dueDate.toString())) : "";
    _amountController.text = milestone[index].amount.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: deviceHeight * .01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${index + 1} Description",
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff180D31)),
            ),
            index == 0
                ? SizedBox()
                : IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        milestone.removeLast();
                      });
                    },
                  )
          ],
        ),
        CustomTextField(
          controller: _descriptionController,
          obSecure: false.obs,
          keyboardType: TextInputType.text,
          hintText: "".obs,
          onChanged: (value) {
            milestone[index].description = value.toString();
          },
          validator: MultiValidator([
            RequiredValidator(errorText: 'Please add description'),
          ]),
        ),
        SizedBox(
          height: deviceHeight * .02,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Due date",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff180D31)),
                  ),
                  CustomTextField(
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100));
                      if (pickedDate != null) {
                        print(pickedDate);
                        //  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        _dueDateController.text = dateFormatForShow.format(pickedDate);
                    //    print(pickedDate.millisecondsSinceEpoch);
                        setState(() {
                          dateInput = _dueDateController.text;
                          milestone[index].dueDate = pickedDate.toString();
                        });
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: AppTheme.primaryColor,
                    ),
                    controller: _dueDateController,
                    obSecure: false.obs,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "".obs,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Please add due date'),
                    ]),
                   /* onChanged: (value) {
                      milestone[index].dueDate = value.toString();
                    },*/
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Amount",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff180D31)),
                  ),
                  CustomTextField(
                    controller: _amountController,
                    prefix: Icon(
                      Icons.attach_money,
                      size: 20,
                      color: AppTheme.primaryColor,
                    ),
                    onChanged: (value) {
                      milestone[index].amount = value.toString();
                    },
                    obSecure: false.obs,
                    inputFormatters1: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.text,
                    hintText: "".obs,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Please add amount'),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: deviceHeight * .015,
        ),
        const Divider(
          thickness: 0.2,
          color: Color(0xff6D2EF1),
        ),
        SizedBox(
          height: deviceHeight * .01,
        ),
      ],
    );
  }
}
