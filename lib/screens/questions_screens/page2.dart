import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/question_controller.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';

class Page2 extends StatefulWidget {
   Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  RxInt currentIndex = 1.obs;

  final controller = Get.put(QuestionController());

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
                "A few quick questions first, have you freelanced before?",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font20),
              ),
              SizedBox(
                height: AddSize.size20,
              ),
              Text(
                "This lets us know how much help to give you along the way.",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.darkBlueText,
                    fontSize: AddSize.font14),
              ),
              SizedBox(
                height: AddSize.size10*.1,
              ),
              Text(
                "(We won't share your answer with anyone else, including potential clients.)",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textColor,
                    fontSize: AddSize.font14),
              ),
              SizedBox(
                height: AddSize.size20,
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    Obx(() {
                      return Padding(
                        padding: EdgeInsets.only(bottom: AddSize.size20),
                        child: InkWell(
                          onTap: (){
                            currentIndex.value = index;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AddSize.size5),
                                border: Border.all(color: currentIndex.value == index ? AppTheme.primaryColor : Colors.transparent,width: AddSize.size10*.22)
                            ),
                            child: ListTile(
                              visualDensity: VisualDensity(horizontal: -4, vertical: 0),
                              leading: Icon(Icons.favorite_border,color: AppTheme.blackColor,),
                              title: Text(
                                "Nope: its new to me",
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
                      );
                    }),),
              SizedBox(
                height: AddSize.size20,
              ),
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
