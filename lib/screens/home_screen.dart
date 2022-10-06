import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*var index = 0;*/
/*
  List<StackButtons> stackButtonsList = [
    StackButtons(titleText: 'Support Agent', positionPoint: 0),
    StackButtons(titleText: 'Designer', positionPoint: 50),
    StackButtons(titleText: 'IOS Developer', positionPoint: 100),
    StackButtons(titleText: 'Backend Developer', positionPoint: 150),
  ];*/

  List<String> stackButtonsList = [
    'Support Agent',
    'Designer',
    'IOS Developer',
    'Backend Developer'
  ];

  @override
  void initState() {
    super.initState();

  }

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
          titleText: "Jobs",
        ),
      ),
      drawer: AppDrawerScreen(),*/
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: AppTheme.textColor, fontSize: 14.sp),
                      filled: true,
                      fillColor: Colors.white24,
                      hintText: 'Search for job',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      suffixIcon: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icon/Search.svg',
                            color: AppTheme.whiteColor,
                          ))),
                ),
              ),
              SizedBox(
                height: deviceHeight * .01,
              ),
              DefaultTabController(
                  length: 3, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: TabBar(
                            labelColor: AppTheme.primaryColor,
                            unselectedLabelColor: AppTheme.blackColor,
                            padding: EdgeInsets.zero,
                            isScrollable: true,
                            indicatorPadding: EdgeInsets.zero,
                            // indicatorColor: const Color(0xffFA61FF),
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 3.0.w,
                                color: AppTheme.pinkText,
                              ),
                            ),
                            automaticIndicatorColorAdjustment: true,
                            unselectedLabelStyle:
                                const TextStyle(fontWeight: FontWeight.w500),
                            tabs: [
                              Tab(
                                child: Text(
                                  "My Feed",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Best Matches",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Most Recent",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(top: 10),
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: AppTheme.pinkText, width: 0.5))),
                            height: deviceHeight * .7,
                            child: TabBarView(
                                children: List.generate(
                              3,
                              (index) => ListView.builder(
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 15, right: 10, left: 10),
                                      width: deviceWidth,
                                      padding: const EdgeInsets.all(10),
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
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: deviceWidth * .01,
                                          ),
                                          Text(
                                            "VeeGaming Studio",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppTheme.pinkText,
                                            ),
                                          ),
                                          SizedBox(
                                            height: deviceHeight * .01,
                                          ),
                                          Text(
                                            "IOS And Android  Mobile App Developer",
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.darkBlueText,
                                            ),
                                          ),
                                          SizedBox(
                                            height: deviceHeight * .01,
                                          ),
                                          Text(
                                            "We are a computerized  wellbeing startup with a spry and  high-speed climate. ",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w300,
                                                color: AppTheme.greyTextColor),
                                          ),
                                          SizedBox(
                                            height: deviceHeight * .01,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "\$140.00",
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppTheme
                                                            .darkBlueText),
                                                  ),
                                                  Text(
                                                    "Budget",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xff6B6B6B)),
                                                  ),
                                                ],
                                              ),
                                              CustomOutlineButton(
                                                title: "Send Proposal",
                                                backgroundColor:
                                                    AppTheme.whiteColor,
                                                textColor:
                                                    AppTheme.primaryColor,
                                                onPressed: () => Get.toNamed(
                                                    MyRouter.jobDetailsScreen),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: deviceHeight * .01,
                                          ),
                                          const Divider(
                                            color: Color(0xff6D2EF1),
                                          ),
                                          SizedBox(
                                            height: deviceHeight * .01,
                                          ),
                                          SizedBox(
                                            width: deviceWidth,
                                            height: 55.h,
                                            child: ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    stackButtonsList.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin: EdgeInsets.only(
                                                        right: 4, bottom: 8),
                                                    child: CustomOutlineButton(
                                                      title: stackButtonsList[
                                                          index],
                                                      backgroundColor:
                                                          AppTheme.whiteColor,
                                                      textColor:
                                                          AppTheme.primaryColor,
                                                      expandedValue: false,
                                                      onPressed: () {},
                                                    ),
                                                  );
                                                }),
                                            /*
                                            Stack(
                                              children:
                                              List.generate(stackButtonsList.length, (index11)
                                              => Positioned(left: stackButtonsList[index11].positionPoint,
                                                    child: CustomOutlineButton(backgroundColor: AppTheme.whiteColor,
                                                      textColor: AppTheme.primaryColor, title: stackButtonsList[index11].titleText.toString(),
                                                      onPressed: () {
                                                        String titleName = "";
                                                        double positionName = 0;
                                                        titleName = stackButtonsList[index11].titleText!;
                                                        positionName =
                                                            stackButtonsList[
                                                                    index11]
                                                                .positionPoint!;
                                                        stackButtonsList
                                                            .removeAt(index11);
                                                        stackButtonsList.add(
                                                            StackButtons(
                                                                titleText:
                                                                    titleName,
                                                                positionPoint:
                                                                    positionName));
                                                        setState(() {});
                                                      },
                                                    )),
                                              ),
                                              // children: [
                                              // ],
                                            ),*/
                                          ),
                                          SizedBox(
                                            height: deviceHeight * .01,
                                          ),
                                        ],
                                      ));
                                },
                              ),
                            )))
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
/*

class StackButtons {
  final String? titleText;
  final double? positionPoint;

  StackButtons({this.titleText, this.positionPoint});
}
*/
