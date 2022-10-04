import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_theme.dart';
import '../widgets/appDrawer.dart';
import '../widgets/custom_appbar.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Help & Support",
            // onPressedForLeading:,
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 60),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.primaryColor,
              border: Border.all(color: Color(0xff707070))),
          child: Icon(
            Icons.message,
            color: AppTheme.whiteColor,
            size: 25,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Troubleshoot mobile App",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor),
                ),
                Card(
                  elevation: 0.5,
                  margin: EdgeInsets.only(top: 10),
                  color: AppTheme.whiteColor,
                  child: ExpansionTile(
                    iconColor: AppTheme.blackColor,
                    collapsedIconColor: AppTheme.blackColor,
                    title: Text(
                      "Push Notification issues",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.settingsTextColor),
                    ),
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20,right: 40,top: 10,bottom: 10),
                          child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been."
                          ,style: TextStyle(
                              fontSize: 12,color: AppTheme.textColor.withOpacity(.63)),)),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: 0.5,
                  margin: EdgeInsets.only(top: 10),
                  color: AppTheme.whiteColor,
                  child: ExpansionTile(
                    iconColor: AppTheme.blackColor,
                    collapsedIconColor: AppTheme.blackColor,
                    title: Text(
                      "Login issues",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.settingsTextColor),
                    ),
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20,right: 40,top: 10,bottom: 10),
                          child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been.",style: TextStyle(
                              fontSize: 12,color: AppTheme.textColor.withOpacity(.63)),)),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: 0.5,
                  margin: EdgeInsets.only(top: 10),
                  color: AppTheme.whiteColor,
                  child: ExpansionTile(
                    iconColor: AppTheme.blackColor,
                    collapsedIconColor: AppTheme.blackColor,
                    title: Text(
                      "Loading  issues",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.settingsTextColor),
                    ),
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20,right: 40,top: 10,bottom: 10),
                          child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been.",style: TextStyle(
                              fontSize: 12,color: AppTheme.textColor.withOpacity(.63)),)),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: 0.5,
                  margin: EdgeInsets.only(top: 10),
                  color: AppTheme.whiteColor,
                  child: ExpansionTile(
                    iconColor: AppTheme.blackColor,
                    collapsedIconColor: AppTheme.blackColor,
                    title: Text(
                      "Payment Problem",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.settingsTextColor),
                    ),
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20,right: 40,top: 10,bottom: 10),
                          child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been.",style: TextStyle(
                              fontSize: 12,color: AppTheme.textColor.withOpacity(.63)),)),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: 0.5,
                  margin: EdgeInsets.only(top: 10),
                  color: AppTheme.whiteColor,
                  child: ExpansionTile(
                    iconColor: AppTheme.blackColor,
                    collapsedIconColor: AppTheme.blackColor,
                    title: Text(
                      "Billing  issues",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.settingsTextColor),
                    ),
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20,right: 40,top: 10,bottom: 10),
                          child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been.",style: TextStyle(
                              fontSize: 12,color: AppTheme.textColor.withOpacity(.63)),)),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
