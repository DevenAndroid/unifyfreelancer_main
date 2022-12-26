import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/size.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../../resources/app_theme.dart';
import '../../widgets/custom_appbar.dart';

class WorkInProgressScreen extends StatefulWidget {
  const WorkInProgressScreen({Key? key}) : super(key: key);

  @override
  State<WorkInProgressScreen> createState() => _WorkInProgressScreenState();
}

class _WorkInProgressScreenState extends State<WorkInProgressScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  Get.toNamed(MyRouter.reportsScreen);
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
              Text(
                "Timesheet for Dec 12-18 (this week) in progress",
                style: TextStyle(
                    fontSize: AddSize.size18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textColor),
              ),
              SizedBox(
                height: AddSize.size10,
              ),
              Text(
                "When will I get paid?",
                style: TextStyle(
                    fontSize: AddSize.size16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                width: double.infinity,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xffF9F9F9)
                ),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: Text(
                      "Job",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textColor),
                    ),),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Hours",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor),
                      ),),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Amount",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor),
                      ),)
                  ],
                ),
              ),
              SizedBox(
                height: AddSize.size10,
              ),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jolly Smith",
                          style: TextStyle(
                              fontSize: AddSize.size18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                        SizedBox(
                          height: AddSize.size10*.5,
                        ),
                        Text(
                          "WordPress Developer...",
                          style: TextStyle(
                              fontSize: AddSize.size18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                      ],
                    ),),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jolly Smith",
                          style: TextStyle(
                              fontSize: AddSize.size18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                        SizedBox(
                          height: AddSize.size10*.5,
                        ),
                        Text(
                          "WordPress Developer...",
                          style: TextStyle(
                              fontSize: AddSize.size18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                      ],
                    ),),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jolly Smith",
                          style: TextStyle(
                              fontSize: AddSize.size18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                        SizedBox(
                          height: AddSize.size10*.5,
                        ),
                        Text(
                          "WordPress Developer...",
                          style: TextStyle(
                              fontSize: AddSize.size18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),
                      ],
                    ),),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
