import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/app_theme.dart';
import '../../widgets/appDrawer.dart';
import '../../widgets/custom_appbar.dart';

class PasswordAndSecurityScreen extends StatefulWidget {
  const PasswordAndSecurityScreen({Key? key}) : super(key: key);

  @override
  State<PasswordAndSecurityScreen> createState() =>
      _PasswordAndSecurityScreenState();

}


class _PasswordAndSecurityScreenState extends State<PasswordAndSecurityScreen> {
  bool isSwitched = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  var textValue = 'Switch is OFF';

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Password & Security",
            // onPressedForLeading:,
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textColor),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.whiteColor,
                                  border: Border.all(color: Color(0xff707070))),
                              child: Icon(
                                Icons.edit,
                                color: AppTheme.primaryColor,
                                size: 15,
                              ),
                            ),
                          ]),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 15),
                        width: deviceWidth,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.whiteColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20),
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.primaryColor,
                                  border: Border.all(color: Color(0xff707070))),
                              child: Icon(
                                Icons.check,
                                color: AppTheme.whiteColor,
                                size: 15,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Password has been set",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.greyTextColor2),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Choose a strong, unique password that’s at least 8 characters long.",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppTheme.textColor
                                            .withOpacity(.63)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Two-step verification options",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textColor),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.whiteColor,
                                  border: Border.all(color: Color(0xff707070))),
                              child: Icon(
                                Icons.edit,
                                color: AppTheme.primaryColor,
                                size: 15,
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Add an extra layer of security to block unauthorized access and protect your account.",
                        style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.textColor.withOpacity(.63)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 15),
                        width: deviceWidth,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppTheme.whiteColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
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
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Authenticator app code",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    AppTheme.settingsTextColor),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Icon(
                                            Icons.help,
                                            color: Color(0xffB9BDC1),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "(Recommended)",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xff545454),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "Enter a code generated by your authenticator app to confirm it’s you.",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Color(0xff545454),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                CupertinoSwitch(
                                  onChanged: (value) {
                                    isSwitched = value;
                                    setState(() {});
                                  },
                                  value: isSwitched,
                                  activeColor: AppTheme.primaryColor,
                                  thumbColor: Color(0xffE2E2E2),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Divider(
                              color: AppTheme.primaryColor.withOpacity(.49),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Mobile app prompt",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    AppTheme.settingsTextColor),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Icon(
                                            Icons.help,
                                            color: Color(0xffB9BDC1),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "Receive a prompt from your mobile app to confirm it’s you.",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Color(0xff545454),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                CupertinoSwitch(
                                  onChanged: (value) {
                                    isSwitched2 = value;
                                    setState(() {});
                                  },
                                  value: isSwitched2,
                                  activeColor: AppTheme.primaryColor,
                                  thumbColor: Color(0xffE2E2E2),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Divider(
                              color: AppTheme.primaryColor.withOpacity(.49),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Text message",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    AppTheme.settingsTextColor),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Icon(
                                            Icons.help,
                                            color: Color(0xffB9BDC1),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "Receive a six digit code by text message to confirm it’s you.",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Color(0xff545454),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                CupertinoSwitch(
                                  onChanged: (value) {
                                    isSwitched3 = value;
                                    setState(() {});
                                  },
                                  value: isSwitched3,
                                  activeColor: AppTheme.primaryColor,
                                  thumbColor: Color(0xffE2E2E2),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Divider(
                              color: AppTheme.primaryColor.withOpacity(.49),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Security question",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color:
                                      AppTheme.settingsTextColor),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Icon(
                                  Icons.help,
                                  color: Color(0xffB9BDC1),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 20,top: 5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.primaryColor,
                                      border: Border.all(color: Color(0xff707070))),
                                  child: Icon(
                                    Icons.check,
                                    color: AppTheme.whiteColor,
                                    size: 15,
                                  ),
                                ),
                                Expanded(child: Column(children: [
                                  Row(

                                      children: [
                                        Text(
                                          "Enabled",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppTheme.settingsTextColor),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppTheme.whiteColor,
                                              border: Border.all(color: Color(0xff707070))),
                                          child: Icon(
                                            Icons.edit,
                                            color: AppTheme.primaryColor,
                                            size: 15,
                                          ),
                                        ),
                                      ]),
                                  Text(
                                    "Answer a question you choose to confirm it’s you.",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff545454),
                                    ),
                                  )

                                ],))
                              ],
                            )
                          ],
                        ),
                      )
                    ]))));
  }
}
