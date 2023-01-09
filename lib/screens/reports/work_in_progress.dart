import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/size.dart';

import '../../controller/reports_controller.dart';
import '../../models/Reports/model_overview.dart';
import '../../resources/app_theme.dart';
import '../../routers/my_router.dart';
import '../../widgets/custom_appbar.dart';

class WorkInProgressScreen extends StatefulWidget {
  const WorkInProgressScreen({Key? key}) : super(key: key);

  @override
  State<WorkInProgressScreen> createState() => _WorkInProgressScreenState();
}

class _WorkInProgressScreenState extends State<WorkInProgressScreen> {

 // final controller = Get.put(ReportsController());
  Rx<ModelOverview> modelOverview = ModelOverview().obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    modelOverview.value.data!.workInProgress = Get.arguments[0];
  }
  @override
  Widget build(BuildContext context) {
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
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InkWell(
                onTap: (){
                  Get.back();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppTheme.primaryColor,
                      size: AddSize.size16,
                    ),
                    Text(
                      "Work in progress",
                      style: TextStyle(
                          fontSize: AddSize.size14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryColor),
                    ),
                  ],
                ),
              ),
          SizedBox(
            height: AddSize.size10,
          ),
          const Text(
            "Timesheet for Dec 12-18 (this week) in progress",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          const Text(
            "When will I get paid?",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xffF9F9F9)),
            child: Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Job",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Text(
                      "Hours",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textColor),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
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
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
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
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: AddSize.padding16),
                            child: const Text(
                              "0.0",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.blackColor),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: AddSize.padding16),
                            child: const Text(
                              "\$0.0",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.blackColor),
                            ),
                          ),
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
          Row(
            children: [
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: AddSize.padding16),
                  child: const Text(
                    "10.50",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.blackColor),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: AddSize.padding16),
                  child: const Text(
                    "\$0.0",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.blackColor),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AddSize.size10 * .5,
          ),
          const Divider(
            color: Color(0xffE2E2E2),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          const Text(
            "Fixed price milestones in progress",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
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
                      "Assigned",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textColor),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Job / Milestone",
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
            physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
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
          SizedBox(
            height: AddSize.size10 * .5,
          ),
          const Divider(
            color: Color(0xffE2E2E2),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          const Text(
            "Note: This report is updated every hour.",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor),
          ),
        ]),
      )),
    );
  }
}
