import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../widgets/custom_appbar.dart';
import '../routers/my_router.dart';
import '../widgets/appDrawer.dart';
import '../widgets/common_outline_button.dart';

class SaveJobsScreen extends StatefulWidget {
  const SaveJobsScreen({Key? key}) : super(key: key);

  @override
  State<SaveJobsScreen> createState() => _SaveJobsScreenState();
}

class _SaveJobsScreenState extends State<SaveJobsScreen> {


/*  List<StackButtons> stackButtonsList = [
    StackButtons(titleText: 'Support Agent', positionPoint: 0),
    StackButtons(titleText: 'Designer', positionPoint: 50),
    StackButtons(titleText: 'IOS Developer', positionPoint: 100),
    StackButtons(titleText: 'Backend Developer', positionPoint: 150),
  ];*/

List<String> stackButtonsList = [
  'Support Agent',
  'Designer',
  'IOS Developer',
  'Backend Developer'
];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Save Jobs",
        ),
      ),
      drawer: AppDrawerScreen(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder:( context, index) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 15,right: 10,left: 10),
                  width: deviceWidth,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0,
                            3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: deviceWidth * .01,
                      ),
                      Text(
                        "VeeGaming Studio",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.pinkText,
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      Text(
                        "IOS And Android  Mobile App Developer",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkBlueText,
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      Text(
                        "We are a computerized  wellbeing startup with a spry and  high-speed climate. ",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: AppTheme.greyTextColor),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$140.00",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight:
                                    FontWeight.w600,
                                    color: AppTheme
                                        .darkBlueText),
                              ),

                              Text(
                                "Budget",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight:
                                    FontWeight.w500,
                                    color: const Color(
                                        0xff6B6B6B)),
                              ),
                            ],
                          ),
                          CustomOutlineButton(
                            title: "Send Proposal",
                            backgroundColor: AppTheme.whiteColor,
                            textColor: AppTheme.primaryColor,
                            onPressed: () =>Get.toNamed(MyRouter.jobDetailsScreen),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      const Divider(
                        color: Color(0xff6D2EF1),
                      ),
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                      SizedBox(
                        height: 45,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: stackButtonsList.length,
                            itemBuilder: (context,index){
                          return Container(
                              margin: EdgeInsets.only(right: 4, bottom: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.whiteColor,
                                    side: const BorderSide(
                                      color: Color(0xff6D2EF1),
                                    ),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        )),
                                    padding: EdgeInsets.symmetric(horizontal: 20,),
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                onPressed: () {  },
                                child: Text("${stackButtonsList[index]}",style: TextStyle(color: AppTheme.primaryColor),),
                              )

                            /*CustomOutlineButton(
                                                      title: stackButtonsList[index],
                                                      backgroundColor: AppTheme.whiteColor,
                                                      textColor: AppTheme.primaryColor,
                                                      expandedValue: false,
                                                      onPressed: () {},
                                                    ),*/
                          );;
                        }
                        ),
                      ),
                      /*SizedBox(
                        width: deviceWidth,
                        height: 50.h,
                        child: Stack(
                          children: List.generate(
                            stackButtonsList.length,
                                (index11) => Positioned(
                                left: stackButtonsList[
                                index11]
                                    .positionPoint,
                                child: CustomOutlineButton(
                                  backgroundColor: AppTheme.whiteColor,
                                  textColor: AppTheme.primaryColor,
                                  title: stackButtonsList[
                                  index11]
                                      .titleText
                                      .toString(),

                                  onPressed: () {
                                    String titleName = "";
                                    double positionName = 0;
                                    titleName =
                                    stackButtonsList[
                                    index11]
                                        .titleText!;
                                    positionName =
                                    stackButtonsList[
                                    index11]
                                        .positionPoint!;
                                    stackButtonsList
                                        .removeAt(index11);
                                    stackButtonsList.add(
                                        StackButtons(
                                            titleText:
                                            titleName,
                                            positionPoint:
                                            positionName));
                                    setState(() {});
                                  },
                                )),
                          ),
                          // children: [
                          // ],
                        ),
                      ),*/
                      SizedBox(
                        height: deviceHeight * .01,
                      ),
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}

class StackButtons {
  final String? titleText;
  final double? positionPoint;

  StackButtons({this.titleText, this.positionPoint});
}
