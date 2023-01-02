import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifyfreelancer/resources/app_assets.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../../resources/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((event) async {
//      log("Internet is working fine");
      final getConnectionStatus = await InternetConnectionChecker().hasConnection;
      if (!getConnectionStatus) {
        //  showToast('No Internet Connection Available');
        log("No internet access");
        Get.snackbar("No Internet Access", "Please connect with nearby network",
            colorText: AppTheme.whiteColor,
            backgroundColor: AppTheme.primaryColor,
            isDismissible: false,
            duration: const Duration(days: 1000));
      } else {
        log("Internet is working fine");
        Get.closeCurrentSnackbar();
      }
    }
    );
    local();
    Timer(const Duration(seconds: 2), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.getString('cookie') != null) {
        if (kDebugMode) {
          print("object${pref.getString('cookie')}");
        }
        Get.offAllNamed(MyRouter.bottomNavbar);
      } else {
        if (pref.getBool("shownIntro") == null) {
          Get.offAllNamed(MyRouter.onBoardingScreen);
        } else {
          Get.offAllNamed(MyRouter.loginScreen);
        }
      }
    });
  }

  local() async{
    final getConnectionStatus = await InternetConnectionChecker().hasConnection;
    if (!getConnectionStatus) {
      //  showToast('No Internet Connection Available');
      log("No internet access");
      Get.snackbar("No Internet Access", "Please connect with nearby network",
          colorText: AppTheme.whiteColor,
          backgroundColor: AppTheme.primaryColor,
          isDismissible: false,
          duration: const Duration(days: 1000));
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: deviceHeight,
          width: deviceWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.splashBg),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            // height: deviceHeight * 0.20,
            // width: deviceWidth * 0.20,
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/Logo.png",),
            //     fit: BoxFit.fill,
            //   ),
            // ),
            child: Image.asset(
              AppAssets.splashLogo,
            ),
          ),
        ),
      ],
    ));
  }
}
