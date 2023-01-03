import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:unifyfreelancer/resources/size.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/widgets/add_text.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';

import '../../controller/single_contract_controller.dart';
import '../../resources/app_theme.dart';
import '../../utils/api_contant.dart';
import '../../widgets/button_for_milestone.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_text_field_for_timesheet.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/progress_indicator.dart';

class ContractsDetailsScreen extends StatefulWidget {
  const ContractsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ContractsDetailsScreen> createState() => _ContractsDetailsScreenState();
}

class _ContractsDetailsScreenState extends State<ContractsDetailsScreen> {
  String? _startDateVPG, _endDateVPG;
  final dateFormat = DateFormat('dd-MMM-yyyy');

  Future<dynamic> showDatePickerDialogue(double deviceWidth) {
    return showDialog(
        context: context,
        builder: (ctx) => Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: deviceWidth,
                      height: 80,
                      color: AppTheme.primaryColor,
                      child: const Center(
                          child: Text(
                        "Date Range",
                        style:
                            TextStyle(fontSize: 18, color: AppTheme.whiteColor),
                      ))),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: AppTheme.whiteColor),
                    child: SfDateRangePicker(
                      showActionButtons: true,
                      backgroundColor: AppTheme.whiteColor,
                      onSubmit: (Object? value) {
                        Navigator.pop(context);
                      },
                      onCancel: () {
                        Navigator.pop(context);
                      },
                      selectionMode: DateRangePickerSelectionMode.range,
                      onSelectionChanged: selectionChangedVPG,
                    ),
                  )
                ],
              ),
            ));
  }

  void selectionChangedVPG(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDateVPG = dateFormat.format(args.value.startDate).toString();
      _endDateVPG = dateFormat
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
  }

  final InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 1.2,
        color: Colors.grey,
      ));

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

  List<DaysDataFormat> daysData = [
    DaysDataFormat(
      mileStoneName:
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
      selected: false,
    ),
    DaysDataFormat(
        mileStoneName: "Simple Smart 'Add to queue', Synced currently playing",
        selected: true),
    DaysDataFormat(mileStoneName: "Web development", selected: false),
    DaysDataFormat(mileStoneName: "App development", selected: true),
    DaysDataFormat(mileStoneName: "Api", selected: false),
    /*  DaysDataFormat(mileStoneName: "Saturday",selected: true),
    DaysDataFormat(mileStoneName: "Sunday",selected: false),*/
  ];

  final controller = Get.put(SingleContractController());

  bool value = true;
  TabController? _tabController;
  RxString todoRadio = "".obs;

  Rx<File> documentFile = File("").obs;
  RxString fileName = "".obs;
  RxBool isSwitched = false.obs;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Contract room",
          ),
        ),
        body: Obx(() {
          return controller.status.value.isSuccess
              ? DefaultTabController(
                  length: controller.modelSingleContract.value.data!.type.toString().toLowerCase() == "hourly" ? 3 : 2,
                  child: NestedScrollView(
                    physics: const BouncingScrollPhysics(),
                    headerSliverBuilder: (_, __) {
                      return [
                        SliverToBoxAdapter(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: deviceWidth,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: AppTheme.whiteColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                              color: AppTheme.primaryColor,
                                              shape: BoxShape.circle,
                                              /*  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://images.unsplash.com/photo-1520635360276-79f3dbd809f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"))),*/
                                            ),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(1000),
                                                child: controller
                                                        .modelSingleContract
                                                        .value
                                                        .data!
                                                        .client!
                                                        .profileImage
                                                        .toString()
                                                        .isNotEmpty
                                                    ? CachedNetworkImage(
                                                        imageUrl: controller
                                                            .modelSingleContract
                                                            .value
                                                            .data!
                                                            .client!
                                                            .profileImage
                                                            .toString(),
                                                        errorWidget: (_, __,
                                                                ___) =>
                                                            SvgPicture.asset(
                                                          "assets/images/user.svg",
                                                        ),
                                                        placeholder: (_, __) =>
                                                            SvgPicture.asset(
                                                          "assets/images/user.svg",
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : SvgPicture.asset(
                                                        "assets/images/user.svg",
                                                      )),
                                          ),
                                          Positioned(
                                              right: 0,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppTheme.whiteColor,
                                                ),
                                                child: const Icon(
                                                  Icons.circle,
                                                  color: AppTheme.primaryColor,
                                                  size: 15,
                                                ),
                                              ))
                                        ]),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${controller.modelSingleContract.value.data!.client!.firstName.toString().capitalizeFirst} ${controller.modelSingleContract.value.data!.client!.lastName.toString().capitalizeFirst}",
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.textColor),
                                            ),
                                            Text(
                                              "${controller.modelSingleContract.value.data!.client!.country.toString()} ${controller.modelSingleContract.value.data!.client!.localTime.toString()}",
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: AppTheme.textColor),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () =>
                                          Get.toNamed(MyRouter.chatScreen),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.whiteColor,
                                          border: Border.all(
                                              color: AppTheme.primaryColor),
                                        ),
                                        child: const Icon(
                                          Icons.message,
                                          color: AppTheme.primaryColor,
                                          size: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  controller.modelSingleContract.value.data!
                                      .projectTitle
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.darkBlueText),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TabBar(
                                  controller: _tabController,
                                  labelColor: AppTheme.darkBlueText,
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  unselectedLabelColor: const Color(0xff707070),
                                  // indicatorColor: const Color(0xffFA61FF),
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                      width: 2.0.w,
                                      color: AppTheme.pinkText,
                                    ),
                                  ),
                                  automaticIndicatorColorAdjustment: true,
                                  unselectedLabelStyle:
                                      const TextStyle(color: Color(0xff707070)),
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        "Overview",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        "Timesheet",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        "Details",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ];
                    },
                    body: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: AddSize.padding14),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: overview(),
                          ),
                          if(controller.modelSingleContract.value.data!.type.toString().toLowerCase() == "hourly")
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: timesheet(),
                          ),
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: details(),
                          ),
                        ],
                      ),
                    ),
                  ))
              : controller.status.value.isError
                  ? CommonErrorWidget(
                      errorText: controller.modelSingleContract.value.message
                          .toString(),
                      onTap: () {
                        controller.getData();
                      },
                    )
                  : const CommonProgressIndicator();
        }));
  }

  overview() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /*      // child: Row(
            //   mainAxisAlignment:
            //   MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       children: [
            //         Text(
            //           "Last 24 hours",
            //           style: TextStyle(
            //               fontSize: 12,
            //               color: AppTheme.pinkText),
            //         ),
            //         SizedBox(
            //           height: 5.h,
            //         ),
            //         Text(
            //           "1:10 hrs",
            //           style: TextStyle(
            //               fontSize: 14,
            //               color:
            //               AppTheme.darkBlueText,
            //               fontWeight:
            //               FontWeight.w600),
            //         ),
            //       ],
            //     ),
            //     SizedBox(
            //       height: 40,
            //       child: VerticalDivider(
            //         thickness: 1,
            //         color: AppTheme.primaryColor
            //             .withOpacity(.100),
            //       ),
            //     ),
            //     Column(
            //       children: [
            //         Text(
            //           "This Week",
            //           style: TextStyle(
            //               fontSize: 12,
            //               color: AppTheme.pinkText),
            //         ),
            //         SizedBox(
            //           height: 5.h,
            //         ),
            //         Text(
            //           "6:20 hrs",
            //           style: TextStyle(
            //               fontSize: 14,
            //               color:
            //               AppTheme.darkBlueText,
            //               fontWeight:
            //               FontWeight.w600),
            //         ),
            //       ],
            //     ),
            //     SizedBox(
            //       height: 40,
            //       child: VerticalDivider(
            //         thickness: 1,
            //         color: AppTheme.primaryColor
            //             .withOpacity(.100),
            //       ),
            //     ),
            //     Column(
            //       children: [
            //         Text(
            //           "Last Week",
            //           style: TextStyle(
            //               fontSize: 12,
            //               color: AppTheme.pinkText),
            //         ),
            //         SizedBox(
            //           height: 5.h,
            //         ),
            //         Text(
            //           "7:55 hrs",
            //           style: TextStyle(
            //               fontSize: 14,
            //               color:
            //               AppTheme.darkBlueText,
            //               fontWeight:
            //               FontWeight.w600),
            //         ),
            //       ],
            //     ),
            //   ],
            // )),*/
          if(controller.modelSingleContract.value.data!.type.toString().toLowerCase() == "fixed")
          milestones(),
          if(controller.modelSingleContract.value.data!.type.toString().toLowerCase() == "fixed")
          earnings(),
          if(controller.modelSingleContract.value.data!.type.toString().toLowerCase() == "hourly")
          toDo(),
          if(controller.modelSingleContract.value.data!.type.toString().toLowerCase() == "hourly")
          hoursThisWeek(),

        ]);
  }

  timesheet() {
    var deviceWidth = MediaQuery.of(context).size.width;
    double barWidth = deviceWidth - deviceWidth * .55;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: deviceWidth,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              border: Border.all(color: AppTheme.primaryColor.withOpacity(.29)),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      "Last 24 hours",
                      style: TextStyle(fontSize: 12, color: AppTheme.pinkText),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Text(
                      "1:10 hrs",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.darkBlueText,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: VerticalDivider(
                    thickness: 1,
                    color: AppTheme.primaryColor.withOpacity(.100),
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      "This Week",
                      style: TextStyle(fontSize: 12, color: AppTheme.pinkText),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Text(
                      "6:20 hrs",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.darkBlueText,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: VerticalDivider(
                    thickness: 1,
                    color: AppTheme.primaryColor.withOpacity(.100),
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      "Last Week",
                      style: TextStyle(fontSize: 12, color: AppTheme.pinkText),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Text(
                      "7:55 hrs",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.darkBlueText,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            )),
        /* const Text(
          "Hours this week",
          style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
            width: deviceWidth,
            height: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppTheme.pinkText.withOpacity(.29),
            ),
            padding:
                EdgeInsets.only(right: deviceWidth - deviceWidth / 100 * 51),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppTheme.primaryColor,
              ),
            )),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "6:50 hrs",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor),
            ),
            Text(
              "20 hrs limit",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "you will get paid for these hours on Monday (unifybilling timezon)",
          style: TextStyle(fontSize: 12, color: AppTheme.textColor),
        ),*/
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Work Diary",
          style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: InkWell(
            onTap: () {
              showDatePickerDialogue(deviceWidth);
            },
            child: Container(
              decoration: BoxDecoration(color: AppTheme.whiteColor, boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 1))
              ]),
              child: TextFormField(
                  enabled: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: AppTheme.whiteColor),
                      ),
                      hintText: '$_startDateVPG To $_endDateVPG',
                      focusColor: const Color(0xffE8E7E7),
                      hintStyle: const TextStyle(
                          fontSize: 14, color: AppTheme.textColor),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: AppTheme.whiteColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: AppTheme.whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: AppTheme.whiteColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: AppTheme.whiteColor),
                      ),
                      suffixIcon: const Icon(
                        Icons.calendar_month_outlined,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ))),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 8,
            padding: const EdgeInsets.only(bottom: 20),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppTheme.primaryColor.withOpacity(.100)))),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Mon 8/22",
                          style: TextStyle(
                              fontSize: 13, color: AppTheme.textColor),
                        ),
                        Center(
                          child: SizedBox(
                            width: AddSize.size100,
                            child: CustomTextFieldForTimesheet(
                              hintText: "00:00".obs, obSecure: false.obs,
                            ),
                          ),
                        ),
                        NewButton(title: "Add time",
                            backgroundColor: AppTheme.primaryColor,
                        onPressed: (){},
                        textColor: AppTheme.whiteColor,)


                      ],
                    ),
                  ),
                ),
              );
            })
      ],
    );
  }

  buildChip({required bool selected, required text, required onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 16,
            color: selected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  recentFiles() {
    Size size = MediaQuery.of(context).size;
   /* return Container(
      // margin: const EdgeInsets.only(top: 15, bottom: 10),
      width: size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Files",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xff6D2EF1),
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      )),
                      backgroundColor: AppTheme.whiteColor,
                      // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.file_upload_outlined,
                        size: 16,
                        color: AppTheme.primaryColor,
                      ),
                      Text(
                        "  Upload ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child:
                                  SvgPicture.asset("assets/icon/doc_icon.svg"),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rough Design vO2 File",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(
                                      0xff1F1F1F,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "Ran Z...",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff1F1F1F)),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            "3 days ago",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff1F1F1F),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: AppTheme.primaryColor.withOpacity(.49),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                );
              })
        ],
      ),
    );*/
  }

  earnings() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Earnings
          const Text(
            "Earnings",
            style: TextStyle(
                fontSize: 16,
                color: AppTheme.textColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
              width: size.width,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppTheme.primaryColor.withOpacity(.29),
              ),
              padding:
                  EdgeInsets.only(right: size.width - size.width / 100 * 33),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppTheme.primaryColor,
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(
                          Icons.circle,
                          size: 12,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      Text(
                        "Received",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Icon(Icons.circle,
                            size: 12,
                            color: AppTheme.primaryColor.withOpacity(.29)),
                      ),
                      const Text(
                        "Funded (Escrow Protection)",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Icon(
                          Icons.circle,
                          size: 12,
                          color: Colors.grey.withOpacity(.44),
                        ),
                      ),
                      const Text(
                        "Project Price",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    "\$1000.00",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "\$5000.00",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "\$10000.00",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  milestones() {
    Size size = MediaQuery.of(context).size;
    return Container(
      //    margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AddSize.size10),
          const Text(
            "Milestone timeline",
            style: TextStyle(
                fontSize: 16,
                color: AppTheme.textColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size20,
          ),
          ListView.builder(
              itemCount: daysData.length,
              padding: EdgeInsets.symmetric(horizontal: AddSize.size12),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index1) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.primaryColor),
                          height: AddSize.size100 * .46,
                          width: AddSize.size100 * .46,
                          alignment: Alignment.center,
                          child: index1 < 2
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: AddSize.size25,
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.only(top: AddSize.size10 * .5),
                                  child: AddText(
                                    text: (index1 + 1).toString(),
                                    color: Colors.white,
                                    fontSize: AddSize.size20,
                                  ),
                                ),
                        ),
                        SizedBox(
                          width: AddSize.size100 * .14,
                        ),
                        Expanded(
                          child: Text(
                            daysData[index1].mileStoneName!,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                        left: BorderSide(
                            width: AddSize.size100 * .04,
                            color: AppTheme.primaryColor.withOpacity(.33)),
                      )),
                      margin: EdgeInsets.only(left: AddSize.size100 * .21),
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Column(
                            children: [
                              NewButton(
                                title: 'Paid',
                                backgroundColor: AppTheme.whiteColor,
                                textColor: AppTheme.primaryColor,
                                onPressed: () {
                                  if (index1 == 0) {
                                    showDialogForSubmitWork();
                                  } else if (index1 == 1) {
                                    showDialogForSubmitWorkPayment();
                                  } else if (index1 == 2) {
                                    showDialogForRequestMilestoneChanges();
                                  } else if (index1 == 3) {
                                    showDialogForAddMilestone();
                                  } else if (index1 == 4) {
                                    showDialogForEditActiveMilestone();
                                  }
                                },
                              )
                            ],
                          ),
                          /*Row(
                              children: [
                                buildChip(
                                    selected: daysData[index1].selected!,
                                    onTap: (){
                                      daysData[index1].selected = true;
                                      setState(() {

                                      });
                                    },
                                    text: "Daily"
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                buildChip(
                                    selected: !daysData[index1].selected!,
                                    onTap: (){
                                      daysData[index1].selected = false;
                                      setState(() {

                                      });
                                    },
                                    text: "Time Slot"),
                              ],
                            ),*/
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  toDo() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "To-dos",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5, top: 3.0),
                    child: Icon(
                      Icons.circle_outlined,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xff6D2EF1),
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      )),
                      backgroundColor: AppTheme.whiteColor,
                      // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    showDialogForToDo();
                  },
                  child: const Text(
                    "  New  ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: AppTheme.primaryColor,
                    ),
                  ))
            ],
          ),
          Image.asset(
            "assets/images/todo.png",
            height: 225,
            width: 225,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Add to-dos to your project with josh to organize, prioritize, and track your collaboration.",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff6B6B6B)),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  hoursThisWeek() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hours this week",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xff170048),
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              width: size.width,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppTheme.primaryColor.withOpacity(.29),
              ),
              padding:
                  EdgeInsets.only(right: size.width - size.width / 100 * 51),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppTheme.primaryColor,
                ),
              )),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "6:50 hrs",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor),
              ),
              Text(
                "20 hrs limit",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "you will get paid for these hours on Monday (unify billing timezone)",
            style: TextStyle(fontSize: 12, color: AppTheme.textColor),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomOutlineButton(
            title: "Add Time Manually",
            backgroundColor: AppTheme.primaryColor,
            onPressed: () {
              showDialogForAddTimeManually();
            },
            textColor: AppTheme.whiteColor,
            expandedValue: true,
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: InkWell(
              onTap: () {
                //    _tabController!.previousIndex;
              },
              child: const Text(
                "View Timesheet",
                style: TextStyle(
                    fontSize: 15,
                    color: Color(
                      0xff1F1F1F,
                    ),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  details() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.whiteColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Summary",
                style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.darkBlueText,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Contract type",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff878787),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        child: controller.modelSingleContract.value.data!.type
                                    .toString() ==
                                "hourly"
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Rate",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff878787),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Weekly limit",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff878787),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ),
                      /* SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Manual time",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff878787),
                            fontWeight: FontWeight.w500),
                      ),*/
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Start date",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff878787),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: AddSize.size20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.modelSingleContract.value.data!.type
                            .toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff1F1F1F),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        child: controller.modelSingleContract.value.data!.type
                                    .toString() ==
                                "hourly"
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "\$${controller.modelSingleContract.value.data!.amount.toString()}/hr ",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff1F1F1F),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    controller.modelSingleContract.value.data!
                                        .weeklyLimit
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff1F1F1F),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ),
                      /*SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Manual time allowed ",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff1F1F1F),
                            fontWeight: FontWeight.w600),
                      ),*/
                      const SizedBox(
                        height: 11,
                      ),
                      Text(
                        dateFormat.format(DateTime.parse(controller
                            .modelSingleContract.value.data!.startTime
                            .toString())),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff1F1F1F),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Details",
                style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.darkBlueText,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Verified name",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff878787),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Contract ID",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff878787),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: AddSize.size20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.modelSingleContract.value.data!.client!.firstName.toString().capitalizeFirst} ${controller.modelSingleContract.value.data!.client!.lastName.toString().capitalizeFirst}",
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff1F1F1F),
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        controller.modelSingleContract.value.data!.id
                            .toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff1F1F1F),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Divider(
                color: const Color(0xff6D2EF1).withOpacity(.49),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Description",
                style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.darkBlueText,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                controller.modelSingleContract.value.data!.project!.description
                    .toString(),
                style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff6B6B6B),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(MyRouter.viewOriginalOffer);
                },
                child: const Text(
                  "View original offer",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "View original proposal",
                style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              /* Divider(
                color: const Color(0xff6D2EF1).withOpacity(.49),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Recent Activity",
                style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.darkBlueText,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Date",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff6B6B6B),
                    fontWeight: FontWeight.w500),
              ),
              const Text(
                "Nov 22, 2022",
                style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.darkBlueText,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Description",
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff6B6B6B),
                    fontWeight: FontWeight.w500),
              ),
              const Text(
                "You accepted Sara Watson's offer at \$20.00/hr",
                style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.darkBlueText,
                    fontWeight: FontWeight.w600),
              ),*/
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          width: size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.whiteColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Company Information",
                style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.darkBlueText,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              /*Row(
                children: [
                  Icon(Icons.verified,
                      color: value == true
                          ? AppTheme.primaryColor
                          : Colors.grey.withOpacity(.49),
                      size: 20),
                  SizedBox(
                    width: AddSize.size10,
                  ),
                  Text(
                    value == true
                        ? "Payment method verified"
                        : "Payment method not verified",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4D4D4D),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AddSize.size10,
              ),
              Row(
                children: [
                  Wrap(
                    children: List.generate(
                        5,
                        (index) => 4 > index
                            ? const Icon(
                                Icons.star,
                                color: AppTheme.pinkText,
                                size: 20,
                              )
                            : const Icon(
                                Icons.star_border_outlined,
                                color: Colors.grey,
                                size: 20,
                              )),
                  ),
                  SizedBox(
                    width: AddSize.size10,
                  ),
                  const Text(
                    "5 of 4 reviews",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff170048)),
                  ),
                ],
              ),
              SizedBox(
                height: AddSize.size10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "America",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      Text(
                        "Jaipur, 2.00 Pm",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      Text(
                        "20 jobs posted",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      Text(
                        "20% hire rate, 23 open jobs",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      Text(
                        "\$5000 total spent",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      Text(
                        "100 hires, 50 active",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      Text(
                        "1 to 3 months",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      Text(
                        "Project Length",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size15,
                      ),
                      Text(
                        companySize(0),
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size15,
                      ),
                      Text(
                        "Member since Sep 16, 2022 ",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                    ],
                  ),
                ],
              )*/
              Row(
                children: [
                  Icon(Icons.verified,
                      color: controller.modelSingleContract.value.data!.client!
                                  .paymentVerified ==
                              true
                          ? AppTheme.primaryColor
                          : Colors.grey.withOpacity(.49),
                      size: 20),
                  SizedBox(
                    width: AddSize.size10,
                  ),
                  Text(
                    controller.modelSingleContract.value.data!.client!
                                .paymentVerified ==
                            true
                        ? "Payment method verified"
                        : "Payment method not verified",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4D4D4D),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AddSize.size10,
              ),
              Row(
                children: [
                  Wrap(
                    children: List.generate(
                        5,
                        (index) => double.parse(controller.modelSingleContract
                                    .value.data!.client!.rating
                                    .toString()) >
                                index
                            ? const Icon(
                                Icons.star,
                                color: AppTheme.pinkText,
                                size: 20,
                              )
                            : const Icon(
                                Icons.star_border_outlined,
                                color: Colors.grey,
                                size: 20,
                              )),
                  ),
                  SizedBox(
                    width: AddSize.size10,
                  ),
                  Text(
                    "${double.parse(controller.modelSingleContract.value.data!.client!.rating.toString())} of ${double.parse(controller.modelSingleContract.value.data!.client!.numberOfReview.toString())} reviews",
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff170048)),
                  ),
                ],
              ),
              SizedBox(
                height: AddSize.size10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller
                            .modelSingleContract.value.data!.client!.country
                            .toString(),
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      Text(
                        "${controller.modelSingleContract.value.data!.client!.city} ${controller.modelSingleContract.value.data!.client!.localTime}",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      Text(
                        "${controller.modelSingleContract.value.data!.client!.jobPosted.toString()} jobs posted",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      Text(
                        "${controller.modelSingleContract.value.data!.project!.hireRate.toString()}% hire rate, ${controller.modelSingleContract.value.data!.project!.openJobs.toString()} open job",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      Text(
                        "\$${controller.modelSingleContract.value.data!.client!.moneySpent.toString()}+ total spent",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      Text(
                        "${controller.modelSingleContract.value.data!.project!.totalHire.toString()} hires, ${controller.modelSingleContract.value.data!.project!.openJobs.toString()} active",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size10,
                      ),
                      Text(
                        controller.modelSingleContract.value.data!.project!
                            .projectDuration
                            .toString(),
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      Text(
                        "Project Length",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size15,
                      ),
                      Text(
                        companySize(double.parse(controller.modelSingleContract
                                        .value.data!.client!.employeeNo
                                        .toString() ==
                                    "null" ||
                                controller.modelSingleContract.value.data!
                                        .client!.employeeNo
                                        .toString() ==
                                    ""
                            ? "0"
                            : controller.modelSingleContract.value.data!.client!
                                .employeeNo
                                .toString())),
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                      SizedBox(
                        height: AddSize.size15,
                      ),
                      Text(
                        "Member since ${controller.modelSingleContract.value.data!.client!.memberSince.toString()}",
                        style: TextStyle(
                          fontSize: AddSize.font16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff462D7A),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          width: size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.whiteColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Feedback",
                style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.darkBlueText,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset("assets/images/folder.svg"),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("This contract is not yet eligible for feedback",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff1f1f1f),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff6B6B6B),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xffD8D8D8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 15),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            )),
                            backgroundColor: const Color(0xffD8D8D8),
                            // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () {},
                        child: const Text(
                          "Request Feedback",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppTheme.whiteColor,
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  showDialogForToDo() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.size100 * .4),
            child: Obx(() {
              return Form(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            const Text(
                              "Add a to-do",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 50.0,
                              ),
                              child: InkWell(
                                  onTap: () => Get.back(),
                                  child: const Icon(
                                    Icons.clear,
                                  )),
                            )
                          ],
                        ),
                        const Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Please enter title'),
                          ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "To be completed by",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        RadioListTile(
                          title: const Text(
                            "You",
                            style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.settingsTextColor),
                          ),
                          contentPadding: const EdgeInsets.all(0),
                          dense: true,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          value: "You",
                          groupValue: todoRadio.value,
                          onChanged: (value) {
                            setState(() {
                              todoRadio.value = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text(
                            "By jhon cena",
                            style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.settingsTextColor),
                          ),
                          contentPadding: const EdgeInsets.all(0),
                          dense: true,
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: -4),
                          value: "By jhon cena",
                          groupValue: todoRadio.value,
                          onChanged: (value) {
                            setState(() {
                              todoRadio.value = value.toString();
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Due Date (Optional)",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const Text(
                          "All dates and times are based on UTC",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          isMulti: true,
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(AddSize.size10),
                                child: NewButton(
                                  title: 'Save & Add other',
                                  backgroundColor: AppTheme.whiteColor,
                                  onPressed: () {
                                    Get.back();
                                  },
                                  textColor: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(AddSize.size10),
                                child: NewButton(
                                  title: 'Save',
                                  backgroundColor: AppTheme.primaryColor,
                                  onPressed: () {},
                                  textColor: AppTheme.whiteColor,
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
            }),
          );
        });
  }

  showDialogForSubmitWork() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                  vertical: AddSize.size100 * .4),
              child: Obx(() {
                return Form(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Submit Work",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            isMulti: true,
                            obSecure: false.obs,
                            keyboardType: TextInputType.text,
                            hintText: "".obs,
                            /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              pickFileToUpload();
                            },
                            child: Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppTheme.primaryColor
                                            .withOpacity(.15))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: documentFile.value.path == ""
                                                ? Image.asset(
                                                    "assets/icon/script.png")
                                                : InkWell(
                                                    onTap: () {
                                                      documentFile.value =
                                                          File("");
                                                    },
                                                    child: const Icon(
                                                      Icons.clear,
                                                      color: AppTheme.pinkText,
                                                    )),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              documentFile.value.path == ""
                                                  ? "Attach Files"
                                                  : fileName.value.toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      color: AppTheme.pinkText,
                                      child: const Text(
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
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(AddSize.size10),
                                  child: CustomOutlineButton(
                                    title: 'Close',
                                    backgroundColor: AppTheme.whiteColor,
                                    onPressed: () {
                                      Get.back();
                                    },
                                    textColor: AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(AddSize.size10),
                                  child: CustomOutlineButton(
                                    title: 'Submit',
                                    backgroundColor: AppTheme.primaryColor,
                                    onPressed: () {},
                                    textColor: AppTheme.whiteColor,
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
              }));
        });
  }

  showDialogForSubmitWorkPayment() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                  vertical: AddSize.size100 * .4),
              child: Obx(() {
                return Form(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Submit Work For Payment",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            "Backend setup with Learn press and white our Brand. Create all the Backend options that are required for the teacher and admin.",
                            style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.darkBlueText,
                                fontWeight: FontWeight.w400),
                          ),
                          NewButton(
                            title: "Active & funded",
                            backgroundColor: AppTheme.whiteColor,
                            textColor: AppTheme.primaryColor,
                            onPressed: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Your payment will be released once Ankit approves your work.",
                            style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.darkBlueText,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: const Color(0xff6D2EF1).withOpacity(.49),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Message to client",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            isMulti: true,
                            obSecure: false.obs,
                            keyboardType: TextInputType.text,
                            hintText: "".obs,
                            /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Include a file (optional)",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              pickFileToUpload();
                            },
                            child: Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppTheme.primaryColor
                                            .withOpacity(.15))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: documentFile.value.path == ""
                                                ? Image.asset(
                                                    "assets/icon/script.png")
                                                : InkWell(
                                                    onTap: () {
                                                      documentFile.value =
                                                          File("");
                                                    },
                                                    child: const Icon(
                                                      Icons.clear,
                                                      color: AppTheme.pinkText,
                                                    )),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              documentFile.value.path == ""
                                                  ? "Attach Files"
                                                  : fileName.value.toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      color: AppTheme.pinkText,
                                      child: const Text(
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
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(AddSize.size10),
                                  child: CustomOutlineButton(
                                    title: 'Close',
                                    backgroundColor: AppTheme.whiteColor,
                                    onPressed: () {
                                      Get.back();
                                    },
                                    textColor: AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(AddSize.size10),
                                  child: CustomOutlineButton(
                                    title: 'Submit',
                                    backgroundColor: AppTheme.primaryColor,
                                    onPressed: () {},
                                    textColor: AppTheme.whiteColor,
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
              }));
        });
  }

  showDialogForRequestMilestoneChanges() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                  vertical: AddSize.size100 * .4),
              child: Obx(() {
                return Form(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Request Milestone Changes",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Divider(
                              color: AppTheme.primaryColor.withOpacity(.49)),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                "Show changes",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.darkBlueText,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CupertinoSwitch(
                                onChanged: (value) {
                                  isSwitched.value = value;
                                  setState(() {});
                                },
                                trackColor:
                                    AppTheme.primaryColor.withOpacity(.11),
                                value: isSwitched.value,
                                activeColor: AppTheme.primaryColor,
                                thumbColor: const Color(0xffE2E2E2),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Divider(
                              color: AppTheme.primaryColor.withOpacity(.49)),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Milestone 3",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.darkBlueText,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          "\$1500.00",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.darkBlueText,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "Due Nov 30",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.darkBlueText,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox()
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xff707070))),
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Divider(
                              color: AppTheme.primaryColor.withOpacity(.49)),
                          NewButton(
                            title: "Propose a new milestone",
                            backgroundColor: AppTheme.primaryColor,
                            textColor: AppTheme.whiteColor,
                            onPressed: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Message to client (optional)",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            isMulti: true,
                            obSecure: false.obs,
                            keyboardType: TextInputType.text,
                            hintText: "".obs,
                            /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                          ),
                          const Text(
                            "Ankit will need to approve these updates. We'll notify them and let you know if these changes are approved.",
                            style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.darkBlueText,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(AddSize.size10),
                                  child: CustomOutlineButton(
                                    title: 'Close',
                                    backgroundColor: AppTheme.whiteColor,
                                    onPressed: () {
                                      Get.back();
                                    },
                                    textColor: AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(AddSize.size10),
                                  child: CustomOutlineButton(
                                    title: 'Submit',
                                    backgroundColor: AppTheme.primaryColor,
                                    onPressed: () {},
                                    textColor: AppTheme.whiteColor,
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
              }));
        });
  }

  showDialogForAddMilestone() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                  vertical: AddSize.size100 * .4),
              child: Form(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Add Milestone",
                            style: TextStyle(
                                fontSize: 18,
                                color: AppTheme.darkBlueText,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Name of Milestone 9",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Amount",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          prefix: const Icon(
                            Icons.attach_money,
                          ),
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Due Date (Optional)",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          suffixIcon: const Icon(
                            Icons.calendar_month_rounded,
                            color: AppTheme.primaryColor,
                          ),
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const Text(
                          "All dates and times are based on UTC",
                          style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.darkBlueText,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          isMulti: true,
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(AddSize.size10),
                                child: NewButton(
                                  title: 'Save & Add other',
                                  backgroundColor: AppTheme.whiteColor,
                                  onPressed: () {
                                    Get.back();
                                  },
                                  textColor: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(AddSize.size10),
                                child: NewButton(
                                  title: 'Submit',
                                  backgroundColor: AppTheme.primaryColor,
                                  onPressed: () {},
                                  textColor: AppTheme.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  showDialogForEditActiveMilestone() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                  vertical: AddSize.size100 * .4),
              child: Form(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Edit Active Milestone",
                            style: TextStyle(
                                fontSize: 18,
                                color: AppTheme.darkBlueText,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Title",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "Profile Edit, Profile Settings".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Currently Funded",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          prefix: const Icon(
                            Icons.attach_money,
                          ),
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Additional Payment",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          prefix: const Icon(
                            Icons.attach_money,
                          ),
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "New Milestone Payment",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          prefix: const Icon(
                            Icons.attach_money,
                          ),
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Due Date (Optional)",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.calendar_month_rounded,
                            color: AppTheme.primaryColor,
                          ),
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const Text(
                          "All dates and times are based on UTC",
                          style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.darkBlueText,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          isMulti: true,
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 25,
                        ),
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
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(AddSize.size10),
                                child: CustomOutlineButton(
                                  title: 'Update',
                                  backgroundColor: AppTheme.primaryColor,
                                  onPressed: () {},
                                  textColor: AppTheme.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  showDialogForAddTimeManually() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              insetPadding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                  vertical: AddSize.size100 * .4),
              child: Form(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            "Add Manual Time",
                            style: TextStyle(
                                fontSize: 18,
                                color: AppTheme.darkBlueText,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.calendar_month_rounded,
                            color: AppTheme.primaryColor,
                          ),
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "Thu, Dec 29, 2022".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Time Zone",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                          ),
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "UTC".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Start Time",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                          ),
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "Start Time".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "End Time",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                          ),
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "End Time".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Memo",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff4D4D4D),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          isMulti: true,
                          obSecure: false.obs,
                          keyboardType: TextInputType.text,
                          hintText: "".obs,
                          /*validator: MultiValidator([
                          RequiredValidator(errorText: 'Please enter title'),
                        ]),*/
                        ),
                        RichText(
                            text: const TextSpan(
                                text: "Note: ",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.darkBlueText,
                                    fontWeight: FontWeight.w600),
                                children: [
                              TextSpan(
                                text:
                                    "manual time does not qualify for Unify Hourly protection.",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.darkBlueText,
                                    fontWeight: FontWeight.w400),
                              )
                            ])),
                        const SizedBox(
                          height: 25,
                        ),
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
                                  onPressed: () {},
                                  textColor: AppTheme.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
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
}

class DaysDataFormat {
  String? mileStoneName;
  bool? selected;

  DaysDataFormat({this.mileStoneName, this.selected = false});
}
