import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/resources/size.dart';

import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Offer details",
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          profileSection(),
          companyInfoSection(),
          contractInfoSection(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomOutlineButton(
                    title: 'Decline',
                    backgroundColor: AppTheme.whiteColor,
                    onPressed: () {
                      Get.back();
                    },
                    textColor: AppTheme.primaryColor,
                    expandedValue: false,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomOutlineButton(
                    title: 'Accept',
                    backgroundColor: AppTheme.primaryColor,
                    onPressed: () {
                    },
                    textColor: AppTheme.whiteColor,
                    expandedValue: false,
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }

//profile section
  profileSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
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
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                "assets/images/user.svg",
                height: AddSize.size80,
                width: AddSize.size80,
              ),
              Positioned(
                  right: 0,
                  top: 10,
                  child: Icon(
                    Icons.circle,
                    size: 15,
                    color: Colors.green,
                  ))
            ],
          ),
          SizedBox(
            width: AddSize.size20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Deepak Soni",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font18,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppTheme.primaryColor,
                  ),
                  Text(
                    "Jaipur, india",
                    style: TextStyle(
                        color: Color(0xff4D4D4D),
                        fontSize: AddSize.font16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Text(
                "12:22 pm local time",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font14,
                    fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      ),
    );
  }

  //Company information

  companyInfoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
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
        children: [
          SvgPicture.asset("assets/icon/company.svg"),
          SizedBox(
            width: AddSize.size15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Associated with an agency",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "www.deepaksoni.com",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font14,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }

//contract information
  contractInfoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
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
        children: [
          Text(
            "Contract Terms",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font18,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size10,
          ),

          RichText(text: TextSpan(
            text: "Unify payment protection.",
            style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
            children: [
              TextSpan(
                text:  " only pay for the work you authorize.",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w500),
              )
            ]
          )),
          SizedBox(
            height: AddSize.size20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment option:",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Hourly",
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: AddSize.size15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pay by the hour:",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "\$50.00/per hour",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: AddSize.size15,
          ),
          Text(
            "Weekly Limit",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
          ),
          Text(
            "Setting a weekly limit is a great way to help ensure you stay on budget",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: AddSize.size15,
          ),
          Text(
            "40 hrs /week",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
          ),
          Text(
            "\$200.00 max/week",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font14,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start Date:",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "20-12-2022",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
