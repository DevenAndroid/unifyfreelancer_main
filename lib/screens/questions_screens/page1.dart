import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/profie_screen_controller.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/progress_indicator.dart';

class Page1 extends StatelessWidget {
  Page1({Key? key}) : super(key: key);

  final controller = Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.status.value.isSuccess ? Container(
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
                  "Hey ${controller.model.value.data!.basicInfo!.firstName
                      .toString()}, Ready for your next big opportunity's ?",
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

                    Container(
                      margin: EdgeInsets.only(right: AddSize.padding20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primaryColor.withOpacity(.15),
                      ),
                      child: Icon(
                        Icons.person,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
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

                    Container(
                      margin: EdgeInsets.only(right: AddSize.padding20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primaryColor.withOpacity(.15),
                      ),
                      child: Icon(
                        Icons.mail_lock,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
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
                    Container(
                      margin: EdgeInsets.only(right: AddSize.padding20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primaryColor.withOpacity(.15),
                      ),
                      child: Icon(
                        Icons.monetization_on,
                        color: AppTheme.primaryColor,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Get paid safely and know we're there to help",
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
                  height: AddSize.size125,
                ),
                Text(
                  "It only takes 5 -10 minutes and you can edit it later, We'll save as you go",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font12),
                ),
              ],
            ),
          ),
        ) : controller.status.value.isError ? CommonErrorWidget(
          errorText: controller.model.value.message.toString(),
          onTap: () {
            controller.getData();
          },
        )
            : CommonProgressIndicator();
      }),
      bottomNavigationBar:
      Obx(() {
        return controller.status.value.isSuccess ? Padding(
          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16).copyWith(
              bottom: AddSize.padding14),
          child: Row(
            children: [
              Expanded(
                child: CustomOutlineButton(
                  title: "Get Started",
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
        ) : SizedBox();
      }),
    );
  }
}
