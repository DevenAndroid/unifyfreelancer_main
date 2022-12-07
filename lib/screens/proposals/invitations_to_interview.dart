import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class InvitationsToInterview extends StatefulWidget {
  const InvitationsToInterview({Key? key}) : super(key: key);

  @override
  State<InvitationsToInterview> createState() => _InvitationsToInterviewState();
}

class _InvitationsToInterviewState extends State<InvitationsToInterview> {
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
              contentSection(),
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


//contract information
  contentSection() {
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
            "Mobile App And Website design",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font24,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size10,
          ),

          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              CustomOutlineButton(title: "Backend Developer", backgroundColor: AppTheme.whiteColor,textColor: AppTheme.primaryColor,onPressed: (){},),
              SizedBox(
                width: AddSize.size10,
              ),
              Text(
                "Posted dec 6, 2022",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: AddSize.size20,
          ),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font14,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: AddSize.size20,
          ),
          Text(
            "View job posting",
            style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Text(
            "About the client",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Row(
            children: [
              Icon(Icons.verified,size: 18,color: AppTheme.primaryColor,),
              SizedBox(
                width: AddSize.size5,
              ),
              Text(
                "payment method verified",
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
          Text(
            "Location",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font20,
                fontWeight: FontWeight.w600),
          ),

          SizedBox(
            height: AddSize.size5,
          ),
          Text(
            "America",
            style: TextStyle(
                color: Color(0xff403557),
                fontSize: AddSize.font18,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size5,
          ),
          Text(
            "12:22 pm local time",
            style: TextStyle(
                color: Color(0xff403557),
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w500),
          ),

        ],
      ),
    );
  }
}