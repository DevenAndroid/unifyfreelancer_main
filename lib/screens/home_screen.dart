import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';

import '../controller/jobs_list_controller.dart';
import '../repository/job_module/remove_saved_jobs.dart';
import '../repository/job_module/saved_jobs_repository.dart';
import '../resources/size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final controller = Get.put(JobListController());

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: AppTheme.textColor, fontSize: 14.sp),
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
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.w600),
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
                                  const TextStyle(fontWeight: FontWeight.w400),
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
                                          color: AppTheme.pinkText,
                                          width: 0.5))),
                              height: deviceHeight * .7,
                              child: TabBarView(children: [
                                myFeed(),
                                bestMatches(),
                                mostRecent(),
                              ]))
                        ])),
              ],
            ),
          ),
        );
      }),
    );
  }

  myFeed() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      child: controller.status.value.isSuccess
          ? controller.modelJobList.value.data!.length == 0
              ? Center(
                  child: Text("No my  feed",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkBlueText,
                      )))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.modelJobList.value.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(MyRouter.jobDetailsScreen, arguments: [
                          controller.modelJobList.value.data![index].id,
                        ]);
                        print(controller.modelJobList.value.data![index].id);
                      },
                      child: Container(
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
                              SizedBox(
                                height: deviceWidth * .01,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                        controller.modelJobList.value
                                            .data![index].name
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.pinkText,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showFilterButtonSheet(
                                          context: context,
                                          titleText: "Dislike reasons",
                                          widgets: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Divider(
                                                color: Color(0xff6D2EF1),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              InkWell(
                                                onTap: () {

                                                },
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: controller
                                                        .dislikeReasons
                                                        .value
                                                        .data!
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            controller
                                                                .dislikeReasons
                                                                .value
                                                                .data![index]
                                                                .name
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: AppTheme
                                                                  .darkBlueText,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          )
                                                        ],
                                                      );
                                                    }),
                                              )
                                            ],
                                          ));
                                    },
                                    child: Icon(
                                      Icons.thumb_down_alt_outlined,
                                      size: 22.sp,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SizedBox(
                                    child: controller.modelJobList.value
                                                .data![index].is_saved ==
                                            false
                                        ? InkWell(
                                            onTap: () {
                                              savedJobsRepo(
                                                      job_id: int.parse(
                                                          controller
                                                              .modelJobList
                                                              .value
                                                              .data![index]
                                                              .id
                                                              .toString()),
                                                      context: context)
                                                  .then((value) {
                                                if (value.status == true) {}
                                                controller.getData();
                                                showToast(
                                                    value.message.toString());
                                              });
                                            },
                                            child: Icon(
                                              Icons.favorite_border,
                                              size: 22.sp,
                                              color: AppTheme.primaryColor,
                                            ))
                                        : InkWell(
                                            onTap: () {
                                              removeSavedJobsRepo(
                                                      job_id: int.parse(
                                                          controller
                                                              .modelJobList
                                                              .value
                                                              .data![index]
                                                              .id
                                                              .toString()),
                                                      context: context)
                                                  .then((value) {
                                                if (value.status == true) {}
                                                showToast(
                                                    value.message.toString());
                                                controller.getData();
                                              });
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              size: 22.sp,
                                              color: AppTheme.primaryColor,
                                            )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              Text(
                                controller.modelJobList.value.data![index].type
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkBlueText,
                                ),
                              ),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              Text(
                                  controller.modelJobList.value.data![index]
                                      .description
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300,
                                      color: AppTheme.greyTextColor),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "\$" +
                                            controller.modelJobList.value
                                                .data![index].price
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkBlueText),
                                      ),
                                      Text(
                                        "Budget",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff6B6B6B)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.modelJobList.value
                                            .data![index].budgetType
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkBlueText),
                                      ),
                                      Text(
                                        "Project type",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff6B6B6B)),
                                      ),
                                    ],
                                  ),
                                  //Send proposal button
                                  /*CustomOutlineButton(
                                      title: "Send Proposal",
                                      backgroundColor: AppTheme.whiteColor,
                                      textColor: AppTheme.primaryColor,
                                      onPressed: () {
                                        Get.toNamed(MyRouter.jobDetailsScreen,
                                            arguments: [
                                              controller.modelJobList.value
                                                  .data![index].id,
                                            ]);
                                        print(controller.modelJobList.value
                                            .data![index].id);
                                      }),*/
                                ],
                              ),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              SizedBox(
                                child: controller.modelJobList.value.data![index].skills!.length == 0
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          const Divider(
                                            color: Color(0xff6D2EF1),
                                          ),
                                          SizedBox(
                                            height: deviceHeight * .01,
                                          ),
                                          SizedBox(
                                            width: deviceWidth,
                                            height: 45.h,
                                            child: ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: controller
                                                    .modelJobList
                                                    .value
                                                    .data![index]
                                                    .skills!
                                                    .length,
                                                itemBuilder: (context, index2) {
                                                  return Container(
                                                      margin: EdgeInsets.only(
                                                          right: 4, bottom: 10),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    AppTheme
                                                                        .whiteColor,
                                                                side:
                                                                    const BorderSide(
                                                                  color: Color(
                                                                      0xff6D2EF1),
                                                                ),
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius
                                                                                .all(
                                                                  Radius
                                                                      .circular(
                                                                          30),
                                                                )),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                ),
                                                                textStyle:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                        onPressed: () {},
                                                        child: Text(
                                                          controller
                                                              .modelJobList
                                                              .value
                                                              .data![index]
                                                              .skills![index2]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .primaryColor),
                                                        ),
                                                      ));
                                                }),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          )),
                    );
                  },
                )
          : controller.status.value.isError
              ? SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.modelJobList.value.message.toString(),
                        // fontSize: AddSize.font16,
                      ),
                      IconButton(
                          onPressed: () {
                            controller.getData();
                            controller.getDataRecentJob();
                            controller.getDataBestJob();
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
                ),
    );
  }

  bestMatches() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      child: controller.status3.value.isSuccess
          ? controller.modelBestJobList.value.data!.length == 0
              ? Center(
                  child: Text("No best matches.",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkBlueText,
                      )))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.modelBestJobList.value.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(MyRouter.jobDetailsScreen, arguments: [
                          controller.modelBestJobList.value.data![index].id,
                        ]);
                        print(
                            controller.modelBestJobList.value.data![index].id);
                      },
                      child: Container(
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
                              SizedBox(
                                height: deviceWidth * .01,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        controller.modelBestJobList.value
                                            .data![index].name
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.pinkText,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Icon(
                                    Icons.thumb_down_alt_outlined,
                                    size: 22.sp,
                                    color: AppTheme.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SizedBox(
                                    child: controller.modelBestJobList.value
                                                .data![index].is_saved ==
                                            false
                                        ? InkWell(
                                            onTap: () {
                                              savedJobsRepo(
                                                      job_id: int.parse(
                                                          controller
                                                              .modelBestJobList
                                                              .value
                                                              .data![index]
                                                              .id
                                                              .toString()),
                                                      context: context)
                                                  .then((value) {
                                                if (value.status == true) {}
                                                showToast(
                                                    value.message.toString());
                                                controller.getDataBestJob();
                                              });
                                            },
                                            child: Icon(
                                              Icons.favorite_border,
                                              size: 22,
                                              color: AppTheme.primaryColor,
                                            ))
                                        : InkWell(
                                            onTap: () {
                                              setState(() {
                                                removeSavedJobsRepo(
                                                        job_id: int.parse(
                                                            controller
                                                                .modelBestJobList
                                                                .value
                                                                .data![index]
                                                                .id
                                                                .toString()),
                                                        context: context)
                                                    .then((value) {
                                                  if (value.status == true) {}
                                                  showToast(
                                                      value.message.toString());
                                                  controller.getDataBestJob();
                                                });
                                              });
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              size: 22,
                                              color: AppTheme.primaryColor,
                                            )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              Text(
                                controller
                                    .modelBestJobList.value.data![index].type
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkBlueText,
                                ),
                              ),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              Text(
                                  controller.modelBestJobList.value.data![index]
                                      .description
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    color: AppTheme.greyTextColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "\$" +
                                            controller.modelBestJobList.value
                                                .data![index].price
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkBlueText),
                                      ),
                                      Text(
                                        "Budget",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff6B6B6B)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.modelBestJobList.value
                                            .data![index].budgetType
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkBlueText),
                                      ),
                                      Text(
                                        "Project type",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff6B6B6B)),
                                      ),
                                    ],
                                  ),

                                  //Send proposal button
                                  /*CustomOutlineButton(
                                  title: "Send Proposal",
                                  backgroundColor: AppTheme.whiteColor,
                                  textColor: AppTheme.primaryColor,
                                  onPressed: () {
                                    Get.toNamed(MyRouter.jobDetailsScreen,
                                        arguments: [
                                          controller.modelBestJobList.value
                                              .data![index].id,
                                        ]);
                                    print(controller.modelBestJobList.value
                                        .data![index].id);
                                  }),*/
                                ],
                              ),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              SizedBox(
                                child: controller.modelBestJobList.value
                                            .data![index].skills!.length ==
                                        0
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          const Divider(
                                            color: Color(0xff6D2EF1),
                                          ),
                                          SizedBox(
                                            height: deviceHeight * .01,
                                          ),
                                          SizedBox(
                                            width: deviceWidth,
                                            height: 45.h,
                                            child: ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: controller
                                                    .modelBestJobList
                                                    .value
                                                    .data![index]
                                                    .skills!
                                                    .length,
                                                itemBuilder: (context, index2) {
                                                  return Container(
                                                      margin: EdgeInsets.only(
                                                          right: 4, bottom: 10),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    AppTheme
                                                                        .whiteColor,
                                                                side:
                                                                    const BorderSide(
                                                                  color: Color(
                                                                      0xff6D2EF1),
                                                                ),
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius
                                                                                .all(
                                                                  Radius
                                                                      .circular(
                                                                          30),
                                                                )),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                ),
                                                                textStyle:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                        onPressed: () {},
                                                        child: Text(
                                                          controller
                                                              .modelBestJobList
                                                              .value
                                                              .data![index]
                                                              .skills![index2]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .primaryColor),
                                                        ),
                                                      )

                                                      /*CustomOutlineButton(
                                                          title: stackButtonsList[index],
                                                          backgroundColor: AppTheme.whiteColor,
                                                          textColor: AppTheme.primaryColor,
                                                          expandedValue: false,
                                                          onPressed: () {},
                                                        ),*/
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
                                        ],
                                      ),
                              )
                            ],
                          )),
                    );
                  },
                )
          : controller.status3.value.isError
              ? SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.modeRecentJobList.value.message.toString(),
                        // fontSize: AddSize.font16,
                      ),
                      IconButton(
                          onPressed: () {
                            controller.getData();
                            controller.getDataRecentJob();
                            controller.getDataBestJob();
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
                ),
    );
  }

  mostRecent() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      child: controller.status2.value.isSuccess
          ? controller.modeRecentJobList.value.data!.length == 0
              ? Center(
                  child: Text("No most recent",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkBlueText,
                      )))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.modeRecentJobList.value.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(MyRouter.jobDetailsScreen, arguments: [
                          controller.modeRecentJobList.value.data![index].id
                        ]);
                        print(
                            controller.modeRecentJobList.value.data![index].id);
                      },
                      child: Container(
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
                              SizedBox(
                                height: deviceWidth * .01,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        controller.modeRecentJobList.value
                                            .data![index].name
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.pinkText,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  Icon(
                                    Icons.thumb_down_alt_outlined,
                                    size: 22.sp,
                                    color: AppTheme.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SizedBox(
                                    child: controller.modeRecentJobList.value
                                                .data![index].is_saved ==
                                            false
                                        ? InkWell(
                                            onTap: () {
                                              setState(() {
                                                savedJobsRepo(
                                                        job_id: int.parse(
                                                            controller
                                                                .modeRecentJobList
                                                                .value
                                                                .data![index]
                                                                .id
                                                                .toString()),
                                                        context: context)
                                                    .then((value) {
                                                  if (value.status == true) {}
                                                  showToast(
                                                      value.message.toString());
                                                  controller.getDataRecentJob();
                                                });
                                              });
                                            },
                                            child: Icon(
                                              Icons.favorite_border,
                                              size: 22,
                                              color: AppTheme.primaryColor,
                                            ))
                                        : InkWell(
                                            onTap: () {
                                              setState(() {
                                                removeSavedJobsRepo(
                                                        job_id: int.parse(
                                                            controller
                                                                .modeRecentJobList
                                                                .value
                                                                .data![index]
                                                                .id
                                                                .toString()),
                                                        context: context)
                                                    .then((value) {
                                                  if (value.status == true) {}
                                                  showToast(
                                                      value.message.toString());
                                                  controller.getDataRecentJob();
                                                });
                                              });
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              size: 22,
                                              color: AppTheme.primaryColor,
                                            )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              Text(
                                controller
                                    .modeRecentJobList.value.data![index].type
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkBlueText,
                                ),
                              ),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              Text(
                                  controller.modeRecentJobList.value
                                      .data![index].description
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300,
                                      color: AppTheme.greyTextColor),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "\$" +
                                            controller.modeRecentJobList.value
                                                .data![index].price
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkBlueText),
                                      ),
                                      Text(
                                        "Budget",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff6B6B6B)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.modeRecentJobList.value
                                            .data![index].budgetType
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkBlueText),
                                      ),
                                      Text(
                                        "Project type",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff6B6B6B)),
                                      ),
                                    ],
                                  ),

                                  //send proposal button
                                  /* CustomOutlineButton(
                                title: "Send Proposal",
                                backgroundColor: AppTheme.whiteColor,
                                textColor: AppTheme.primaryColor,
                                onPressed: () {
                                  Get.toNamed(MyRouter.jobDetailsScreen,
                                      arguments: [
                                        controller.modeRecentJobList.value
                                            .data![index].id
                                      ]);
                                  print(controller
                                      .modeRecentJobList.value.data![index].id);
                                },
                              ),*/
                                ],
                              ),
                              SizedBox(
                                height: deviceHeight * .01,
                              ),
                              SizedBox(
                                  child: controller.modeRecentJobList.value
                                              .data![index].skills!.length ==
                                          0
                                      ? SizedBox()
                                      : Column(
                                          children: [
                                            const Divider(
                                              color: Color(0xff6D2EF1),
                                            ),
                                            SizedBox(
                                              height: deviceHeight * .01,
                                            ),
                                            SizedBox(
                                              width: deviceWidth,
                                              height: 45.h,
                                              child: ListView.builder(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: controller
                                                      .modeRecentJobList
                                                      .value
                                                      .data![index]
                                                      .skills!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index2) {
                                                    return Container(
                                                        margin: EdgeInsets.only(
                                                            right: 4,
                                                            bottom: 10),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      AppTheme
                                                                          .whiteColor,
                                                                  side:
                                                                      const BorderSide(
                                                                    color: Color(
                                                                        0xff6D2EF1),
                                                                  ),
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius
                                                                              .all(
                                                                    Radius
                                                                        .circular(
                                                                            30),
                                                                  )),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                  ),
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  )),
                                                          onPressed: () {},
                                                          child: Text(
                                                            controller
                                                                .modeRecentJobList
                                                                .value
                                                                .data![index]
                                                                .skills![index2]
                                                                .name
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: AppTheme
                                                                    .primaryColor),
                                                          ),
                                                        )

                                                        /*CustomOutlineButton(
                                                          title: stackButtonsList[index],
                                                          backgroundColor: AppTheme.whiteColor,
                                                          textColor: AppTheme.primaryColor,
                                                          expandedValue: false,
                                                          onPressed: () {},
                                                        ),*/
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
                                          ],
                                        ))
                            ],
                          )),
                    );
                  },
                )
          : controller.status2.value.isError
              ? SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.modeRecentJobList.value.message.toString(),
                        // fontSize: AddSize.font16,
                      ),
                      IconButton(
                          onPressed: () {
                            controller.getData();
                            controller.getDataRecentJob();
                            controller.getDataBestJob();
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
