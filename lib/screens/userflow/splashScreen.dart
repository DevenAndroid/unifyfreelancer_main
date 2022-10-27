import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifyfreelancer/resources/app_assets.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.getString('cookie') != null) {
        print("object" + pref.getString('cookie').toString());
        Get.offAllNamed(MyRouter.bottomNavbar);
      } else {
        if(pref.getBool("shownIntro") == null){
          Get.offAllNamed(MyRouter.onBoardingScreen);
        } else {
          Get.offAllNamed(MyRouter.loginScreen);
        }
      }
    });
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
