import 'package:flutter/material.dart';

import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              "Hey ZabuZa. Ready for your next big opportunity's ?",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.darkBlueText,
                  fontSize: AddSize.font20),
            ),
            SizedBox(
              height: AddSize.size50,
            ),
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(
                    right: AddSize.padding20,
                  ),
                  child: Icon(Icons.person),
                ),
                Expanded(
                  child: Text(
                    "Answer a few questions and start building your profile",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font14),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AddSize.size20,
            ),
            Divider(
              color: AppTheme.primaryColor.withOpacity(.49),
            ),
            SizedBox(
              height: AddSize.size20,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: AddSize.padding20,
                  ),
                  child: Icon(Icons.mail_lock_outlined),
                ),
                Expanded(
                  child: Text(
                    "Apply for open roles or list services for clients to  buy",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textColor,
                        fontSize: AddSize.font14),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AddSize.size20,
            ),
            Divider(
              color: AppTheme.primaryColor.withOpacity(.49),
            ),
            SizedBox(
              height: AddSize.size20,
            ),
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(
                    right: AddSize.padding20,
                  ),
                  child: Icon(Icons.monetization_on),
                ),
                Expanded(
                  child: Text(
                    "Get paid safely and know we're there to help",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textColor,
                        fontSize:AddSize.font14 ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AddSize.size20,
            ),
            Divider(
              color: AppTheme.primaryColor.withOpacity(.49),
            ),
            SizedBox(
              height: AddSize.size125,
            ),
            Text(
              "It only takes 5 -10 minutes and you can edit it later, We'll save as you go",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textColor,
                  fontSize: AddSize.font12),
            ),
            SizedBox(
              height: AddSize.size20,
            ),
            CustomOutlineButton(
              title: "Get Started",
              backgroundColor: AppTheme.primaryColor,
              textColor: AppTheme.whiteColor,
              expandedValue: true,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
