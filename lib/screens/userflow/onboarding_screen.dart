import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/onboarding_controller.dart';
import '../../resources/app_theme.dart';
import '../../routers/my_router.dart';
import '../../size.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    log("message");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: AddSize.size30 * 2),
                      height: AddSize.screenHeight * 0.5,
                      child: PageView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: controller.pageController,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.contents.length,
                          onPageChanged: (int index) {
                            // setState(() {
                            controller.currentIndex.value = index;
                            // });
                          },
                          itemBuilder: (_, i) {
                            return Image.asset(
                              controller
                                  .contents[controller.currentIndex.value].image
                                  .toString(),
                              width: AddSize.screenWidth,
                              height: AddSize.screenHeight * 0.4,
                              fit: BoxFit.contain,
                            );
                          }),
                    ),
                    Positioned(
                        top: AddSize.size50,
                        left: AddSize.padding16,
                        child: controller.currentIndex.value != 2
                            ? const Text("Skip")
                            : const SizedBox())
                  ],
                ),
                Container(
                  height: AddSize.screenHeight * .5 - AddSize.size30 * 2,
                  width: AddSize.screenWidth,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: AddSize.padding20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.contents.length,
                          (index) => buildDot(index, context),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(),
                            FittedBox(
                              child: Text(
                                controller
                                    .contents[controller.currentIndex.value]
                                    .title
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AddSize.font24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: AddSize.size25),
                            Text(
                              controller.contents[controller.currentIndex.value]
                                  .discription
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.20,
                                fontWeight: FontWeight.w400,
                                fontSize: AddSize.font16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: AddSize.size40),
                            InkWell(
                              onTap: () {
                                if (controller.containerWidth.value <
                                    AddSize.size80) {
                                  controller.pageController.nextPage(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.ease);
                                }
                              },
                              child: Container(
                                height: AddSize.size30 * 2,
                                width: controller.containerWidth.value,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppTheme.primaryColor,
                                ),
                                padding: const EdgeInsets.all(5),
                                alignment: Alignment.center,
                                child: controller.currentIndex1.value == false
                                    ? const Icon(
                                        Icons.arrow_forward_outlined,
                                        color: Colors.white,
                                        size: 26,
                                      )
                                    : InkWell(
                                        onTap: () {
                                          Get.toNamed(MyRouter.loginScreen);
                                        },
                                        child: FittedBox(
                                          child: Text(
                                            "Get Started",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    controller.fontSize.value,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            Flexible(
                                child: SizedBox(height: AddSize.size30 * 2)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: AddSize.size10 * .6,
      width: controller.currentIndex.value == index
          ? AddSize.size30
          : AddSize.size10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: controller.currentIndex.value == index
            ? AppTheme.primaryColor
            : Colors.grey.shade300,
      ),
    );
  }
}
