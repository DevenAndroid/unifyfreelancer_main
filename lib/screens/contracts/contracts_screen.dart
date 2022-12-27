import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/contract_controller.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../routers/my_router.dart';
import '../../widgets/common_outline_button.dart';

class ContractsScreen extends StatefulWidget {
  const ContractsScreen({Key? key}) : super(key: key);

  @override
  State<ContractsScreen> createState() => _ContractsScreenState();
}

class _ContractsScreenState extends State<ContractsScreen> {
  final controller = Get.put(ContractScreenController());
  final dateFormatForShow = DateFormat('dd-MMM-yyyy');
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(() {
        return controller.status.value.isSuccess
            ? SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Row(
                        children: const [
                          Text(
                            "Active Contracts",
                            style: TextStyle(
                                fontSize: 20,
                                color: AppTheme.textColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.whiteColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
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
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: AppTheme.textColor, fontSize: 14.sp),
                              filled: true,
                              fillColor: Colors.white24,
                              hintText: 'Search contracts',
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(15),
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                  'assets/icon/Search.svg',
                                  color: AppTheme.primaryColor,
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      DefaultTabController(
                          length: 5, // length of tabs
                          initialIndex: 0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                TabBar(
                                  isScrollable: true,
                                  labelColor: const Color(0xff271943),
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  unselectedLabelColor: const Color(0xff707070),
                                  // indicatorColor: const Color(0xffFA61FF),
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                      width: 3.0.w,
                                      color: AppTheme.pinkText,
                                    ),
                                  ),
                                  automaticIndicatorColorAdjustment: true,
                                  unselectedLabelStyle:
                                      const TextStyle(color: Color(0xff707070)),
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        "All (${controller.model.value.data!.all!.length.toString()})",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        "Hourly (${controller.model.value.data!.hourly!.length.toString()})",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        "Active Milestones (${controller.model.value.data!.activeMilestone!.length.toString()})",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        "Awaiting Milestones (${controller.model.value.data!.awaitingMilestone!.length.toString()})",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        "Payment Requests",
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
                                                color: AppTheme.pinkText,
                                                width: 0.5))),
                                    height: deviceHeight - deviceWidth * .85,
                                    child: TabBarView(
                                      children: [
                                        all(),
                                        hourly(),
                                        activeMilestone(),
                                        awaitingMilestones(),
                                        paymentRequest(),
                                      ],
                                    )),
                              ])),
                    ],
                  ),
                ),
              )
            : controller.status.value.isError
                ? SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.model.value.message.toString(),
                          // fontSize: AddSize.font16,
                        ),
                        IconButton(
                            onPressed: () {
                              controller.getData();
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
      }),
    );
  }

  all() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return controller.model.value.data!.all!.isEmpty
        ? Center(
            child: Text("No contracts found",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkBlueText,
                )))
        : RefreshIndicator(
            onRefresh: () async {
              controller.getData();
            },
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.model.value.data!.all!.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
                  width: deviceWidth,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              controller
                                  .model.value.data!.all![index].projectTitle
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: AppTheme.whiteColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: const Icon(
                                                Icons.clear,
                                                color: Colors.black,
                                              ),
                                            )),
                                        InkWell(
                                          onTap: () => Get.toNamed(
                                              MyRouter.contractsDetailsScreen),
                                          child: const Text(
                                            'View work diary',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.darkBlueText),
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .03,
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              Get.toNamed(MyRouter.chatScreen),
                                          child: const Text(
                                            'Send Message',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.darkBlueText),
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .03,
                                        ),
                                        /*const Text(
                                                                'Propose new contract',
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppTheme
                                                                        .darkBlueText),
                                                              ),*/
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.more_horiz_outlined,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      /*Text(
                  "Staffed by: Robert Smith",
                  style: TextStyle(
                    fontSize: 12,
                    color:
                    AppTheme.darkBlueText,
                  ),
                ),*/
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Text(
                        "Hired by: ${controller.model.value.data!.all![index].client!.firstName} ${controller.model.value.data!.all![index].client!.lastName}",
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      /*   Text(
                  "Soft Co",
                  style: TextStyle(
                    fontSize: 12,
                    color:
                    AppTheme.textColor3,
                  ),
                ),*/
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      /*Text(
                                              "Active: 2:30 hrs this week",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppTheme.textColor,
                                                  fontWeight: FontWeight.w600),
                                            ),*/

                      RichText(
                        text: const TextSpan(
                          text: 'Active: ',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.textColor,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(
                              text: '2:30',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: ' hrs this week',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.textColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      Text(
                        "${dateFormatForShow.format(DateTime.parse(controller.model.value.data!.all![index].createdAt.toString()))} - Present",
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textColor3,
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * .025,
                      ),
                      CustomOutlineButton(
                        title: "See Timesheet",
                        backgroundColor: AppTheme.primaryColor,
                        textColor: AppTheme.whiteColor,
                        expandedValue: true,
                        onPressed: () {
                          Get.toNamed(MyRouter.contractsDetailsScreen);
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }

  hourly() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return controller.model.value.data!.hourly!.isEmpty
        ? Center(
            child: Text("No contracts found",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkBlueText,
                )))
        : RefreshIndicator(
            onRefresh: () async {
              controller.getData();
            },
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.model.value.data!.hourly!.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
                  width: deviceWidth,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              controller
                                  .model.value.data!.hourly![index].projectTitle
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: AppTheme.whiteColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: const Icon(
                                                Icons.clear,
                                                color: Colors.black,
                                              ),
                                            )),
                                        InkWell(
                                          onTap: () => Get.toNamed(
                                              MyRouter.contractsDetailsScreen),
                                          child: const Text(
                                            'View work diary',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.darkBlueText),
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .03,
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              Get.toNamed(MyRouter.chatScreen),
                                          child: const Text(
                                            'Send Message',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.darkBlueText),
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .03,
                                        ),
                                        /*const Text(
                                                                'Propose new contract',
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppTheme
                                                                        .darkBlueText),
                                                              ),*/
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.more_horiz_outlined,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      /*    Text(
                  "Staffed by: Robert Smith",
                  style: TextStyle(
                    fontSize: 12,
                    color:
                    AppTheme.darkBlueText,
                  ),
                ),
                SizedBox(
                  height: deviceHeight * .02,
                ),*/
                      Text(
                        "Hired by : ${controller.model.value.data!.hourly![index].client!.firstName} ${controller.model.value.data!.hourly![index].client!.lastName}",
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w600),
                      ),
                      /* SizedBox(
                  height: deviceHeight * .01,
                ),
                Text(
                  "Soft Co",
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textColor3,
                  ),
                ),*/
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      /*Text(
                                              "Active: 2:30 hrs this week",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppTheme.textColor,
                                                  fontWeight: FontWeight.w600),
                                            ),*/

                      RichText(
                        text: const TextSpan(
                          text: 'Active: ',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.textColor,
                              fontWeight: FontWeight.w600),
                          children: <TextSpan>[
                            TextSpan(
                              text: '2:30',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text: ' hrs this week',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.textColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      Text(
                        "${dateFormatForShow.format(DateTime.parse(controller.model.value.data!.hourly![index].createdAt.toString()))} - Present",
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textColor3,
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * .025,
                      ),
                      CustomOutlineButton(
                        title: "See Timesheet",
                        backgroundColor: AppTheme.primaryColor,
                        textColor: AppTheme.whiteColor,
                        expandedValue: true,
                        onPressed: () {
                          Get.toNamed(MyRouter.contractsDetailsScreen);
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }

  activeMilestone() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return controller.model.value.data!.activeMilestone!.isEmpty
        ? Center(
            child: Text("No contracts found",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkBlueText,
                )))
        : RefreshIndicator(
            onRefresh: () async {
              controller.getData();
            },
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.model.value.data!.activeMilestone!.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
                  width: deviceWidth,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              controller.model.value.data!
                                  .activeMilestone![index].projectTitle
                                  .toString()
                                  .capitalizeFirst!,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: AppTheme.whiteColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: const Icon(
                                                Icons.clear,
                                                color: Colors.black,
                                              ),
                                            )),
                                        InkWell(
                                          onTap: () => Get.toNamed(
                                              MyRouter.contractsDetailsScreen),
                                          child: const Text(
                                            'View work diary',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.darkBlueText),
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .03,
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              Get.toNamed(MyRouter.chatScreen),
                                          child: const Text(
                                            'Send Message',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.darkBlueText),
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .03,
                                        ),
                                        /*const Text(
                                                                'Propose new contract',
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppTheme
                                                                        .darkBlueText),
                                                              ),*/
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.more_horiz_outlined,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Hired by : ${controller.model.value.data!.activeMilestone![index].client!.firstName} ${controller.model.value.data!.activeMilestone![index].client!.lastName}",
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Text(
                        "Admin: Soft Co",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textColor3,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Text(
                        "Active: Waiting for Admin to fund new Milestone",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff130E1D),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "\$2000.00",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff130E1D),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(
                                "\$500.00",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff130E1D),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Budget",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textColor3,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(
                                "in Escrow",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textColor3,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "${dateFormatForShow.format(DateTime.parse(controller.model.value.data!.activeMilestone![index].createdAt.toString()))} - Present",
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textColor3,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomOutlineButton(
                        title: "Submit Work for Payment",
                        backgroundColor: AppTheme.primaryColor,
                        textColor: AppTheme.whiteColor,
                        expandedValue: true,
                        onPressed: () {
                          Get.toNamed(MyRouter.contractsDetailsScreen);
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }

  awaitingMilestones() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return controller.model.value.data!.awaitingMilestone!.isEmpty
        ? Center(
            child: Text("No contracts found",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkBlueText,
                )))
        : RefreshIndicator(
            onRefresh: () async {
              controller.getData();
            },
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.model.value.data!.awaitingMilestone!.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
                  width: deviceWidth,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              controller.model.value.data!
                                  .awaitingMilestone![index].projectTitle
                                  .toString()
                                  .capitalizeFirst!,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.darkBlueText,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: AppTheme.whiteColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: const Icon(
                                                Icons.clear,
                                                color: Colors.black,
                                              ),
                                            )),
                                        InkWell(
                                          onTap: () => Get.toNamed(
                                              MyRouter.contractsDetailsScreen),
                                          child: const Text(
                                            'View work diary',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.darkBlueText),
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .03,
                                        ),
                                        InkWell(
                                          onTap: () =>
                                              Get.toNamed(MyRouter.chatScreen),
                                          child: const Text(
                                            'Send Message',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.darkBlueText),
                                          ),
                                        ),
                                        SizedBox(
                                          height: deviceWidth * .03,
                                        ),
                                        /*const Text(
                                                                'Propose new contract',
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppTheme
                                                                        .darkBlueText),
                                                              ),*/
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.more_horiz_outlined,
                                color: AppTheme.whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Hired by : ${controller.model.value.data!.awaitingMilestone![index].client!.firstName} ${controller.model.value.data!.awaitingMilestone![index].client!.lastName}",
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Text(
                        "Admin: Soft Co",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textColor3,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Text(
                        "Active: Waiting for Admin to fund new Milestone",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff130E1D),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: deviceHeight * .02,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "\$2000.00",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff130E1D),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(
                                "\$500.00",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff130E1D),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Budget",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textColor3,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(
                                "in Escrow",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.textColor3,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "${dateFormatForShow.format(DateTime.parse(controller.model.value.data!.awaitingMilestone![index].createdAt.toString()))} - Present",
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textColor3,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomOutlineButton(
                        title: "Submit Work for Payment",
                        backgroundColor: AppTheme.primaryColor,
                        textColor: AppTheme.whiteColor,
                        expandedValue: true,
                        onPressed: () {
                          Get.toNamed(MyRouter.contractsDetailsScreen);
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }

  paymentRequest() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: () async {
        controller.getData();
      },
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 1,
        padding: const EdgeInsets.only(bottom: 20),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(top: 15, right: 10, left: 10),
            width: deviceWidth,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/card.png"),
                SizedBox(
                  height: deviceHeight * .02,
                ),
                const Text(
                  "You have no fixed-price contracts with payment requests",
                  style: TextStyle(fontSize: 14, color: AppTheme.textColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomOutlineButton(
                  title: "View ALL Contracts",
                  backgroundColor: AppTheme.primaryColor,
                  onPressed: () {
                    Get.toNamed(MyRouter.contractsDetailsScreen);
                  },
                  expandedValue: true,
                  textColor: AppTheme.whiteColor,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
