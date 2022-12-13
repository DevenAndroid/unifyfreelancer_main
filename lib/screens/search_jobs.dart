import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../controller/search_controller.dart';
import '../repository/job_module/dislike_job_repository.dart';
import '../repository/job_module/remove_saved_jobs.dart';
import '../repository/job_module/saved_jobs_repository.dart';
import '../resources/app_theme.dart';
import '../routers/my_router.dart';
import '../utils/api_contant.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/error_widget.dart';
import '../widgets/progress_indicator.dart';

class SearchJobScreen extends StatefulWidget {
  const SearchJobScreen({Key? key}) : super(key: key);

  @override
  State<SearchJobScreen> createState() => _SearchJobScreenState();
}

class _SearchJobScreenState extends State<SearchJobScreen> {
  final controller = Get.put(SearchJobListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Search Jobs",
          )),
      body: Obx(() {
        return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(

                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
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
                            controller: controller.searchController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: AppTheme.textColor, fontSize: 14),
                                filled: true,
                                fillColor: Colors.white24,
                                hintText: 'Search for job',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    controller.getData();
                                    controller.modelForPagination.clear();
                                  },
                                  child: Container(
                                      margin:
                                          const EdgeInsets.symmetric(horizontal: 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/icon/Search.svg',
                                        color: AppTheme.whiteColor,
                                      )),
                                )),
                            onFieldSubmitted: (value) {
                              controller.getData();
                              controller.modelForPagination.clear();

                            },
                          ),
                        ),

                      ),
               /*       InkWell(
                        onTap: (){
                          showFilterButtonSheet(context: context, titleText: "Filters", widgets: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                            ],
                          ));
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.all(10),
                            decoration:  BoxDecoration(
                              color: AppTheme.whiteColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppTheme.primaryColor)
                            ),
                            child: SvgPicture.asset(
                              'assets/icon/fillter.svg',
                              color: AppTheme.primaryColor,
                            )),
                      )*/
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (controller.status.value.isSuccess)
                    jobsList(),
                  if (controller.status.value.isError)
                    CommonErrorWidget(
                      errorText: controller.model.value.message.toString(),
                      onTap: () {
                        controller.getData();
                      },
                    ),
                  if (controller.status.value.isEmpty)
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        CommonProgressIndicator(),
                      ],
                    )
                ]));
      }),
    );
  }

  jobsList() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return  Obx(() {
      return /*controller.modelForPagination.length == 0
          ? Center(
          child: Text("No data found",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkBlueText,
              )))
          :*/ Expanded(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.modelForPagination.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(MyRouter.jobDetailsScreen, arguments: [
                        controller.modelForPagination[index].id,
                      ]);
                      print(controller.modelForPagination[index].id);
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
                                      controller.modelForPagination[index].name
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
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const Divider(
                                              color: Color(0xff6D2EF1),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .dislikeReasons
                                                    .value.data!.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                          dislikeJobRepo(
                                                              job_id: controller.modelForPagination[index].id.toString(),
                                                              reason_id: controller.dislikeReasons.value.data![
                                                              index].id.toString(),
                                                              context: context).then((value) {
                                                            print("remove job response::::" +
                                                                value.message.toString());
                                                            if (value.status == true) {}
                                                            showToast(value.message.toString());
                                                            controller.modelForPagination.removeWhere((element) => element.id == controller.modelForPagination[index].id );
                                                          });
                                                        },
                                                        child: Text(
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
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      )
                                                    ],
                                                  );
                                                })
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
                                  child: controller.modelForPagination[index].isSaved == false
                                      ? InkWell(
                                      onTap: () {
                                        savedJobsRepo(
                                            job_id: int.parse(controller
                                                .modelForPagination
                                            [index]
                                                .id
                                                .toString()),
                                            context: context)
                                            .then((value) {
                                          if (value.status == true) {}
                                          controller.getData();
                                          showToast(value.message.toString());
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
                                            job_id: int.parse(controller
                                                .modelForPagination
                                            [index]
                                                .id
                                                .toString()),
                                            context: context)
                                            .then((value) {
                                          if (value.status == true) {}
                                          controller.getData();
                                          showToast(value.message.toString());
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
                              controller.modelForPagination[index].type.toString(),
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
                                controller.modelForPagination[index].description
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\$" +
                                          controller
                                              .modelForPagination[index].price
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller
                                          .modelForPagination[index].budgetType
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
                                                    .JobListData![index].id,
                                              ]);
                                          print(controller.modelJobList.value
                                              .JobListData![index].id);
                                        }),*/
                              ],
                            ),
                            SizedBox(
                              height: deviceHeight * .01,
                            ),
                            SizedBox(
                              child: controller.modelForPagination[index].skills!
                                  .length ==
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
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller.modelForPagination[index].skills!.length,
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
                                                          Radius.circular(
                                                              30),
                                                        )),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                      horizontal: 20,
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
                                                      .modelForPagination[index]
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
              ),
              if(controller.loadMore.value == true)
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomOutlineButton(title: "Load more", backgroundColor: AppTheme.primaryColor, textColor: AppTheme.whiteColor,onPressed: (){
                    controller.getData();
                    controller.page.value++;
                  },
                    expandedValue: true,),
                )
            ],
          ),
        ),
      );
    });
  }
}
