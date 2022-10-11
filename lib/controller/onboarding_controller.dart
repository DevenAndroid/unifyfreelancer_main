import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/userflow/onboarding_screen.dart';
import '../models/onboarding_content_model.dart';
import '../resources/size.dart';


class OnBoardingController extends GetxController{

  PageController pageController = PageController();

  RxList contents = [
    UnbordingContent(
        image: 'assets/images/onBoarding_01.png',
        title: "Never miss an opportunity",
        discription: "Based out of Southern California, "
            "our Security Consultants develop security strategies, "
            "solutions and recommendations, not just for the "
            "short term."),
    UnbordingContent(
        image: 'assets/images/onBoarding_02.png',
        title: "Find interesting\n project and",
        discription: "Based out of Southern California, "
            "our Security Consultants develop security strategies, "
            "solutions and recommendations, not just for the "
            "short term."),
    UnbordingContent(
        image: 'assets/images/onBoarding_03.png',
        title: "Collabarate on the go",
        discription: "Based out of Southern California, "
            "our Security Consultants develop security strategies, "
            "solutions and recommendations, not just for the "
            "short term."),
  ].obs;


  RxInt currentIndex = 0.obs;
  RxBool currentIndex1 = false.obs;
  RxDouble fontSize = 2.0.obs;

  RxDouble containerWidth = (AddSize.size30*2).obs;

  @override
  void onInit() {
    super.onInit();

    double value1 = 0;
    double value132 = 0;
    pageController.addListener(() {
      if (pageController.page!.toDouble() > 1.0) {
        currentIndex1.value = true;
        var value2 = pageController.page!.toDouble() - 1;
        value1 = AddSize.size30*2 * value2 * 3;
        value132 = value2 * 3;
        containerWidth.value = AddSize.size30*2 + value1;
        fontSize.value = 6 * value132 > 1 ? 6 * value132 : 1;
      }
      else {
        currentIndex1.value = false;
      }
    });
  }

}