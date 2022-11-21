import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class ProfilePreview extends StatelessWidget {
  const ProfilePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12),
        height: AddSize.screenHeight,
        width: AddSize.screenWidth,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AddSize.size10,
              ),
              Text(
                "Preview Profile",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font20),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Looking good, Neha",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkBlueText,
                                fontSize: AddSize.font20),
                          ),
                          Text(
                            "Make any edits you want, then submit your profile. You can make more change after it's live.",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkBlueText,
                                fontSize: AddSize.font14),
                          ),
                          SizedBox(
                            height: AddSize.size10,
                          ),
                          CustomOutlineButton(
                            title: "Submit Profile",
                            backgroundColor: AppTheme.whiteColor,
                            textColor: AppTheme.primaryColor,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: AddSize.size10,
                    ),
                    SvgPicture.asset(
                      "assets/images/like.svg",
                      height: 80,
                      width: 80,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
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
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/images/user.svg",
                              height: 80,
                              width: 80,
                            ),
                            SizedBox(
                              height: AddSize.size10,
                            ),
                            CustomOutlineButton(
                              title: "Edit Photo",
                              backgroundColor: AppTheme.whiteColor,
                              textColor: AppTheme.primaryColor,
                              onPressed: () {},
                            )
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Neha Sharma",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkBlueText,
                                  fontSize: AddSize.font20),
                            ),
                            SizedBox(
                              height: AddSize.size5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on,color: Color(0xff878787),),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Jaipur, RJ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color:Color(0xff878787),
                                      fontSize: AddSize.font14),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AddSize.size5,
                            ),
                            Text(
                              "3:30 PM local time",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color:Color(0xff878787),
                                  fontSize: AddSize.font14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Divider(
                      color: AppTheme.pinkText.withOpacity(.39),
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Row(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full stack developer",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(5),
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
                          ),
                        ),

                      ],
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Text(
                      "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff878787),
                          fontSize: AddSize.font14),
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Divider(
                      color: AppTheme.pinkText.withOpacity(.39),
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Row(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hourly Rate",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(5),
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
                          ),
                        ),

                      ],
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Text(
                      "\$5.00",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff878787),
                          fontSize: AddSize.font14),
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Divider(
                      color: AppTheme.pinkText.withOpacity(.39),
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Row(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Skills",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(5),
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
                          ),
                        ),

                      ],
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Text(
                      "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration.",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff878787),
                          fontSize: AddSize.font14),
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Divider(
                      color: AppTheme.pinkText.withOpacity(.39),
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Row(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Work Experience",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: InkWell(
                            onTap: () {},
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
                        ),

                      ],
                    ),
                    SizedBox(
                      height: AddSize.size20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Flutter developer",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor,
                              fontSize: AddSize.font18),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(5),
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
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.whiteColor,
                                border: Border.all(color: Color(0xff707070))),
                            child: Icon(
                              Icons.delete,
                              color: AppTheme.primaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Text(
                      "Eoxysit",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textColor,
                          fontSize: AddSize.font16),
                    ),
                    Text(
                      "November 2016 - Present",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppTheme.textColor,
                          fontSize: AddSize.font14),
                    ),
                    Divider(
                      color: AppTheme.pinkText.withOpacity(.39),
                    ),
                    SizedBox(
                      height: AddSize.size10,
                    ),
                    Row(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Education History",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkBlueText,
                              fontSize: AddSize.font20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: InkWell(
                            onTap: () {},
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
                        ),

                      ],
                    ),
                    SizedBox(
                      height: AddSize.size20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomOutlineButton(
                  title: 'Next',
                  backgroundColor: AppTheme.primaryColor,
                  onPressed: () {},
                  textColor: AppTheme.whiteColor,
                  expandedValue: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
