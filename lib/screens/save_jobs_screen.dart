import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../widgets/custom_appbar.dart';
import '../controller/saved_job_controller.dart';
import '../repository/job_module/remove_saved_jobs.dart';
import '../repository/job_module/saved_jobs_repository.dart';
import '../resources/size.dart';
import '../routers/my_router.dart';
import '../utils/api_contant.dart';
import '../widgets/appDrawer.dart';
import '../widgets/common_outline_button.dart';

class SaveJobsScreen extends StatefulWidget {
  const SaveJobsScreen({Key? key}) : super(key: key);

  @override
  State<SaveJobsScreen> createState() => _SaveJobsScreenState();
}

class _SaveJobsScreenState extends State<SaveJobsScreen> {
  final controller = Get.put(SavedJobController());

  @override
  void initState() {
    super.initState();
  }



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
          titleText: "Save Jobs",
        ),
      ),
      drawer: AppDrawerScreen(),
      body: Obx(() {
        return controller.status.value.isSuccess
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 10, right: 10, left: 10),
                    child: controller.model.value.data!.length == 0
                        ? Center(
                            child: Text("No data found",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkBlueText,
                                )))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.model.value.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {},
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
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                controller.model.value
                                                    .data![index].name
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.pinkText,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              child:  controller.model.value
                                                  .data![index].isSaved == false
                                                  ? InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          savedJobsRepo(
                                                                  job_id: int.parse(controller.model.value.data![index].id.toString()),
                                                                  context: context)
                                                              .then((value) {
                                                            if (value.status == true) {

                                                            }
                                                            showToast(value
                                                                .message
                                                                .toString());
                                                            controller.getData();
                                                          });
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.favorite_border,
                                                        size: 22,
                                                        color: AppTheme
                                                            .primaryColor,
                                                      ))
                                                  : InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          removeSavedJobsRepo(
                                                                  job_id: int.parse(
                                                                      controller
                                                                          .model
                                                                          .value
                                                                          .data![
                                                                              index]
                                                                          .id
                                                                          .toString()),
                                                                  context:
                                                                      context)
                                                              .then((value) {
                                                            if (value.status ==
                                                                true) {
                                                              controller
                                                                  .getData();
                                                            }
                                                            showToast(value.message.toString());
                                                            controller.getData();
                                                          });
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.favorite,
                                                        size: 22,
                                                        color: AppTheme
                                                            .primaryColor,
                                                      )),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: deviceHeight * .01,
                                        ),
                                        Text(
                                          controller
                                              .model.value.data![index].type
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
                                          controller.model.value.data![index]
                                              .description
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w300,
                                            color: AppTheme.greyTextColor,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
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
                                                  "\$" +
                                                      controller.model.value
                                                          .data![index].price
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
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
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                      controller.model.value
                                                          .data![index].budgetType
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: AppTheme
                                                          .darkBlueText),
                                                ),
                                                Text(
                                                  "Project type",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: const Color(
                                                          0xff6B6B6B)),
                                                ),
                                              ],
                                            ),
                                            /*CustomOutlineButton(
                                                title: "Send Proposal",
                                                backgroundColor:
                                                    AppTheme.whiteColor,
                                                textColor:
                                                    AppTheme.primaryColor,
                                                onPressed: () {
                                                  Get.toNamed(
                                                      MyRouter.jobDetailsScreen,
                                                      arguments: [
                                                        controller.model.value
                                                            .data![index].id,
                                                      ]);
                                                  print(controller.model.value
                                                      .data![index].id);
                                                }),*/
                                          ],
                                        ),
                                        SizedBox(
                                          height: deviceHeight * .01,
                                        ),
                                        SizedBox(
                                          child:
                                              controller
                                                          .model
                                                          .value
                                                          .data![index]
                                                          .skills!
                                                          .length ==
                                                      0
                                                  ? SizedBox()
                                                  : Column(
                                                      children: [
                                                        const Divider(
                                                          color:
                                                              Color(0xff6D2EF1),
                                                        ),
                                                        SizedBox(
                                                          height: deviceHeight *
                                                              .01,
                                                        ),
                                                        SizedBox(
                                                          width: deviceWidth,
                                                          height: 45.h,
                                                          child:
                                                              ListView.builder(
                                                                  physics:
                                                                      BouncingScrollPhysics(),
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemCount: controller
                                                                      .model
                                                                      .value
                                                                      .data![
                                                                          index]
                                                                      .skills!
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index2) {
                                                                    return Container(
                                                                        margin: EdgeInsets.only(
                                                                            right:
                                                                                4,
                                                                            bottom:
                                                                                10),
                                                                        child:
                                                                            ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                              backgroundColor: AppTheme.whiteColor,
                                                                              side: const BorderSide(
                                                                                color: Color(0xff6D2EF1),
                                                                              ),
                                                                              shape: const RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.all(
                                                                                Radius.circular(30),
                                                                              )),
                                                                              padding: EdgeInsets.symmetric(
                                                                                horizontal: 20,
                                                                              ),
                                                                              textStyle: const TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                              )),
                                                                          onPressed:
                                                                              () {},
                                                                          child:
                                                                              Text(
                                                                            controller.model.value.data![index].skills![index2].name.toString(),
                                                                            style:
                                                                                TextStyle(color: AppTheme.primaryColor),
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
                          )),
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
                : Center(
                    child: CircularProgressIndicator(),
                  );
      }),
    );
  }
}
