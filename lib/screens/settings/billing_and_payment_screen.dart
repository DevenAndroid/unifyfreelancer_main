import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/controller/profie_screen_controller.dart';
import 'package:unifyfreelancer/routers/my_router.dart';
import 'package:unifyfreelancer/widgets/error_widget.dart';
import 'package:unifyfreelancer/widgets/progress_indicator.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/add_text.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class BillingAndPaymentScreen extends StatefulWidget {
  const BillingAndPaymentScreen({Key? key}) : super(key: key);

  @override
  State<BillingAndPaymentScreen> createState() =>
      _BillingAndPaymentScreenState();
}

class _BillingAndPaymentScreenState extends State<BillingAndPaymentScreen> {

  final controller = Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Billing & Payment",
            // onPressedForLeading:,
          ),
        ),
        body: Obx(() {
          return controller.status.value.isSuccess ? SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Manage billing method",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.settingsTextColor),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const Text(
                        "Add, update, or remove your billing methods",
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.settingsTextColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomOutlineButton(
                        title: "Add a New Billing Method",
                        backgroundColor: AppTheme.whiteColor,
                        textColor: AppTheme.primaryColor,
                        onPressed: () =>
                            Get.toNamed(
                                MyRouter.billingAndPaymentProcessScreen),
                        expandedValue: false,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const Text(
                        "Primary",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.settingsTextColor),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const Text(
                        "Your primary billing method is used for all recurring payments",
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.settingsTextColor),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.credit_card,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              const Text(
                                "Visa ending in 1234",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.settingsTextColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.whiteColor,
                                    border: Border.all(
                                        color: const Color(0xff707070))),
                                child: const Icon(
                                  Icons.edit,
                                  color: AppTheme.primaryColor,
                                  size: 15,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.whiteColor,
                                    border: Border.all(
                                        color: const Color(0xff707070))),
                                child: const Icon(
                                  Icons.delete_forever,
                                  color: AppTheme.primaryColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Subscription",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.settingsTextColor),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const Text(
                                "\$0.00/month",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.settingsTextColor),
                              ),
                            ],
                          ),
                          CustomOutlineButton(
                            title: "  Cancel  ",
                            backgroundColor: AppTheme.whiteColor,
                            textColor: AppTheme.primaryColor,
                            onPressed: () {
                              showDialog(context: context, builder: (context){
                                return Dialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                  child: Padding(
                                    padding: EdgeInsets.all(AddSize.padding10),
                                    child: SizedBox(
                                      width: AddSize.screenHeight,
                                      // height: 270.0,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: AddSize.size10),
                                          const Text(
                                            "Cancel Your Subscriptions",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.settingsTextColor),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: AddSize.size15),
                                          const Text(
                                            "Are you sure you want to cancel your subscription plan",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppTheme.settingsTextColor),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: AddSize.size10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                        AppTheme.whiteColor,
                                                        side: const BorderSide(
                                                          color: Color(0xff6D2EF1),
                                                        ),
                                                        shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(30),
                                                            )),
                                                        padding: const EdgeInsets.symmetric(
                                                          horizontal: 20,
                                                        ),
                                                        textStyle: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        )),
                                                    onPressed: () {},
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: AppTheme.primaryColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: ElevatedButton(

                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                        AppTheme.primaryColor,
                                                        side: const BorderSide(
                                                          color: Color(0xff6D2EF1),
                                                        ),
                                                        shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(30),
                                                            )),
                                                        padding: const EdgeInsets.symmetric(horizontal: 20,
                                                        ),
                                                        textStyle: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        )),
                                                    onPressed: () {},
                                                    child: const Text(
                                                      "Submit",
                                                      style: TextStyle(
                                                          color: AppTheme.whiteColor),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                            expandedValue: false,
                          ),
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
                      InkWell(
                        onTap: () {
                          Get.toNamed(MyRouter.subscriptionScreen);
                        },
                        child: const Text(
                          "Change subscription",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ) : controller.status.value.isError ?
          CommonErrorWidget(errorText: controller.model.value.message.toString(), onTap: (){
            controller.getData();
          }) : const CommonProgressIndicator();
        }));
  }
}
