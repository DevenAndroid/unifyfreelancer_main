import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';

import '../resources/app_theme.dart';
import '../widgets/custom_appbar.dart';

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
                                  padding: EdgeInsets.only(bottom: 20),
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: 5,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Work in progress",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color:
                                                          AppTheme.textColor),
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
                                    );
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Transaction History",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: AppTheme.textColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet<void>(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10))),
                                                context: context,
                                                isScrollControlled: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
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
                                                              child: Icon(
                                                                Icons.clear,
                                                                color: AppTheme
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Filters',
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppTheme
                                                                      .textColor),
                                                            ),
                                                            SizedBox(),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        PopupMenuButton<int>(
                                                          constraints:
                                                              BoxConstraints(
                                                                  maxHeight:
                                                                      400),
                                                          position:
                                                              PopupMenuPosition
                                                                  .under,
                                                          offset: Offset
                                                              .fromDirection(
                                                                  50, 100),
                                                          onSelected: (value) {
                                                            print(value);
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
                                                                          "${items[index]}"))),
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
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
                                                                    "${dropDownValue1.value.toString()}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: AppTheme
                                                                            .primaryColor,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  );
                                                                }),
                                                                Icon(
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
                                                              BoxConstraints(
                                                                  maxHeight:
                                                                      300),
                                                          position:
                                                              PopupMenuPosition
                                                                  .under,
                                                          offset: Offset
                                                              .fromDirection(
                                                                  50, 100),
                                                          onSelected: (value) {
                                                            print(value);
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
                                                                          "${items[index]}"))),
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
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
                                                                    "${dropDownValue2.value.toString()}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: AppTheme
                                                                            .primaryColor,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  );
                                                                }),
                                                                Icon(
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
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
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
                                        children: [
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
                                            "\$0.00",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppTheme.primaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Container(
                                        width: deviceWidth,
                                        padding: EdgeInsets.all(10),
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
                                            Align(
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
                                                                  child: Center(
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
                                              child: TextFormField(
                                                  enabled: false,
                                                  onChanged: (value) {
                                                    setState(() {});
                                                  },
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
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffE8E7E7)),
                                                      ),
                                                      hintText:
                                                          '${_startDateVPG} - ${_endDateVPG}',
                                                      focusColor:
                                                          Color(0xffE8E7E7),
                                                      hintStyle: TextStyle(
                                                          fontSize: 13,
                                                          color: Color(
                                                              0xff828282)),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffE8E7E7)),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffE8E7E7)),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide:
                                                            new BorderSide(
                                                                color: Color(
                                                                    0xffE8E7E7)),
                                                      ),
                                                      suffixIcon: Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        color: AppTheme
                                                            .primaryColor,
                                                      ))),
                                            ),
                                            SizedBox(
                                              height: 30.h,
                                            ),
                                            Image.asset(
                                                "assets/images/investment.png"),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text(
                                              "No transactions meet your selected criteria",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff00065A)),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                          ],
                                        ),
                                      )
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
}
