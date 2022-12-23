import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/profie_screen_controller.dart';
import '../../controller/question_controller.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';

class Page3 extends StatefulWidget {
   Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {

  final controller = Get.put(ProfileScreenController());

  List content = [
    "I'm here to earn a make a full-time income",
    "I'm here to make money on the side.",
    "I'm here to gain experience, to help me find a full-time role.",
    "I'm just exploring for now"
  ] ;
  List icons = [
    'assets/icon/venture-capital.svg',
    'assets/icon/money.svg',
    'assets/icon/rating.svg',
    'assets/icon/search1.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12),
        height: AddSize.screenHeight,
        width: AddSize.screenWidth,
        child: SingleChildScrollView(
          physics:  BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AddSize.size10,
              ),
              Text(
                "Next up: Tell us your hopes, your dreams, your aspirations and your goals...",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font20),
              ),
              SizedBox(
                height: AddSize.size20,
              ),
              Text(
                "Unify is a place for everyone. We want to understand your motivations so we can help you get the best out of your experience with us.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font14),
              ),
              SizedBox(
                height: AddSize.size20,
              ),
              ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    Obx(() {
                      return Padding(
                        padding: EdgeInsets.only(bottom: AddSize.size20),
                        child: InkWell(
                          onTap: (){
                            controller.questionIndex3.value = index;
                            controller.nextPage();
                          },
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AddSize.size5),
                                  border: Border.all(color: controller.questionIndex3.value == index ? AppTheme.primaryColor : Colors.transparent,width: AddSize.size10*.22)
                              ),
                              child: ListTile(
                                visualDensity: VisualDensity(horizontal: -4, vertical: 0),
                                leading: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.primaryColor.withOpacity(.15),
                                  ),
                                  child: SvgPicture.asset(
                                    icons[index],
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                title: Text(
                                  content[index].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.darkBlueText,
                                      fontSize: AddSize.font14),
                                ),
                                trailing: AnimatedContainer(
                                  duration: Duration(seconds: 20),
                                  child: Icon(Icons.check,color: AppTheme.primaryColor,size: controller.questionIndex3.value == index
                                      ? AddSize.size20 : 0,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),),

              InkWell(
                onTap: (){
                  controller.nextPage();
                },
                child: Text(
                  "Skip for now >",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font14),
                ),
              )
            ],
          ),
        ),
      ),
   /*   bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: AddSize.padding16).copyWith(bottom: AddSize.padding14),
        child: Row(
          children: [
            Expanded(
              child: CustomOutlineButton(
                title: "Back",
                backgroundColor: AppTheme.whiteColor,
                textColor: AppTheme.primaryColor,
                expandedValue: false,
                onPressed: () {
                  controller.previousPage();
                },
              ),
            ),
            SizedBox(width: AddSize.size20,),
            Expanded(
              child: CustomOutlineButton(
                title: "Next",
                backgroundColor: AppTheme.primaryColor,
                textColor: AppTheme.whiteColor,
                expandedValue: false,
                onPressed: () {
                  controller.nextPage();
                },
              ),
            ),
          ],
        ),
      ),*/
    );
  }
}
