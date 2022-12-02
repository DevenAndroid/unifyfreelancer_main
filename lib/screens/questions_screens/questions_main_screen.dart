import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/profie_screen_controller.dart';
import '../../repository/countrylist_repository.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../routers/my_router.dart';
import 'hourly_charge_question.dart';
import 'page1.dart';
import 'page10.dart';
import 'page2.dart';
import 'page3.dart';
import 'page4.dart';
import 'page5.dart';
import 'page6.dart';
import 'page7.dart';
import 'page8.dart';
import 'profile_preview.dart';
import 'profile_details.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {

  final controller = Get.put(ProfileScreenController());

  @override
  void initState() {
    super.initState();
    controller.pageController.addListener(() {
      controller.currentIndex.value = controller.pageController.page! + 1;
    });
    countryListRepo().then((value) {
      controller.countryList.value = value;
    });
  }
final drawerKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppTheme.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: AppTheme.whiteColor,
        leading: InkWell(
          onTap: () {
           drawerKey.currentState!.openDrawer();
          },
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.all(7),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Obx(() {
              return Container(
                margin: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppTheme.blackColor,
                  shape: BoxShape.circle,
                  /*image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80"),
                          fit: BoxFit.cover)*/),
                height: 25.h,
                width: 25.w,
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(1000),
                  child: controller.status.value.isSuccess ?
                  CachedNetworkImage(
                    imageUrl: controller
                        .model
                        .value
                        .data!
                        .basicInfo!
                        .profileImage.toString(),
                    errorWidget: (_, __, ___) => SizedBox(),
                    placeholder: (_, __) => SizedBox(),
                    fit: BoxFit.cover,
                  )
                      : SizedBox(),
                ),
              );
            }),
          ),
        ),
        title: Text(
          "Create profile",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
              fontSize: AddSize.font20
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(AddSize.size10),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(AddSize.screenWidth, AddSize.size50),
          child: Obx(() {
            return Container(
              height: AddSize.size10,
              decoration: BoxDecoration(
                color: AppTheme.whiteColor,
                borderRadius: BorderRadius.circular(AddSize.size10),
              ),
              padding: EdgeInsets.only(right: AddSize.screenWidth - controller.currentIndex.value / 12 * AddSize.screenWidth),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(AddSize.size10),
                ),
              ),
            );
          }),
        ),
      ),
      drawer: Drawer(
        child: Obx(() {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 120,
                child: DrawerHeader(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Card(
                              elevation: 2,
                              margin: const EdgeInsets.all(7),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: AppTheme.blackColor,
                                  shape: BoxShape.circle,
                                  /* image: DecorationImage(
                                    image: NetworkImage(
                                        controller.model.value.data!.basicInfo!.profileImage ?? ""),
                                    fit: BoxFit.cover)*/
                                ),
                                height: 35.h,
                                width: 35.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: controller.status.value.isSuccess
                                      ? CachedNetworkImage(
                                    imageUrl: controller.model.value.data!
                                        .basicInfo!.profileImage ??
                                        "",
                                    errorWidget: (_, __, ___) => SizedBox(),
                                    placeholder: (_, __) => SizedBox(),
                                    fit: BoxFit.cover,
                                  )
                                      : SizedBox(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.status.value.isSuccess
                                        ? controller.model.value.data!.basicInfo!
                                        .firstName
                                        .toString() +
                                        " " +
                                        controller.model.value.data!
                                            .basicInfo!.lastName
                                            .toString()
                                        : "",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.whiteColor),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "Freelancer",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.whiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            drawerKey.currentState!.closeDrawer();
                          },
                          icon: Icon(
                            Icons.clear,
                            color: AppTheme.whiteColor,
                          ))
                    ],
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xfff2bde2),
                        Color(0xffa39ef5),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height:AddSize.screenHeight*.75,
                  ),
                  ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primaryColor.withOpacity(.15)),
                        child: Icon(
                          Icons.power_settings_new,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor),
                      ),
                      onTap: () async {
                        SharedPreferences pref =
                        await SharedPreferences.getInstance();
                        await pref.clear();
                        Get.offAllNamed(MyRouter.loginScreen);
                        pref.setBool("shownIntro", true);
                      }),

                ],
              )

            ],
          );
        }),
      ),
      body: PageView(
        controller: controller.pageController,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Page1(),
          Page2(),
          Page3(),
          Page4(),
          Page5(),
          Page6(),
          Page7(),
          Page8(),
         // Page9(),
          Page10(),
          HourlyChargeQuestion(),
          ProfileDetails(),
          ProfilePreview(),
        ],
      ),
    );
  }

}
