
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../resources/app_theme.dart';
import '../widgets/custom_appbar.dart';

class ContractsDetailsScreen extends StatefulWidget {
  const ContractsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ContractsDetailsScreen> createState() => _ContractsDetailsScreenState();
}

class _ContractsDetailsScreenState extends State<ContractsDetailsScreen> {
  String? _startDateVPG, _endDateVPG;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    double barWidth = deviceWidth - deviceWidth * .55;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Contract room",
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          width: deviceWidth,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(
                          height: 50,
                          width: 50,
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
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.whiteColor,
                              ),
                              child: Icon(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jolly Smith",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textColor),
                          ),
                          Text(
                            "United States - Wed 8:10 AM",
                            style: TextStyle(
                                fontSize: 13.sp, color: AppTheme.textColor),
                          ),
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(MyRouter.chatScreen),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.whiteColor,
                        border: Border.all(color: AppTheme.primaryColor),
                      ),
                      child: Icon(
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
                "UI/UX Design And Laravel Development.",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText),
              ),
              SizedBox(
                height: 10.h,
              ),
              DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TabBar(
                          labelColor: AppTheme.darkBlueText,
                          labelStyle: TextStyle(fontWeight: FontWeight.w500),
                          unselectedLabelColor: Color(0xff707070),
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
                          ],
                        ),
                        Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: AppTheme.pinkText, width: 0.5))),
                            height: deviceHeight*1.3,
                            child: TabBarView(
                              children: [
                                overview(),
                                timesheet(),
                              ],
                            ))
                      ])),
            ],
          ),
        ),
      ),
    );
  }

  void selectionChangedVPG(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDateVPG =
          DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();
      _endDateVPG = DateFormat('yyyy-MM-dd')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
  }

  overview() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;


    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /*
        Container(
            margin:
            EdgeInsets.symmetric(vertical: 10),
            width: deviceWidth,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              border: Border.all(
                  color: AppTheme.primaryColor
                      .withOpacity(.29)),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              */ /*boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],*/ /*
            ),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Last 24 hours",
                      style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.pinkText),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "1:10 hrs",
                      style: TextStyle(
                          fontSize: 14,
                          color:
                          AppTheme.darkBlueText,
                          fontWeight:
                          FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: VerticalDivider(
                    thickness: 1,
                    color: AppTheme.primaryColor
                        .withOpacity(.100),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "This Week",
                      style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.pinkText),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "6:20 hrs",
                      style: TextStyle(
                          fontSize: 14,
                          color:
                          AppTheme.darkBlueText,
                          fontWeight:
                          FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: VerticalDivider(
                    thickness: 1,
                    color: AppTheme.primaryColor
                        .withOpacity(.100),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Last Week",
                      style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.pinkText),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "7:55 hrs",
                      style: TextStyle(
                          fontSize: 14,
                          color:
                          AppTheme.darkBlueText,
                          fontWeight:
                          FontWeight.w600),
                    ),
                  ],
                ),
              ],
            )),
*/

          SizedBox(
            height: 20,
          ),
          Text(
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
              width: deviceWidth,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppTheme.pinkText.withOpacity(.29),
              ),
              padding:
                  EdgeInsets.only(right: deviceWidth - deviceWidth / 100 * 33),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppTheme.primaryColor,
                ),
              )),
          SizedBox(
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
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
                            color: AppTheme.pinkText.withOpacity(.29)),
                      ),
                      Text(
                        "Founded (Escrow Protection)",
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
                        ),
                      ),
                      Text(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1,
            color: AppTheme.primaryColor.withOpacity(.13),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Milestone timeline",
            style: TextStyle(
                fontSize: 16,
                color: AppTheme.textColor,
                fontWeight: FontWeight.w600),
          ),

        ]);
  }

  timesheet() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    double barWidth = deviceWidth - deviceWidth * .55;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: deviceWidth,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              border: Border.all(color: AppTheme.primaryColor.withOpacity(.29)),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              /*boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],*/
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Last 24 hours",
                      style: TextStyle(fontSize: 12, color: AppTheme.pinkText),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
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
                    Text(
                      "This Week",
                      style: TextStyle(fontSize: 12, color: AppTheme.pinkText),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
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
                    Text(
                      "Last Week",
                      style: TextStyle(fontSize: 12, color: AppTheme.pinkText),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
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
        Text(
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
          children: [
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
        SizedBox(
          height: 10,
        ),
        Text(
          "you will get paid for these hours on Monday (unifybilling timezon)",
          style: TextStyle(fontSize: 12, color: AppTheme.textColor),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Work Diary",
          style: TextStyle(
              fontSize: 16,
              color: AppTheme.textColor,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: InkWell(
            onTap: () {
              showDialog(context: context,
                  builder: (ctx) => Dialog(
                    child: Column(mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            width: deviceWidth,
                            height: 80,
                            color: AppTheme.primaryColor,
                            child: Center(
                                child: Text(
                                  "Date Range",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppTheme.whiteColor),
                                ))),
                        Container(
                          width: MediaQuery.of(
                              context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                              color: AppTheme
                                  .whiteColor),
                          child:
                          SfDateRangePicker(
                            showActionButtons:
                            true,
                            backgroundColor:
                            AppTheme
                                .whiteColor,
                            onSubmit:
                                (Object?
                            value) {
                              Navigator.pop(
                                  context);
                            },
                            onCancel: () {
                              Navigator.pop(
                                  context);
                            },
                            selectionMode:
                            DateRangePickerSelectionMode
                                .range,
                            onSelectionChanged:
                            selectionChangedVPG,
                          ),
                        )
                      ],
                    ),
                  ));
              print(_startDateVPG);
              print(_endDateVPG);
            },
            child: Container(
              decoration: BoxDecoration(color: AppTheme.whiteColor, boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2))
              ]),
              child: TextFormField(
                  enabled: false,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(color: AppTheme.whiteColor),
                      ),
                      hintText: '${_startDateVPG} To ${_endDateVPG}',
                      focusColor: Color(0xffE8E7E7),
                      hintStyle:
                          TextStyle(fontSize: 14, color: AppTheme.textColor),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(color: AppTheme.whiteColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(color: AppTheme.whiteColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(color: AppTheme.whiteColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(color: AppTheme.whiteColor),
                      ),
                      suffixIcon: Icon(
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
        Expanded(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 9,
              padding: EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppTheme.primaryColor.withOpacity(.100)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Mon 8/22",
                            style: TextStyle(
                                fontSize: 13, color: AppTheme.textColor),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                              width: barWidth,
                              height: 7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppTheme.whiteColor,
                              ),
                              padding: EdgeInsets.only(
                                  right: barWidth -
                                      barWidth / 100 * int.parse("${index}0")),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppTheme.primaryColor,
                                ),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "0:00 hrs",
                            style: TextStyle(
                                fontSize: 13, color: AppTheme.textColor),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppTheme.blackColor,
                            size: 15,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}
