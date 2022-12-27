import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:unifyfreelancer/resources/size.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/widgets/add_text.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';

import '../../resources/app_theme.dart';
import '../../widgets/button_for_milestone.dart';
import '../../widgets/common_button.dart';
import '../../widgets/custom_appbar.dart';

class ContractsDetailsScreen extends StatefulWidget {
  const ContractsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ContractsDetailsScreen> createState() => _ContractsDetailsScreenState();
}

class _ContractsDetailsScreenState extends State<ContractsDetailsScreen> {
  String? _startDateVPG, _endDateVPG;

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
      _startDateVPG =
          DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();
      _endDateVPG = DateFormat('yyyy-MM-dd')
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

  List<DaysDataFormate> daysData = [
    DaysDataFormate(mileStoneName: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",selected: false,),
    DaysDataFormate(mileStoneName: "Simple Smart 'Add to queue', Synced currently playing",selected: true),
/*    DaysDataFormate(mileStoneName: "Wednesday",selected: false),
    DaysDataFormate(mileStoneName: "Thursday",selected: true),
    DaysDataFormate(mileStoneName: "Friday",selected: false),
    DaysDataFormate(mileStoneName: "Saturday",selected: true),
    DaysDataFormate(mileStoneName: "Sunday",selected: false),*/
  ];

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
      body: DefaultTabController(
          length: 2,
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
                                    decoration: const BoxDecoration(
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
                                          fontSize: 13.sp,
                                          color: AppTheme.textColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () => Get.toNamed(MyRouter.chatScreen),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.whiteColor,
                                  border:
                                      Border.all(color: AppTheme.primaryColor),
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
                          "UI/UX Design And Laravel Development.",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TabBar(
                          labelColor: AppTheme.darkBlueText,
                          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
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
              padding: EdgeInsets.symmetric(horizontal: AddSize.padding14),
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: overview(),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: timesheet(),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  overview() {
    var deviceWidth = MediaQuery.of(context).size.width;
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
          //Earnings
          /*const SizedBox(
            height: 20,
          ),
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
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(
                          Icons.circle,
                          size: 12,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const Text(
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
                      const Text(
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
                      const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(
                          Icons.circle,
                          size: 12,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "\$1000.00",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "\$5000.00",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
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
          Divider(
            thickness: 1,
            color: AppTheme.primaryColor.withOpacity(.13),
          ),
          const SizedBox(
            height: 10,
          ),*/
          SizedBox(height: AddSize.size10),
          const Text(
            "Milestone timeline",
            style: TextStyle(
                fontSize: 16,
                color: AppTheme.textColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: AddSize.size20,),
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
                            color: AppTheme.primaryColor
                          ),
                          height: AddSize.size100*.46,
                          width: AddSize.size100*.46,
                          alignment: Alignment.center,
                          child: index1 < 2 ?
                          Icon(Icons.check,color: Colors.white,size: AddSize.size25,) :
                          Padding(
                            padding: EdgeInsets.only(top: AddSize.size10*.5),
                            child: AddText(
                                text: (index1+1).toString(),
                              color: Colors.white,
                              fontSize: AddSize.size20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AddSize.size100*.14,
                        ),
                        Expanded(
                          child: Text(
                            daysData[index1].mileStoneName!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(width: AddSize.size100*.04, color: AppTheme.primaryColor.withOpacity(.33)),
                          )
                      ),
                      margin:  EdgeInsets.only(left: AddSize.size100*.21),
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Column(
                            children: [
                              NewButton(title: 'Paid',backgroundColor: AppTheme.whiteColor,
                              textColor: AppTheme.primaryColor,onPressed: (){},)
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
          Divider(
            thickness: 1,
            color: AppTheme.primaryColor.withOpacity(.13),
          ),
          const SizedBox(
            height: 10,
          ),

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
        const Text(
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
            const Text(
              "6:50 hrs",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor),
            ),
            const Text(
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
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
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
              showDatePickerDialogue(deviceWidth);
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
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(color: AppTheme.whiteColor),
                      ),
                      hintText: '${_startDateVPG} To ${_endDateVPG}',
                      focusColor: const Color(0xffE8E7E7),
                      hintStyle:
                          const TextStyle(fontSize: 14, color: AppTheme.textColor),
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
            itemCount: 9,
            padding: const EdgeInsets.only(bottom: 20),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: AppTheme.primaryColor.withOpacity(.100)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
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
                        const Text(
                          "0:00 hrs",
                          style: TextStyle(
                              fontSize: 13, color: AppTheme.textColor),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppTheme.blackColor,
                          size: 15,
                        )
                      ],
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }

  buildChip({required bool selected, required text,required onTap}) {
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

}


class DaysDataFormate {
  String? mileStoneName;
  bool? selected;

  DaysDataFormate({this.mileStoneName, this.selected = false});
}
