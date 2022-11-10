import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../controller/profie_screen_controller.dart';

class CustomAppbar extends StatefulWidget {
  final bool? isProfileImage;
  final bool? isLikeButton;
  final String? titleText;

  const CustomAppbar({
    super.key,
    required this.titleText,
    this.isProfileImage = false,
    this.isLikeButton = false,
  });

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {

  final controller = Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 1,
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: AppTheme.whiteColor,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark,
        // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      backgroundColor: AppTheme.whiteColor,
      leading: widget.isProfileImage == true
          ? InkWell(
        onTap: () {
          Scaffold.of(context).openDrawer();
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
                child: controller
                    .status.value.isSuccess ? CachedNetworkImage(
                  imageUrl: controller
                      .model
                      .value
                      .data!
                      .basicInfo!
                      .profileImage ??
                      "",
                  errorWidget: (_, __, ___) => SizedBox(),
                  placeholder: (_, __) => SizedBox(),
                  fit: BoxFit.cover,
                )
                    : SizedBox(),
              ),
            );
          }),
        ),
      )
          : IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff756C87),
          )),
      title: Text(
        widget.titleText!,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.textColor,
            fontSize: 20.sp),
      ),
      actions: [
        widget.isLikeButton == true
            ? Container(
          margin: const EdgeInsets.all(7),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.borderColor),
            shape: BoxShape.circle,
            color: AppTheme.whiteColor,
            /*boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]*/
          ),
          child: InkWell(
            onTap: () => Get.toNamed(MyRouter.saveJobsScreen),
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                height: 20.h,
                width: 20.w,
                child: SvgPicture.asset("assets/icon/heart.svg",color: AppTheme.primaryColor,)),
          ),
        )
            : const SizedBox()
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
    );
  }
}
