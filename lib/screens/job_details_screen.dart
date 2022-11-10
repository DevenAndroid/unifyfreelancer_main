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
    id = int.parse(Get.arguments[0] ?? 0);
    getData();
  }

  getData() {
    singleJobRepo(job_id: id).then((value) {
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
        descText = model.value.data!.description.toString();
      } else {
        status.value = RxStatus.error();
      }
    });
  }

  String descText = "";
  bool descTextShowFlag = false;

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
                                        model.value.data!.name.toString(),
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
                                                "Less then 30hr/week",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color: const Color(
                                                        0xff6B6B6B)),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                model.value.data!.budgetType
                                                    .toString(),
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
                                                "Project Duration",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color: const Color(
                                                        0xff6B6B6B)),
                                              ),
                                              SizedBox(
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
                                      SizedBox(
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
                                                "Experience Level",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color: const Color(
                                                        0xff6B6B6B)),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                model
                                                    .value.data!.experienceLevel
                                                    .toString(),
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
                                  height: deviceHeight * .02,
                                ),
                                Text(model.value.data!.description.toString(),
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff170048)),
                                    maxLines: descTextShowFlag ? 10000 : 6),
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
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
                                        ])),
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
                                      model.value.data!.skills!.length,
                                      (index) => Container(
                                              //    margin: EdgeInsets.only(right: 4, bottom: 10),
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
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            onPressed: () {},
                                            child: Text(
                                              model.value.data!.skills![index]
                                                  .name
                                                  .toString(),
                                              style: TextStyle(
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
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xff170048)),
                                        ),
                                        SizedBox(
                                          height: deviceHeight * .002,
                                        ),
                                        Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xff170048)),
                                        ),
                                        SizedBox(
                                          height: deviceHeight * .002,
                                        ),
                                        Text(
                                          "0",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xff170048)),
                                        ),
                                        SizedBox(
                                          height: deviceHeight * .002,
                                        ),
                                        Text(
                                          "0",
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
                                        color: AppTheme.primaryColor, size: 20),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "Payment method verified",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      children: List.generate(
                                          5,
                                          (index) => 5 > index
                                              ? Icon(
                                                  Icons.star,
                                                  color: AppTheme.primaryColor,
                                                  size: 16,
                                                )
                                              : Icon(
                                                  Icons.star_border_outlined,
                                                  color: Colors.grey,
                                                  size: 16,
                                                )),
                                    ),
                                    Text(
                                      "5.00 fo 1 review",
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
                                  "India",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff170048)),
                                ),
                                SizedBox(
                                  height: deviceHeight * .002,
                                ),
                                Text(
                                  "Ahmedabad 11.59 am",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff170048)),
                                ),
                                SizedBox(
                                  height: deviceHeight * .01,
                                ),
                                Text(
                                  "15 jobs posted",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff170048)),
                                ),
                                SizedBox(
                                  height: deviceHeight * .002,
                                ),
                                Text(
                                  "14% hire rate, 5 open jobs",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff170048)),
                                ),
                                SizedBox(
                                  height: deviceHeight * .01,
                                ),
                                Text(
                                  "\$600+ total spent",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff170048)),
                                ),
                                SizedBox(
                                  height: deviceHeight * .002,
                                ),
                                Text(
                                  "2 hires, 0 active",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff170048)),
                                ),
                                SizedBox(
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
                                ),
                                SizedBox(
                                  height: deviceHeight * .02,
                                ),
                                Text(
                                  "Member since Nov 25,2015",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff170048)),
                                ),
                                SizedBox(
                                  height: deviceHeight * .02,
                                ),
                                const Divider(
                                  color: Color(0xff6D2EF1),
                                ),
                                Theme(
                                  data: ThemeData(
                                          expansionTileTheme:
                                              ExpansionTileThemeData(
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
                                          "Clients recent history (2)",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        children: List.generate(
                                            4,
                                            (index) => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Web Development/ Python Django CMS",
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: const Color(
                                                              0xff170048)),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          deviceHeight * .005,
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
                                                                          3.0,
                                                                      right: 2),
                                                              child: Wrap(
                                                                children: List.generate(
                                                                    5,
                                                                    (index) => 5 > index
                                                                        ? Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                AppTheme.primaryColor,
                                                                            size:
                                                                                16,
                                                                          )
                                                                        : Icon(
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
                                                                  "Pleasure working with Prashant. Test task completed successfully. Looking forward to working with him again. thanks",
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
                                                    SizedBox(
                                                      height:
                                                          deviceHeight * .01,
                                                    ),
                                                    Text(
                                                      "Nov 2017 - Nov 2017",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: const Color(
                                                              0xff170048)),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          deviceHeight * .002,
                                                    ),
                                                    Text(
                                                      "Fixed-price \$40.00",
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
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                                  "To freelancer: Jitender S.",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: const Color(
                                                                      0xff170048))),
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
                                                                    (index) => 5 > index
                                                                        ? Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                AppTheme.primaryColor,
                                                                            size:
                                                                                16,
                                                                          )
                                                                        : Icon(
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
                                                                  "It was good working with you, will hire you for future work",
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
                                          model.value.data!.name.toString(),
                                          model.value.data!.description
                                              .toString(),
                                          model.value.data!.price.toString(),
                                        ]);
                                  },
                                  title: "Send Proposal",
                                  textColor: AppTheme.whiteColor,
                                  expandedValue: true,
                                  backgroundColor: AppTheme.primaryColor,
                                ),
                                SizedBox(
                                  height: deviceHeight * .02,
                                ),
                              ],
                            ))),
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
                  : Center(
                      child: CircularProgressIndicator(),
                    );
        }));
  }
}
