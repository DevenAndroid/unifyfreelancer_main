import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../../resources/app_theme.dart';
import '../../widgets/custom_appbar.dart';
import '../models/model_single_job.dart';
import '../repository/job_module/job_details_repository.dart';
import '../resources/size.dart';
import '../widgets/common_outline_button.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? time;

  Rx<RxStatus> status = RxStatus.empty().obs;
  Rx<ModelSingleJob> model = ModelSingleJob().obs;
  var id = 0;

  @override
  void initState() {
    super.initState();
    id = int.parse(Get.arguments[0].toString());
    getData();
  }

  getData() {
    singleJobRepo(id).then((value) {
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
        descText = model.value.data!.description.toString();
        textLength = descText.length;
      } else {
        status.value = RxStatus.error();
      }
    });
  }

  String descText = "";
  bool descTextShowFlag = false;
  int textLength = 0;

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
            titleText: "Job Details",
          ),
        ),
        body: Obx(() {
          return status.value.isSuccess
              ? Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            if(model.value.data!.isInvited == true)
                              isInvited(),

                            Container(
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
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: deviceWidth * .01,
                                          ),
                                          Text(
                                            model.value.data!.name.toString().capitalizeFirst!,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Project type",
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight: FontWeight.w300,
                                                        color: const Color(
                                                            0xff6B6B6B)),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    model.value.data!.budgetType
                                                        .toString().capitalizeFirst!,
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: const Color(
                                                            0xff170048)),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Project duration",
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight: FontWeight.w300,
                                                        color: const Color(
                                                            0xff6B6B6B)),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    model
                                                        .value.data!.projectDuration
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: const Color(
                                                            0xff170048)),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Experience level",
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight: FontWeight.w300,
                                                        color: const Color(
                                                            0xff6B6B6B)),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    model
                                                        .value.data!.experienceLevel
                                                        .toString().capitalizeFirst!,
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: const Color(
                                                            0xff170048)),
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
                                      height: AddSize.size5,
                                    ),
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkBlueText,
                                      ),
                                    ),
                                    SizedBox(
                                      height: deviceHeight * .01,
                                    ),
                                    Text(model.value.data!.description.toString(),
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff170048)),
                                        maxLines: descTextShowFlag ? 10000 : 6),
                                    SizedBox(
                                        child: textLength <= 200
                                            ? const SizedBox()
                                            : InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    descTextShowFlag =
                                                        !descTextShowFlag;
                                                  });
                                                },
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      descTextShowFlag
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
                                      height: deviceHeight * .02,
                                    ),

                                    /*Text(
                              model.value.data!.budgetType.toString(),
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xff6B6B6B)),
                            ),
                            SizedBox(
                              height: deviceHeight * .02,
                            ),*/
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
                                      height: deviceHeight * .005,
                                    ),
                                    Wrap(
                                      children: List.generate(
                                          model.value.data!.jobSkills!.length,
                                          (index) => Container(
                                              margin: const EdgeInsets.only(right: 4),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppTheme.whiteColor,
                                                    side: const BorderSide(
                                                      color: Color(0xff6D2EF1),
                                                    ),
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                      Radius.circular(30),
                                                    )),
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                    ),
                                                    textStyle: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    )),
                                                onPressed: () {},
                                                child: Text(
                                                  model.value.data!
                                                      .jobSkills![index].name
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: AppTheme.primaryColor),
                                                ),
                                              ))),
                                    ),
                                    SizedBox(
                                      height: deviceHeight * .005,
                                    ),
                                    const Divider(
                                      color: Color(0xff6D2EF1),
                                    ),
                                    SizedBox(
                                      height: deviceHeight * .02,
                                    ),
                                    Text(
                                      "Activity on this job",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff170048)),
                                    ),
                                    SizedBox(
                                      height: deviceHeight * .01,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Proposals :",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xff170048)),
                                            ),
                                            SizedBox(
                                              height: deviceHeight * .002,
                                            ),
                                            Text(
                                              "Last viewed by client :",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xff170048)),
                                            ),
                                            SizedBox(
                                              height: deviceHeight * .002,
                                            ),
                                            Text(
                                              "Interviewing :",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xff170048)),
                                            ),
                                            SizedBox(
                                              height: deviceHeight * .002,
                                            ),
                                            Text(
                                              "Invites sent :",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xff170048)),
                                            ),
                                            SizedBox(
                                              height: deviceHeight * .002,
                                            ),
                                            Text(
                                              "Unanswered invites :",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xff170048)),
                                            ),
                                            SizedBox(
                                              height: deviceHeight * .002,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${model.value.data!.proposalCount ?? ""}",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(0xff170048)),
                                            ),
                                            SizedBox(
                                              height: deviceHeight * .002,
                                            ),
                                            Text(
                                              "${model.value.data!.clientData?.lastActivity ?? ""}",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(0xff170048)),
                                            ),
                                            SizedBox(
                                              height: deviceHeight * .002,
                                            ),
                                            Text(
                                              "${model.value.data!.interview ?? ""}",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(0xff170048)),
                                            ),
                                            SizedBox(
                                              height: deviceHeight * .002,
                                            ),
                                            Text(
                                              "${model.value.data!.inviteSent ?? ""}",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(0xff170048)),
                                            ),
                                            SizedBox(
                                              height: deviceHeight * .002,
                                            ),
                                            Text(
                                              "${model.value.data!.unansweredInvite ?? ""}",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(0xff170048)),
                                            ),
                                          ],
                                        )
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
                                    clientData(),
                                    SizedBox(
                                      height: deviceHeight * .02,
                                    ),
                                    const Divider(
                                      color: Color(0xff6D2EF1),
                                    ),
                                    Theme(
                                      data: ThemeData(
                                              expansionTileTheme:
                                                  const ExpansionTileThemeData(
                                                      textColor:
                                                          AppTheme.primaryColor,
                                                      iconColor:
                                                          AppTheme.primaryColor))
                                          .copyWith(
                                              dividerColor: Colors.transparent),
                                      child: ListTileTheme(
                                        contentPadding: EdgeInsets.zero,
                                        child: ExpansionTile(
                                            title: Text(
                                              "Clients recent history (${model.value.data!.clientRecentHistory!.length.toString()})",
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            children: List.generate(
                                                model.value.data!
                                                    .clientRecentHistory!.length,
                                                (index) => Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          model
                                                              .value
                                                              .data!
                                                              .clientRecentHistory![
                                                                  index]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              color: const Color(
                                                                  0xff170048)),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              deviceHeight * .01,
                                                        ),
                                                        Text.rich(
                                                          TextSpan(
                                                            children: [
                                                              WidgetSpan(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              2.0,
                                                                          right: 2,
                                                                          left: 2),
                                                                  child: Wrap(
                                                                    children: List.generate(
                                                                        5,
                                                                        (index) => 4 > index
                                                                            ? const Icon(
                                                                                Icons.star,
                                                                                color:
                                                                                    AppTheme.primaryColor,
                                                                                size:
                                                                                    16,
                                                                              )
                                                                            : const Icon(
                                                                                Icons.star_border_outlined,
                                                                                color:
                                                                                    Colors.grey,
                                                                                size:
                                                                                    16,
                                                                              )),
                                                                  ),
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                  text:
                                                                      "${model.value.data!.clientRecentHistory![index].startDate == null || model.value.data!.clientRecentHistory![index].startDate == "" ? model.value.data!.clientRecentHistory![index].startDate.toString() : ""}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: const Color(
                                                                          0xff170048))),
                                                              TextSpan(
                                                                  text:
                                                                      "${model.value.data!.clientRecentHistory![index].endDate == null || model.value.data!.clientRecentHistory![index].endDate == "" ? model.value.data!.clientRecentHistory![index].endDate.toString() : ""}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: const Color(
                                                                          0xff170048))),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          model
                                                              .value
                                                              .data!
                                                              .clientRecentHistory![
                                                                  index]
                                                              .description
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: const Color(
                                                                  0xff170048)),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              deviceHeight * .01,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "\$${model.value.data!.clientRecentHistory![index].price.toString()}",
                                                              style: TextStyle(
                                                                  fontSize: 14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: const Color(
                                                                      0xff170048)),
                                                            ),
                                                            Text(
                                                              model.value.data!
                                                                  .budgetType
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: const Color(
                                                                      0xff170048)),
                                                            ),
                                                            const SizedBox()
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              deviceHeight * .005,
                                                        ),
                                                        const Divider(
                                                          color: Color(0xff6D2EF1),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              deviceHeight * .01,
                                                        ),
                                                      ],
                                                    ))),
                                      ),
                                    ),
                                    SizedBox(
                                      height: deviceHeight * .02,
                                    ),
                                    if (model.value.data!.isProposalSend == false && model.value.data!.isInvited == false)
                                      CustomOutlineButton(
                                        onPressed: () {
                                          /* if (_formKey.currentState!.validate() && imageFileToPick.path != "") {
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
                                          Get.toNamed(MyRouter.submitProposalScreen,
                                              arguments: [
                                                id,
                                                model.value.data!.name.toString(),
                                                model.value.data!.description.toString(),
                                                model.value.data!.price.toString(),
                                                model.value.data!.budgetType.toString(),
                                           "fromJob",
                                           "0",
                                                model.value.data!.minPrice.toString(),
                                           //     model.value.data!.clientData!.id,
                                              ]);
                                        },
                                        title: "Send Proposal",
                                        textColor: AppTheme.whiteColor,
                                        expandedValue: true,
                                        backgroundColor: AppTheme.primaryColor,
                                      ),
                                    if (model.value.data!.isProposalSend == true)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    side: const BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                    backgroundColor: AppTheme
                                                        .whiteColor
                                                        .withOpacity(.88),
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                      Radius.circular(30),
                                                    )),
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 15),
                                                    textStyle: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    )),
                                                onPressed: () {},
                                                child: Text(
                                                  "Proposal already submitted",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.sp,
                                                    color: AppTheme.primaryColor,
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    /* CustomOutlineButton(
                                        onPressed: () {
                                  if (_formKey.currentState!.validate() && imageFileToPick.path != "") {
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
                                        }
                                        },
                                        title: "Proposal already submitted",
                                        textColor: AppTheme.primaryColor,
                                        expandedValue: true,
                                        backgroundColor: AppTheme.whiteColor,
                                      ),*/
                                    SizedBox(
                                      height: deviceHeight * .02,
                                    ),
                                  ],
                                )),
                          ],
                        )),
                  ),
                )
              : status.value.isError
                  ? SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.value.message.toString(),
                            // fontSize: AddSize.font16,
                          ),
                          IconButton(
                              onPressed: () {
                                getData();
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
        }));
  }

  String companySize(double numberOfEmp) {
    if (numberOfEmp <= 10) {
      return "Company size (1 to 10 people)";
    } else if (numberOfEmp <= 100) {
      return "Company size (10 to 100 people)";
    } else if (numberOfEmp <= 1000) {
      return "Company size (10 to 100 people)";
    } else {
      return "Company size (1000+ people)";
    }
  }

  isInvited() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width,
         /* decoration: BoxDecoration(
            color: AppTheme.whiteColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),*/
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_outline,color: AppTheme.primaryColor,),
              const SizedBox(
                width: 10,
              ),
              Text("You are already invited for this job",  style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff170048)),),
            ],
          ),
        ),
    );
  }

  Column clientData() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return model.value.data!.clientData == null
        ? Column(
            children: [
              Text(
                "Client data is unavailable.",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff170048)),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About the client",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff170048)),
              ),
              SizedBox(
                height: deviceHeight * .01,
              ),
              Row(
                children: [
                  Icon(Icons.verified,
                      color:
                          model.value.data!.clientData!.paymentVerified == true
                              ? AppTheme.primaryColor
                              : Colors.grey.withOpacity(.49),
                      size: 20),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    model.value.data!.clientData!.paymentVerified == true
                        ? "Payment method verified"
                        : "Payment method not verified",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff170048)),
                  ),
                ],
              ),
              SizedBox(
                height: deviceHeight * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: List.generate(
                        5,
                        (index) => int.parse(model
                                    .value.data!.clientData!.rating
                                    .toString()) >
                                index
                            ? const Icon(
                                Icons.star,
                                color: AppTheme.primaryColor,
                                size: 16,
                              )
                            : const Icon(
                                Icons.star_border_outlined,
                                color: Colors.grey,
                                size: 16,
                              )),
                  ),
                  Text(
                    "${model.value.data!.clientData!.rating.toString()} of ${model.value.data!.clientData!.numberOfReview.toString()} reviews",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff170048)),
                  ),
                ],
              ),
              SizedBox(
                height: deviceHeight * .01,
              ),
              Text(
                model.value.data!.clientData!.country.toString(),
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff170048)),
              ),
              SizedBox(
                height: deviceHeight * .002,
              ),
              Text(
                "${model.value.data!.clientData!.city.toString()} ${model.value.data!.clientData!.localTime ?? ""}",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff170048)),
              ),
              SizedBox(
                height: deviceHeight * .01,
              ),
              Text(
                "${model.value.data!.clientData!.jobPosted.toString()} jobs posted",
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff170048)),
              ),
              SizedBox(
                height: deviceHeight * .002,
              ),
              Text(
                "${model.value.data!.hireRate ?? ""}% hire rate, ${model.value.data!.openJobs ?? "0"} open jobs",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff170048)),
              ),
              SizedBox(
                height: deviceHeight * .01,
              ),
              Text(
                "\$${model.value.data!.clientData!.moneySpent.toString()}+ total spent",
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff170048)),
              ),
              SizedBox(
                height: deviceHeight * .002,
              ),
              Text(
                "${model.value.data!.totalHire ?? "0"} hires, ${model.value.data!.totalActive ?? "0"} active",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff170048)),
              ),
              /* SizedBox(
                                  height: deviceHeight * .01,
                                ),
                                Text(
                                  "\$20.00 /hr avg hourly rate paid",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff170048)),
                                ),
                                SizedBox(
                                  height: deviceHeight * .002,
                                ),
                                Text(
                                  "30 hours",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff170048)),
                                ),*/
              SizedBox(
                height: deviceHeight * .02,
              ),
              Text(
                //  "Company size (${model.value.data!.clientData!.employeeNo!.toString()} people)",
                companySize(double.parse(model
                                .value.data!.clientData!.employeeNo
                                .toString() ==
                            "null" ||
                        model.value.data!.clientData!.employeeNo.toString() ==
                            ""
                    ? "0"
                    : model.value.data!.clientData!.employeeNo.toString())),
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff170048)),
              ),
              SizedBox(
                height: deviceHeight * .01,
              ),
              Text(
                "Member since ${model.value.data!.clientData!.memberSince.toString()}",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff170048)),
              ),
            ],
          );
  }
}
