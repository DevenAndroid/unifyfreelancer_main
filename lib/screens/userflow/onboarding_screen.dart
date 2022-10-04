import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../routers/my_router.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  bool currentIndex1 = false;
  PageController pageController = PageController();
  double fontSize = 2;

  @override
  void initState() {
    super.initState();
    double value1 = 0;
    double value132 = 0;
    pageController.addListener(() {
      if (pageController.page!.toDouble() > 1.0) {
        currentIndex1 = true;
        var value2 = pageController.page!.toDouble() - 1;
        value1 = 50 * value2 * 3;
        value132 = value2 * 3;
        containerWidth = 50 + value1;
        fontSize = 6 * value132;
        // print(containerWidth);
        // print(value1);
      } else {
        currentIndex1 = false;
      }
      setState(() {});
    });
  }

  double containerWidth = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(MyRouter.loginScreen),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff707070).withOpacity(.800)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: PageView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: contents.length,
                          onPageChanged: (int index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          itemBuilder: (_, i) {
                            return Image.asset(
                              contents[currentIndex].image.toString(),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                              fit: BoxFit.cover,
                            );
                          }),
                    ),
                  ),
                  Container(
                    height: 174,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            contents[currentIndex].title.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            contents[currentIndex].description.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: AppTheme.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        pageController.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.ease);
                      },
                      child: Container(
                        height: 50,
                        width: containerWidth,
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(30),
                          color: AppTheme.primaryColor,
                        ),
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        // margin: EdgeInsets.all(30),
                        //width: double.infinity,
                        child: currentIndex1 == false
                            ? const Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                                size: 26,
                              )
                            : InkWell(
                                onTap: () {
                                  Get.toNamed(MyRouter.signUpScreen);
                                },
                                child: FittedBox(
                                  child: Text(
                                    "Get Started",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 6,
      width: currentIndex == index ? 28 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? AppTheme.primaryColor
            : Colors.grey.shade300,
      ),
    );
  }
}

class UnBordingContent {
  String? image;
  String? title;
  String? description;

  UnBordingContent({this.image, this.title, this.description});
}

List<UnBordingContent> contents = [
  UnBordingContent(
      image: 'assets/images/onBoarding_01.png',
      title: "Never miss an opportunity",
      description: "Based out of Southern California, "
          "our Security Consultants develop security strategies, "
          "solutions and recommendations, not just for the "
          "short term."),
  UnBordingContent(
      image: 'assets/images/onBoarding_02.png',
      title: "Find interesting project and \n submit proposals ",
      description: "Based out of Southern California, "
          "our Security Consultants develop security strategies, "
          "solutions and recommendations, not just for the "
          "short term."),
  UnBordingContent(
      image: 'assets/images/onBoarding_03.png',
      title: "Collabarate on the go",
      description: "Based out of Southern California, "
          "our Security Consultants develop security strategies, "
          "solutions and recommendations, not just for the "
          "short term."),
];
