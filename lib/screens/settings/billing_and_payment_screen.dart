import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../../resources/app_theme.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class BillingAndPaymentScreen extends StatefulWidget {
  const BillingAndPaymentScreen({Key? key}) : super(key: key);

  @override
  State<BillingAndPaymentScreen> createState() =>
      _BillingAndPaymentScreenState();
}

class _BillingAndPaymentScreenState extends State<BillingAndPaymentScreen> {
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
        body: Container(
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
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Manage billing method",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.settingsTextColor),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Add, update, or remove your billing methods",
                style:
                    TextStyle(fontSize: 12, color: AppTheme.settingsTextColor),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomOutlineButton(
                title: "Add a New Billing Method",
                backgroundColor: AppTheme.whiteColor,
                textColor: AppTheme.primaryColor,
                onPressed: () =>
                    Get.toNamed(MyRouter.billingAndPaymentProcessScreen),
                expandedValue: false,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                "Primary",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.settingsTextColor),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Your primary billing method is used for all recurring payments",
                style:
                    TextStyle(fontSize: 12, color: AppTheme.settingsTextColor),
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
                      Icon(
                        Icons.credit_card,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Visa ending in 1234",
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.settingsTextColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.whiteColor,
                            border: Border.all(color: Color(0xff707070))),
                        child: Icon(
                          Icons.edit,
                          color: AppTheme.primaryColor,
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.whiteColor,
                            border: Border.all(color: Color(0xff707070))),
                        child: Icon(
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
        ));
  }
}
