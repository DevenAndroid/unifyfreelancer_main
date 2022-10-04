import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/app_theme.dart';
import '../widgets/appdrawer.dart';

import '../widgets/custom_appbar.dart';

class UnifyQualificationsScreen extends StatefulWidget {
  const UnifyQualificationsScreen({Key? key}) : super(key: key);

  @override
  State<UnifyQualificationsScreen> createState() =>
      _UnifyQualificationsScreenState();
}

class _UnifyQualificationsScreenState extends State<UnifyQualificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Unify Qualifications",
          // onPressedForLeading:,
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(10),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Card(
                margin: EdgeInsets.only(top: 10),
                color: AppTheme.whiteColor,
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.primaryColor
                                  .withOpacity(.15)),
                          child: SvgPicture.asset(
                            "assets/icon/certificate.svg",
                          )
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wordpress Web design Course",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff1F1F1F)),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Aug 28, 2022",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff6B6B6B)),
                          )
                        ],
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
