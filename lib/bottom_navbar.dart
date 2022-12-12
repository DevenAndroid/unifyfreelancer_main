import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/Screens/alerts_screen.dart';
import 'package:unifyfreelancer/Screens/contracts_screen.dart';
import 'package:unifyfreelancer/Screens/home_screen.dart';
import 'package:unifyfreelancer/Screens/messages_screen.dart';
import 'package:unifyfreelancer/Screens/proposals_screen.dart';

import 'Controller/bottom_nav_bar_controller.dart';

import 'controller/profie_screen_controller.dart';
import 'controller/proposals_screen_controller.dart';
import 'resources/app_theme.dart';
import 'widgets/appDrawer.dart';
import 'widgets/custom_appbar.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final controller = Get.put(BottomNavBarController());
  final profileController = Get.put(ProfileScreenController());

  FirebaseFirestore dataBase = FirebaseFirestore.instance;

  final pages = [
    const HomeScreen(),
    const ProposalsScreen(),
    const ContractsScreen(),
    const MessagesScreen(),
    const AlertsScreen(),
  ];

  var screenTitle = [
    "Jobs",
    "Proposals",
    "Contracts",
    "Messages",
    "Alerts",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Obx(() {
            return CustomAppbar(
              isLikeButton: true,
              isProfileImage: true,
              titleText: "${screenTitle[controller.pageIndex.value]}",
            );
          }),
        ),
        drawer: AppDrawerScreen(),
        body: pages.elementAt(controller.pageIndex.value),
        extendBody: true,
        // extendBodyBehindAppBar: true,
        backgroundColor: AppTheme.whiteColor,
        bottomNavigationBar: buildMyNavBar(context),
      );
    });
  }

  buildMyNavBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: MaterialButton(
                  padding: EdgeInsets.only(bottom: 10),
                  onPressed: () {
                    controller.updateIndexValue(0);
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      controller.pageIndex.value == 0
                          ? SvgPicture.asset(
                        'assets/icon/Search.svg',
                        color: AppTheme.primaryColor,
                      )
                          : SvgPicture.asset('assets/icon/Search.svg'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Jobs',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: controller.pageIndex.value == 0
                                ? AppTheme.primaryColor
                                : AppTheme.subText),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                child: MaterialButton(
                  padding: EdgeInsets.only(bottom: 10),
                  onPressed: () {
                    controller.updateIndexValue(1);
                    final controllerRefresh = Get.put(ProposalScreenController());
                    controllerRefresh.getData();
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      controller.pageIndex.value == 1
                          ? SvgPicture.asset(
                        'assets/icon/Proposals.svg',
                        color: AppTheme.primaryColor,
                      )
                          : SvgPicture.asset('assets/icon/Proposals.svg'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Proposals',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: controller.pageIndex.value == 1
                                ? AppTheme.primaryColor
                                : AppTheme.subText),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: MaterialButton(
                    padding: EdgeInsets.only(bottom: 10),
                    onPressed: () {
                      controller.updateIndexValue(2);
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        controller.pageIndex.value == 2
                            ? SvgPicture.asset(
                          'assets/icon/Contracts.svg',
                          color: AppTheme.primaryColor,
                        )
                            : SvgPicture.asset('assets/icon/Contracts.svg'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Contracts',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: controller.pageIndex.value == 2
                                  ? AppTheme.primaryColor
                                  : AppTheme.subText),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: MaterialButton(
                  padding: EdgeInsets.only(bottom: 10),
                  onPressed: () {
                    controller.updateIndexValue(3);
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      controller.pageIndex.value == 3
                          ? SvgPicture.asset(
                        'assets/icon/message.svg',
                        color: AppTheme.primaryColor,
                      )
                          : SvgPicture.asset('assets/icon/message.svg'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Messages',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: controller.pageIndex.value == 3
                                ? AppTheme.primaryColor
                                : AppTheme.subText),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                child: MaterialButton(
                  padding: EdgeInsets.only(bottom: 10),
                  onPressed: () {
                    controller.updateIndexValue(4);
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      controller.pageIndex.value == 4
                          ? SvgPicture.asset(
                        'assets/icon/Alerts.svg',
                        color: AppTheme.primaryColor,
                      )
                          : SvgPicture.asset('assets/icon/Alerts.svg'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Alerts',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: controller.pageIndex.value == 4
                                ? AppTheme.primaryColor
                                : AppTheme.subText),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
