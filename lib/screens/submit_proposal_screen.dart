import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Controller/jobs_detail_controller.dart';
import '../popups/radio_buttons_job_details.dart';
import '../resources/app_theme.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_textfield.dart';

class SubmitProposalScreen extends StatefulWidget {
  const SubmitProposalScreen({Key? key}) : super(key: key);

  @override
  State<SubmitProposalScreen> createState() => _SubmitProposalScreenState();
}

class _SubmitProposalScreenState extends State<SubmitProposalScreen> {
  String? name;
  String? description;
  String? price;
  String type = "By project";


  List milestone = [];

  @override
  void initState() {
    super.initState();
    name = Get.arguments[0];
    description = Get.arguments[1];
    price = Get.arguments[2];
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bidController = TextEditingController();
  final TextEditingController _receiveController = TextEditingController();
  final TextEditingController _letterController = TextEditingController();

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

  // for(var i = 1; i++, i<=100){
  // TextEditingController _description = TextEditingController();
  //
  // }

  final controller = Get.put(JobsDetailController());

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
      body: SingleChildScrollView(
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
              Text(
                description!,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff170048)),
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
                  contentPadding: const EdgeInsets.all(0),
                  dense: true,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  value: "By project",
                  groupValue: type,
                  onChanged: (value) {
                    setState(() {
                      type = value.toString();
                      print(type);
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
                  contentPadding: const EdgeInsets.all(0),
                  dense: true,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  value: "By milestone",
                  groupValue: type,
                  onChanged: (value) {
                    setState(() {
                      type = value.toString();
                      print(type);
                    });
                  }),
              SizedBox(
                height: deviceHeight * .02,
              ),
              SizedBox(
                child: type == "By milestone"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "How many milestones do you want to include?",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff180D31)),
                          ),
                          SizedBox(
                            height: deviceHeight * .01,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: milestone.length,
                              itemBuilder: (context, index) {
                                return mileStones(deviceHeight, index, milestone[index]);
                              }),
                          SizedBox(
                            height: deviceHeight * .03,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                milestone.add("");
                              });
                            },
                            child: Text("+ Add milestone",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primaryColor)),
                          ),
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
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              focusColor: AppTheme.primaryColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
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
                          ),
                          SizedBox(
                            height: deviceHeight * .025,
                          ),
                          InkWell(
                            onTap: () {
                              pickImageFromDevice(
                                  imageSource: ImageSource.gallery);
                            },
                            child: Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppTheme.primaryColor)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                                  : imageFileToPick.path
                                                  .toString(),
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
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "What is the full amount you like to bid for this job ?",
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              hintText: '\$',
                              focusColor: AppTheme.primaryColor,
                              suffixIcon: _bidController.text.length == 0
                                  ? Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
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
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
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
                                  borderSide: new BorderSide(
                                      color: AppTheme.primaryColor),
                                ),
                                hintText: '\$',
                                focusColor: AppTheme.primaryColor,
                                suffixIcon: _receiveController.text.length == 0
                                    ? Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
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
                                  borderSide: new BorderSide(
                                      color: AppTheme.primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
                                  borderSide: new BorderSide(
                                      color: AppTheme.primaryColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(5.0),
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
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              focusColor: AppTheme.primaryColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                    color: AppTheme.primaryColor),
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
                          ),
                          SizedBox(
                            height: deviceHeight * .025,
                          ),
                          InkWell(
                            onTap: () {
                              pickImageFromDevice(
                                  imageSource: ImageSource.gallery);
                            },
                            child: Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppTheme.primaryColor)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  : imageFileToPick.path
                                                      .toString(),
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
                        ],
                      ),
              ),
              SizedBox(
                height: deviceHeight * .025,
              ),
              CustomOutlineButton(
                onPressed: () {
                  /*   if (_formKey.currentState!.validate() && imageFileToPick.path != "") {
                            if (controller.coverLaterText.isNotEmpty) {
                              Map<String, String> map = {};
                              map["job_id"] = model.value.data!.id.toString();
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
                          }*/
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
    );
  }

  Column mileStones(double deviceHeight, int index, text) {
    final TextEditingController _descriptionController = TextEditingController();
    final TextEditingController _dueDateController = TextEditingController();
    final TextEditingController _amountController = TextEditingController();
    _descriptionController.text = text;
    _dueDateController.text = text;
    _amountController.text = text;
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
          keyboardType: TextInputType.emailAddress,
          hintText: "".obs,
          validator: MultiValidator([
            RequiredValidator(errorText: 'Description is required'),
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
                     controller: _dueDateController,
                    obSecure: false.obs,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "".obs,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Due date is required'),
                    ]),
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
                    ),
                    obSecure: false.obs,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "".obs,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Amount is required'),
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
