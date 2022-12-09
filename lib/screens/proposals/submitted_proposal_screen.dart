import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';
import 'package:unifyfreelancer/resources/size.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../../Controller/jobs_detail_controller.dart';
import '../../models/model_milestones.dart';
import '../../popups/radio_buttons_job_details.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class SubmittedProposalScreen extends StatefulWidget {
  const SubmittedProposalScreen({Key? key}) : super(key: key);

  @override
  State<SubmittedProposalScreen> createState() => _SubmittedProposalScreenState();
}

class _SubmittedProposalScreenState extends State<SubmittedProposalScreen> {
  String? radioProjectType = "By project";
  final dateFormatForShow = DateFormat('yyyy-MM-dd');
  final controller = Get.put(JobsDetailController());
  List<ModelMilestones> milestone = <ModelMilestones>[
    ModelMilestones(description: "", amount: "", dueDate: "")
  ];
  dynamic dateInput = 0;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppbar(
              isLikeButton: false,
              isProfileImage: false,
              titleText: "Job details",
            )),
        body: SingleChildScrollView(
            child: Column(
          children: [
            contentSection(),
            coverLetter(),
            AboutTheClient(),
          ],
        )));
  }

  contentSection() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              CustomOutlineButton(
                title: "Backend Developer",
                backgroundColor: AppTheme.whiteColor,
                textColor: AppTheme.primaryColor,
                onPressed: () {},
              ),
              SizedBox(
                width: AddSize.size10,
              ),
              Text(
                'Posted dec 6, 2022',
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
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
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
          Divider(
            color: AppTheme.primaryColor.withOpacity(.49),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Text(
            "Your Proposed terms",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Text(
            "Client's budget: \$70.00",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: AddSize.size20,
          ),
          Text(
            "How do you want to be paid?",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AddSize.size10,
          ),
          Text(
            "By project",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font14,
                fontWeight: FontWeight.w500),
          ),

          SizedBox(
            height: deviceHeight * .015,
          ),

          Text(
            "Total price of project",
            style: TextStyle(
                color: AppTheme.darkBlueText,
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: deviceHeight * .01,
          ),
          Text(
            "This includes all milestones, and is the amount your client will see",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: deviceHeight * .01,
          ),
          Text(
            "\$0.00",
            style: TextStyle(
                color: AppTheme.darkBlueText,
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: deviceHeight * .015,
          ),
          const Divider(
            thickness: 0.2,
            color: Color(0xff6D2EF1),
          ),
          SizedBox(
            height: deviceHeight * .01,
          ),


          Text(
            "You'll Receive",
            style: TextStyle(
                color: AppTheme.darkBlueText,
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: deviceHeight * .01,
          ),
          Text(
            "Your estimated payment. after service fees",
            style: TextStyle(
                color: Color(0xff4D4D4D),
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: deviceHeight * .01,
          ),
          Text(
            "\$0.00",
            style: TextStyle(
                color: AppTheme.darkBlueText,
                fontSize: AddSize.font16,
                fontWeight: FontWeight.w600),
          ),

          SizedBox(
            height: AddSize.size30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xff6D2EF1),
                        ),
                        backgroundColor: AppTheme.whiteColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            )),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: (){
                      Get.toNamed(MyRouter.changeTermsScreen);
                      Get.toNamed(MyRouter.changeTermsScreen);
                    },
                    child: Text(
                          "Change terms",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      )

              ),
              SizedBox(
                width: AddSize.size10,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xff6D2EF1),
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          )),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: (){},
                  child: Text(
                    "Withdraw proposal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppTheme.whiteColor,
                    ),
                  ),
                )
              ),
            ],
            // =======
            //             ],
          ),

        ]));
  }


  coverLetter() {
    return Container(
      margin: const EdgeInsets.symmetric(/*vertical: 15,*/ horizontal: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
          )
        ],
      ),
      child: Theme(
        data: ThemeData(
                expansionTileTheme: ExpansionTileThemeData(
                    textColor: AppTheme.primaryColor,
                    iconColor: AppTheme.primaryColor))
            .copyWith(dividerColor: Colors.transparent),
        child: ListTileTheme(
          contentPadding: EdgeInsets.zero,
          child: ExpansionTile(
              expandedAlignment: Alignment.topLeft,
              title: Text(
                "Cover letter",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font20,
                    fontWeight: FontWeight.w600),
              ),
              children: [
                SizedBox(
                  height: AddSize.size10,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's.",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ]),
        ),
      ),
    );
  }

/*  Message() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
          )
        ],
      ),
      child: Theme(
        data: ThemeData(
                expansionTileTheme: ExpansionTileThemeData(
                    textColor: AppTheme.primaryColor,
                    iconColor: AppTheme.primaryColor))
            .copyWith(dividerColor: Colors.transparent),
        child: ListTileTheme(
          contentPadding: EdgeInsets.zero,
          child: ExpansionTile(
              expandedAlignment: Alignment.topLeft,
              title: Text(
                "Message",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font20,
                    fontWeight: FontWeight.w600),
              ),
              children: [
                SizedBox(
                  height: AddSize.size10,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's.",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ]),
        ),
      ),
    );
  }*/

  AboutTheClient() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 12),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
          )
        ],
      ),
      child: Theme(
        data: ThemeData(
                expansionTileTheme: ExpansionTileThemeData(
                    textColor: AppTheme.primaryColor,
                    iconColor: AppTheme.primaryColor))
            .copyWith(dividerColor: Colors.transparent),
        child: ListTileTheme(
          contentPadding: EdgeInsets.zero,
          child: ExpansionTile(
              expandedAlignment: Alignment.topLeft,
              title: Text(
                "About the client",
                style: TextStyle(
                    color: Color(0xff4D4D4D),
                    fontSize: AddSize.font20,
                    fontWeight: FontWeight.w600),
              ),
              children: [
                SizedBox(
                  height: AddSize.size10,
                ),
                Row(
                  children: [
                    Icon(Icons.verified,
                        color: AppTheme.primaryColor, size: 20),
                    SizedBox(
                      width: AddSize.size10,
                    ),
                    Text(
                      "Payment method verified",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4D4D4D),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
                Row(
                  children: [
                    Wrap(
                      children: List.generate(
                          5,
                          (index) => 3 > index
                              ? Icon(
                                  Icons.star,
                                  color: AppTheme.pinkText,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.star_border_outlined,
                                  color: Colors.grey,
                                  size: 20,
                                )),
                    ),
                    SizedBox(
                      width: AddSize.size10,
                    ),
                    Text(
                      "4.2 of 22 reviews",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff170048)),
                    ),
                  ],
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Netherlands",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        Text(
                          "Zwijndrecht 12:20 pm",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Text(
                          "5 jobs posted",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        Text(
                          "20% hire rate, 1 open job",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Text(
                          "\$300+ total spent",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        Text(
                          "5 hires, 2 active",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size10,
                        ),
                        Text(
                          "1 to 3 months",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        Text(
                          "Project Length",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size15,
                        ),
                        Text(
                          "Mid size company (10-99 people)",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size15,
                        ),
                        Text(
                          "Member since Sep 16, 2020",
                          style: TextStyle(
                            fontSize: AddSize.font16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff462D7A),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
