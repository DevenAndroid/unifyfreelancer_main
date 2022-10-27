import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app_theme.dart';
import '../routers/my_router.dart';

class AppDrawerScreen extends StatefulWidget {
  const AppDrawerScreen({Key? key}) : super(key: key);

  @override
  State<AppDrawerScreen> createState() => _AppDrawerScreenState();
}

class _AppDrawerScreenState extends State<AppDrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
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
                  Row(
                    children: [
                      Card(
                        elevation: 2,
                        margin: const EdgeInsets.all(7),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                              color: AppTheme.blackColor,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80"),
                                  fit: BoxFit.cover)),
                          height: 35.h,
                          width: 35.w,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jonny Smith",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.whiteColor),
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
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
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
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor.withOpacity(.15)),
              child: Icon(
                Icons.person,
                color: AppTheme.primaryColor,
              ),
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor),
            ),
            onTap: () => Get.toNamed(MyRouter.profileScreen),
          ),
          const Divider(
            color: Color(0xff6D2EF1),
          ),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor.withOpacity(.15)),
              child: Icon(
                Icons.pie_chart,
                color: AppTheme.primaryColor,
              ),
            ),
            title: Text(
              'Reports',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor),
            ),
            onTap: () => Get.toNamed(MyRouter.reportsScreen),
          ),
          const Divider(
            color: Color(0xff6D2EF1),
          ),
          ListTile(
            leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryColor.withOpacity(.15)),
                child: SvgPicture.asset(
                  "assets/icon/badge.svg",
                  fit: BoxFit.cover,
                  height: 20,
                  width: 20,
                )),
            title: Text(
              'Unify Qualifications',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor),
            ),
            onTap: () => Get.toNamed(MyRouter.unifyQualificationsScreen),
          ),
          const Divider(
            color: Color(0xff6D2EF1),
          ),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor.withOpacity(.15)),
              child: Icon(
                Icons.settings,
                color: AppTheme.primaryColor,
              ),
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor),
            ),
            onTap: () => Get.toNamed(MyRouter.settingsScreen),
          ),
          const Divider(
            color: Color(0xff6D2EF1),
          ),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryColor.withOpacity(.15)),
              child: Icon(
                Icons.help,
                color: AppTheme.primaryColor,
              ),
            ),
            title: Text(
              'Help & Support',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor),
            ),
            onTap: () => Get.toNamed(MyRouter.helpAndSupportScreen),
          ),
          const Divider(
            color: Color(0xff6D2EF1),
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
                SharedPreferences pref = await SharedPreferences.getInstance();
                await pref.clear();
                Get.offAllNamed(MyRouter.loginScreen);
                pref.setBool("shownIntro", true);
              }),
        ],
      ),
    );
  }
}
