import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';

class Page3 extends StatelessWidget {
   Page3({Key? key}) : super(key: key);

  RxInt currentIndex = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: AddSize.screenHeight,
      width: AddSize.screenWidth,
      child: SingleChildScrollView(
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
              "Different people come to upwork for different reasons we want to highlight to opportunities that fit your goals best - while still showing you all ",
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
              height: AddSize.size40,
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
    );
  }
}
