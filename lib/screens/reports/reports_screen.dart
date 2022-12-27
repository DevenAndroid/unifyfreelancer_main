import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../routers/my_router.dart';
import '../../widgets/custom_appbar.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  RxString dropDownValue1 = 'All Transactions'.obs;
  RxString dropDownValue2 = 'All Clients'.obs;

  var items = [
    'All Debits All Credits',
    'Hourly',
    'Fixed-Price',
    'Bonus',
    'Adjustments',
    'Withdrawals',
    'Expense',
  ];

  String? _startDateVPG, _endDateVPG;

  bool data = true;

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
          titleText: "Reports",
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceHeight * .01,
              ),
              DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TabBar(
                          labelColor: AppTheme.darkBlueText,
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w500),
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
                                  fontSize: 17.sp,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Timesheet",
                                style: TextStyle(
                                  fontSize: 17.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            padding: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: AppTheme.pinkText, width: 0.5))),
                            height: deviceHeight - deviceHeight * .165,
                            child: TabBarView(
                              children: [
                                ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: 5,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: ()=>Get.toNamed(MyRouter.workInProgressScreen),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "Work in progress",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: AppTheme.textColor),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "\$1000.00",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppTheme
                                                            .primaryColor),
                                                  )
                                                ],
                                              ),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    color: AppTheme.blackColor,
                                                    size: 20,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Transaction History",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: AppTheme.textColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet<void>(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10))),
                                                context: context,
                                                isScrollControlled: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: const BoxDecoration(
                                                        color: AppTheme
                                                            .whiteColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: const Icon(
                                                                Icons.clear,
                                                                color: AppTheme
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                            const Text(
                                                              'Filters',
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppTheme
                                                                      .textColor),
                                                            ),
                                                            const SizedBox(),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        PopupMenuButton<int>(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxHeight:
                                                                      400),
                                                          position:
                                                              PopupMenuPosition
                                                                  .under,
                                                          offset: Offset
                                                              .fromDirection(
                                                                  50, 100),
                                                          onSelected: (value) {
                                                            if (kDebugMode) {
                                                              print(value);
                                                            }
                                                            setState(() {
                                                              dropDownValue1
                                                                      .value =
                                                                  items[value];
                                                            });
                                                          },
                                                          // icon: Icon(Icons.keyboard_arrow_down),
                                                          itemBuilder: (context) =>
                                                              List.generate(
                                                                  items.length,
                                                                  (index) => PopupMenuItem(
                                                                      value:
                                                                          index,
                                                                      child: Text(
                                                                          items[
                                                                              index]))),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            5)),
                                                                border: Border.all(
                                                                    color: AppTheme
                                                                        .primaryColor)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Obx(() {
                                                                  return Text(
                                                                    dropDownValue1
                                                                        .value
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: AppTheme
                                                                            .primaryColor,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  );
                                                                }),
                                                                const Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_rounded,
                                                                  color: AppTheme
                                                                      .primaryColor,
                                                                )

                                                                /*DropdownButtonFormField(
                                                                  isDense: true,
                                                                  isExpanded: false,
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder.none,
                                                                    ),
                                                                    items: List.generate(
                                                                    items.length,
                                                                        (index) =>
                                                                        DropdownMenuItem(
                                                                          value: items[
                                                                          index],
                                                                          child: Text(
                                                                              items[index]
                                                                                  .toString(),
                                                                              style: TextStyle(
                                                                                  fontSize:
                                                                                  12,
                                                                                  fontWeight:
                                                                                  FontWeight.w600,
                                                                                  color: AppTheme.blackColor)),
                                                                        )), onChanged: (value){}),*/
                                                                // PopupMenuButton<int>(
                                                                //   onSelected: (value){
                                                                //     print(value);
                                                                //     setState(() {
                                                                //       dropDownValue1.value = items[value];
                                                                //     });
                                                                //   },
                                                                //   // icon: Icon(Icons.keyboard_arrow_down),
                                                                //     itemBuilder: (context)=>List.generate(items.length,(index)=> PopupMenuItem(
                                                                //       value: index,
                                                                //         child: Text("${items[index]}")))
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        /*DropdownButtonFormField<
                                                            dynamic>(
                                                          isDense: true,
                                                          isExpanded: true,
                                                          value: null,
                                                          validator: (value) {
                                                            if (value == null) {
                                                              return 'Please select type';
                                                            }
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            hintStyle: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppTheme
                                                                    .primaryColor),
                                                            hintText:
                                                                "All transactions",
                                                            counterText: "",
                                                            filled: true,
                                                            fillColor: AppTheme
                                                                .whiteColor,
                                                            focusColor: AppTheme
                                                                .whiteColor,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        12),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: AppTheme
                                                                    .primaryColor,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color(
                                                                        0xffDCDCDC)),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.0))),
                                                            border: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xffDCDCDC),
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0)),
                                                          ),
                                                          // Down Arrow Icon
                                                          icon: const Icon(
                                                              Icons
                                                                  .keyboard_arrow_down,
                                                              color: AppTheme
                                                                  .primaryColor),
                                                          items: List.generate(
                                                              items.length,
                                                              (index) =>
                                                                  DropdownMenuItem(
                                                                    value: items[
                                                                        index],
                                                                    child: Text(
                                                                        items[index]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: AppTheme.blackColor)),
                                                                  )),
                                                          // After selecting the desired option,it will
                                                          // change button value to selected value
                                                          onChanged:
                                                              (newValue) {},
                                                        ),*/
                                                        PopupMenuButton<int>(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxHeight:
                                                                      300),
                                                          position:
                                                              PopupMenuPosition
                                                                  .under,
                                                          offset: Offset
                                                              .fromDirection(
                                                                  50, 100),
                                                          onSelected: (value) {
                                                            if (kDebugMode) {
                                                              print(value);
                                                            }
                                                            setState(() {
                                                              dropDownValue2
                                                                      .value =
                                                                  items[value];
                                                            });
                                                          },
                                                          // icon: Icon(Icons.keyboard_arrow_down),
                                                          itemBuilder: (context) =>
                                                              List.generate(
                                                                  items.length,
                                                                  (index) => PopupMenuItem(
                                                                      value:
                                                                          index,
                                                                      child: Text(
                                                                          items[
                                                                              index]))),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            5)),
                                                                border: Border.all(
                                                                    color: AppTheme
                                                                        .primaryColor)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Obx(() {
                                                                  return Text(
                                                                    dropDownValue2
                                                                        .value
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: AppTheme
                                                                            .primaryColor,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  );
                                                                }),
                                                                const Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_rounded,
                                                                  color: AppTheme
                                                                      .primaryColor,
                                                                )

                                                                /*DropdownButtonFormField(
                                                                  isDense: true,
                                                                  isExpanded: false,
                                                                    decoration: InputDecoration(
                                                                      border: InputBorder.none,
                                                                    ),
                                                                    items: List.generate(
                                                                    items.length,
                                                                        (index) =>
                                                                        DropdownMenuItem(
                                                                          value: items[
                                                                          index],
                                                                          child: Text(
                                                                              items[index]
                                                                                  .toString(),
                                                                              style: TextStyle(
                                                                                  fontSize:
                                                                                  12,
                                                                                  fontWeight:
                                                                                  FontWeight.w600,
                                                                                  color: AppTheme.blackColor)),
                                                                        )), onChanged: (value){}),*/
                                                                // PopupMenuButton<int>(
                                                                //   onSelected: (value){
                                                                //     print(value);
                                                                //     setState(() {
                                                                //       dropDownValue1.value = items[value];
                                                                //     });
                                                                //   },
                                                                //   // icon: Icon(Icons.keyboard_arrow_down),
                                                                //     itemBuilder: (context)=>List.generate(items.length,(index)=> PopupMenuItem(
                                                                //       value: index,
                                                                //         child: Text("${items[index]}")))
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        /*DropdownButtonFormField(
                                                          isExpanded: true,
                                                          // Initial Value
                                                          validator: (value) {
                                                            if (value == null) {
                                                              return 'Please select type';
                                                            }
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            hintStyle: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppTheme
                                                                    .primaryColor),
                                                            hintText:
                                                                "All freelancers",
                                                            counterText: "",
                                                            filled: true,
                                                            fillColor: AppTheme
                                                                .whiteColor,
                                                            focusColor: AppTheme
                                                                .whiteColor,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        12),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: AppTheme
                                                                    .primaryColor,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color(
                                                                        0xffDCDCDC)),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.0))),
                                                            border: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Color(
                                                                        0xffDCDCDC),
                                                                    width: 2.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0)),
                                                          ),
                                                          // Down Arrow Icon
                                                          icon: const Icon(
                                                              Icons
                                                                  .keyboard_arrow_down,
                                                              color: AppTheme
                                                                  .primaryColor),
                                                          items: List.generate(
                                                              items.length,
                                                              (index) =>
                                                                  DropdownMenuItem(
                                                                    value: items[
                                                                        index],
                                                                    child: Text(
                                                                        items[index]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: AppTheme.primaryColor)),
                                                                  )),
                                                          // After selecting the desired option,it will
                                                          // change button value to selected value
                                                          onChanged:
                                                              (newValue) {},
                                                        ),*/
                                                        SizedBox(
                                                          height:
                                                              deviceHeight * .4,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  CustomOutlineButton(
                                                                title: "Clear",
                                                                backgroundColor:
                                                                    AppTheme
                                                                        .whiteColor,
                                                                expandedValue:
                                                                    true,
                                                                onPressed:
                                                                    () {},
                                                                textColor: AppTheme
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  CustomOutlineButton(
                                                                title: "Apply",
                                                                backgroundColor:
                                                                    AppTheme
                                                                        .primaryColor,
                                                                expandedValue:
                                                                    true,
                                                                onPressed:
                                                                    () {},
                                                                textColor: AppTheme
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        AppTheme.primaryColor),
                                                child: Image.asset(
                                                    "assets/icon/options.png")),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            "Balance:",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppTheme.textColor3),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "\$150.00",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.primaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Posted by",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.textColor),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) => Dialog(
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize
                                                      .min,
                                                  children: [
                                                    Container(
                                                        width:
                                                        deviceWidth,
                                                        height: 80,
                                                        color: AppTheme
                                                            .primaryColor,
                                                        child:
                                                        const Center(
                                                            child:
                                                            Text(
                                                              "Date Range",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18,
                                                                  color: AppTheme
                                                                      .whiteColor),
                                                            ))),
                                                    Container(
                                                      width: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width,
                                                      decoration: const BoxDecoration(
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
                                          if (kDebugMode) {
                                            print(_startDateVPG);
                                            print(_endDateVPG);
                                          }
                                        },
                                        child: TextFormField(
                                            enabled: false,
                                            onChanged: (value) {
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                                contentPadding:
                                                const EdgeInsets
                                                    .symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                                border:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(5.0),
                                                  borderSide:
                                                  const BorderSide(
                                                      color: Color(
                                                          0xffE8E7E7)),
                                                ),
                                                hintText:
                                                '$_startDateVPG - $_endDateVPG',
                                                focusColor: const Color(
                                                    0xffE8E7E7),
                                                hintStyle:
                                                const TextStyle(
                                                    fontSize: 13,
                                                    color: Color(
                                                        0xff828282)),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(5.0),
                                                  borderSide:
                                                  const BorderSide(
                                                      color: Color(
                                                          0xffE8E7E7)),
                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(5.0),
                                                  borderSide:
                                                  const BorderSide(
                                                      color: Color(
                                                          0xffE8E7E7)),
                                                ),
                                                errorBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(5.0),
                                                  borderSide:
                                                  const BorderSide(
                                                      color: Color(
                                                          0xffE8E7E7)),
                                                ),
                                                suffixIcon: const Icon(
                                                  Icons
                                                      .calendar_month_outlined,
                                                  color: AppTheme
                                                      .primaryColor,
                                                ))),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      SizedBox(
                                        child: data ?
                                        listData():
                                        Column(children: [
                                      Image.asset(
                                          "assets/images/investment.png"),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      const Text(
                                        "No transactions meet your selected criteria",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff00065A)),
                                        textAlign: TextAlign.center,
                                      ),
                                      ]

                                      )
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    /*  Container(
                                        width: deviceWidth,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.whiteColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [

                                          ],
                                        ),
                                      )*/
                                    ],
                                  ),
                                ),
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
          DateFormat('dd-MM-yyyy').format(args.value.startDate).toString();
      _endDateVPG = DateFormat('dd-MM-yyyy')
          .format(args.value.endDate ?? args.value.startDate)
          .toString();
    });
  }

  listData() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 15),
          width: double.infinity,
          decoration: const BoxDecoration(color: Color(0xffF9F9F9)),
          child: Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Date",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Client / Description",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor),
                  ),
                ),
                Center(
                  child: Text(
                    "Amount",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textColor),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: AddSize.size10,
        ),
        ListView.builder(
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context,index){
              return Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text(
                          "12-12-2022",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.blackColor),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Jolly Smith",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.blackColor),
                            ),
                            SizedBox(
                              height: AddSize.size10 * .5,
                            ),
                            const Text(
                              "WordPress Developer...",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff545454)),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "\$50.00",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.blackColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AddSize.size10 * .5,
                  ),
                  const Divider(
                    color: Color(0xffE2E2E2),
                  )
                ],
              );

            }),
        const Align(
          alignment: Alignment.topRight,
          child: Text(
            "\$150.00",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.blackColor),
          ),
        ),
        const Divider(
          color: Color(0xffE2E2E2),
        )
      ],
    );
  }
}
