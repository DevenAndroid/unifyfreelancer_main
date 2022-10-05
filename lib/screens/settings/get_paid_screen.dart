import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../routers/my_router.dart';
import '../../widgets/custom_appbar.dart';



class GetPaidScreen extends StatefulWidget {
  const GetPaidScreen({Key? key}) : super(key: key);

  @override
  State<GetPaidScreen> createState() => _GetPaidScreenState();
}

class _GetPaidScreenState extends State<GetPaidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Get Paid",
            // onPressedForLeading:,
          ),
        ),

        body: Column(
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Balance Due",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.settingsTextColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Your balance is \$0.00",
                        style: TextStyle(
                            fontSize: 13.sp, color: AppTheme.settingsTextColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0, backgroundColor: Color(0xffF8F8F8),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          )),
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () {},
                      child: Text(
                        "Get Pay Now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          color: Color(0xffB9BDC1),
                        ),
                      ))
                ],
              ),
            ),
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
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Details",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.settingsTextColor),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: ()=>Get.toNamed(MyRouter.billingAndPaymentProcessScreen),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.whiteColor,
                              border: Border.all(color: Color(0xff707070))),
                          child: Icon(
                            Icons.add,
                            color: AppTheme.primaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "You have not set up any payment method yet.",
                    style: TextStyle(
                        fontSize: 13, color: AppTheme.settingsTextColor),
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
                  Text(
                    "Tell us how you want to receive your funds. It may take up to 3 days to activate your payment method.",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textColor.withOpacity(.63)),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
