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
  RxInt currentIndex = 1.obs;
  final controller = Get.put(ProfileScreenController());

  List content = [
    "To earn my main income",
    "To make money on the side",
    "To get experiences so i can find a full time job",
    "I don't have a goal yet: I'm exploring"
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
                "Got it: so what's your biggest goal for freelancing?",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font20),
              ),
              SizedBox(
                height: AddSize.size20,
              ),
              Text(
                "Different people come to unify for different reasons. We want to highlight to opportunities that fit your goals best - while still showing you all possibilities. which of these feels most right for you ? ",
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
                            currentIndex.value = index;
                            controller.nextPage();
                          },
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AddSize.size5),
                                  border: Border.all(color: currentIndex.value == index ? AppTheme.primaryColor : Colors.transparent,width: AddSize.size10*.22)
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
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.blackColor,
                                      fontSize: AddSize.font12),
                                ),
                                trailing: AnimatedContainer(
                                  duration: Duration(seconds: 20),
                                  child: Icon(Icons.check,color: AppTheme.primaryColor,size: currentIndex.value == index
                                      ? AddSize.size20 : 0,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),),
              SizedBox(
                height: AddSize.size30,
              ),
              InkWell(
                onTap: (){},
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
      bottomNavigationBar: Padding(
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
      ),
    );
  }
}
