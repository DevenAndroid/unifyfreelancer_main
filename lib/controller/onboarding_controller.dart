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
        discription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
    UnbordingContent(
        image: 'assets/images/onBoarding_02.png',
        title: "Find interesting projects and submit proposals",
        discription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
    UnbordingContent(
        image: 'assets/images/onBoarding_03.png',
        title: "Collaborate on the go",
        discription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
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