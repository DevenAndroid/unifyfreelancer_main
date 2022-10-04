import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../resources/app_theme.dart';
import '../routers/my_router.dart';
import '../widgets/appDrawer.dart';
import '../widgets/custom_appbar.dart';

class ProposalsScreen extends StatefulWidget {
  const ProposalsScreen({Key? key}) : super(key: key);

  @override
  State<ProposalsScreen> createState() => _ProposalsScreenState();
}

class _ProposalsScreenState extends State<ProposalsScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      /* appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: true,
          isProfileImage: true,
          titleText: "Proposals",
        ),
      ),
      drawer: AppDrawerScreen(),*/
      body: Column(
        children: [
          SizedBox(height: 10.h),
          DefaultTabController(
              length: 4, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
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
                        Tab(
                          child: Text(
                            "Offers",
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
                            "Submitted Proposals",
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
                        height: deviceHeight - 195,
                        child: TabBarView(
                            children: List.generate(
                          4,
                          (index) => ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 10,
                            padding: EdgeInsets.only(bottom: 30),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () =>
                                    Get.toNamed(MyRouter.jobDetailsScreen),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 15, right: 10, left: 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "WordPress theme design",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppTheme.darkBlueText),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      Text(
                                        "Received Aug 10,2022",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppTheme.greyTextColor),
                                      ),
                                      SizedBox(
                                        height: deviceHeight * .01,
                                      ),
                                      Text(
                                        "2 days ago",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppTheme.greyTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ))),
                  ])),
        ],
      ),
    );
  }
}
