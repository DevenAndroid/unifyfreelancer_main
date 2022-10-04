import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../resources/app_theme.dart';
import '../routers/my_router.dart';
import '../widgets/appDrawer.dart';
import '../widgets/custom_appbar.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /* appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: true,
            isProfileImage: true,
            titleText: "Messages",
          ),
        ),
        drawer: AppDrawerScreen(),*/
        body: ListView.builder(
            padding: EdgeInsets.only(top: 10, bottom: 60),
            shrinkWrap: true,
            itemCount: 10,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return uiMessageList();
            }));
  }

  Widget uiMessageList() {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1520635360276-79f3dbd809f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"))),
              ),
              Positioned(
                  right: 0,
                  left: 45,
                  child: Icon(
                    Icons.circle,
                    color: AppTheme.pinkText,
                    size: 15,
                  ))
            ]),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () => Get.toNamed(MyRouter.chatScreen),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Allen growd",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.greyTextColor2),
                        ),
                        Text(
                          "12:02 PM",
                          style: TextStyle(
                              fontSize: 12, color: AppTheme.greyTextColor2),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Ecommerce website development",
                      style: TextStyle(fontSize: 13, color: Color(0xff2F2643)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "You: Thanku",
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.greyTextColor2),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
