import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/proposals_screen_controller.dart';
import '../models/proposal_screen_model.dart';
import '../resources/app_theme.dart';
import '../resources/size.dart';
import '../routers/my_router.dart';

class ProposalsScreen extends StatefulWidget {
  const ProposalsScreen({Key? key}) : super(key: key);

  @override
  State<ProposalsScreen> createState() => _ProposalsScreenState();
}

class _ProposalsScreenState extends State<ProposalsScreen> {
  final controller = Get.put(ProposalScreenController());

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(() {
        return Column(
        children: [
          SizedBox(height: 10.h),
          DefaultTabController(
              length: 3, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TabBar(
                      isScrollable: true,
                      labelColor: Color(0xff271943),
                      labelStyle: TextStyle(fontWeight: FontWeight.w500),
                      unselectedLabelColor: Color(0xff707070),
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
                        /* Tab(
                          child: Text(
                            "Offers",
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                        ),*/
                        Tab(
                          child: Text(
                            "Submitted Proposals",
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Active Proposals",
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Invitations to interview",
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if(controller.status.value.isSuccess)
                    Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: AppTheme.pinkText, width: 0.5))),
                        height: deviceHeight - 195,
                        child: TabBarView(
                            children: [
                          interview(
                              controller.model.value.data!.submittedProposal!,
                              "No proposals submitted yet."),
                          interview(
                              controller.model.value.data!.activeProposal!,
                              "No active proposal."),
                          interview(
                              controller
                                  .model.value.data!.interviewForInvitation!,
                              "No invitations to interview."),
                        ])),
                    if(controller.status.value.isError)
                      Column(
                        children: [
                          SizedBox(
                            height: AddSize.size200,
                          ),

                          SizedBox(
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
                          ),
                        ],
                      ),
                    if(controller.status.value.isEmpty)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: AddSize.size200,
                          ),
                          Center(
                            child: CircularProgressIndicator(color: AppTheme.primaryColor),
                          ),
                        ],
                      ),
                  ])),
        ],
      );
}),
    );
  }

  interview(List<SubmittedProposal>? item, message) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return item!.length == 0
        ? Center(
        child: Text(message,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.darkBlueText,
            )))
        : ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: item!.length,
      padding: EdgeInsets.only(bottom: 30),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Get.toNamed(MyRouter.jobDetailsScreen,
                arguments: [item[index].projectId]);
            print([item[index].projectId]);
          },
          child: Container(
            margin:
            const EdgeInsets.only(top: 15, right: 10, left: 10),
            width: deviceWidth,
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 20),
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
                  offset: const Offset(
                      0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item[index].name.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.darkBlueText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: deviceHeight * .01,
                ),
                Text(
                  item[index].projectDescription.toString(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.greyTextColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: deviceHeight * .01,
                ),
                Text(
                  item[index].time.toString(),
                  style: TextStyle(
                      fontSize: 12, color: AppTheme.greyTextColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
