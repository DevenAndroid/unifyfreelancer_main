import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';
import '../../../resources/app_theme.dart';
import '../../../routers/my_router.dart';
import '../../../widgets/add_text.dart';
import '../controller/subscription_controller.dart';
import '../models/model_subscription.dart';
import '../resources/size.dart';
import '../utils/api_contant.dart';
import '../widgets/custom_appbar.dart';



class SubscriptionScreen extends StatefulWidget {
 const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final controller = Get.put(SubscriptionPlanController());

  // final controller = Get.put(SubscriptionPlans());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          titleText: 'Subscription Plan',
          isLikeButton: false,
          isProfileImage: false,
        ),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(AddSize.padding16),
            child: Column(
              children: [
                Obx(() {
                  return controller.status.value.isSuccess
                      ? ListView.builder(
                      itemCount: controller.Model.value.data!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index1) {
                        return plans(
                            controller.Model.value.data![index1], index1);
                      })
                      : controller.status.value.isError
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : const Center(child: CircularProgressIndicator());
                }),
              ],
            ),
          )),
    );
  }

  // Widget subscriptionCard(Data data, int index1) {
  //   return InkWell(
  //       onTap: () {
  //         if (controller.selectedIndex.value != index1) {
  //           controller.selectedIndex.value = index1;
  //         } else {
  //           controller.selectedIndex.value = -1;
  //         }
  //         setState(() {});
  //       },
  //       child: Container(
  //         width: AddSize.screenWidth,
  //         decoration: BoxDecoration(
  //             boxShadow: blurBoxShadow,
  //             color: AppTheme.whitebg,
  //             borderRadius: BorderRadius.circular(10)),
  //         padding: EdgeInsets.all(AddSize.size20),
  //         margin: EdgeInsets.only(right: AddSize.size20),
  //         child: Stack(
  //           children: [
  //             Obx(() {
  //               return Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   AddText(
  //                     text: data.title.toString(),
  //                     color: AppTheme.filtter.withOpacity(0.8),
  //                     fontWeight: FontWeight.w500,
  //                     fontSize: AddSize.font16,
  //                   ),
  //                   SizedBox(height: AddSize.size15),
  //                   AddText(
  //                     text:
  //                         '${data.amount.toString()}/${data.validity.toString()}',
  //                     color: AppTheme.filtter.withOpacity(0.8),
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: AddSize.font18,
  //                   ),
  //                   SizedBox(height: AddSize.size15),
  //                   if (controller.selectedIndex.value == index1)
  //                     learnPlan(controller.Model.value.data![index1].services!),
  //                   Padding(
  //                     padding: EdgeInsets.only(
  //                       top: AddSize.size10,
  //                     ),
  //                     child: AddButton(
  //                       titleText: "Choose Plan",
  //                       expended: true,
  //                       onPresses: () {
  //                         Get.toNamed(MyRouter.bottomnavbar);
  //                         showToast('Plan selected successfully');
  //                       },
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: AddSize.size20,
  //                   ),
  //                 ],
  //               );
  //             }),
  //             Positioned(
  //               top: AddSize.size10,
  //               right: AddSize.size10,
  //               child: Container(
  //                 width: AddSize.size20,
  //                 height: AddSize.size20,
  //                 decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   border: Border.all(width: 2, color: AppTheme.primaryColor),
  //                 ),
  //                 padding: EdgeInsets.all(AddSize.size10 * .34),
  //                 child: controller.selectedIndex.value == index1
  //                     ? Container(
  //                         decoration: const BoxDecoration(
  //                           shape: BoxShape.circle,
  //                           color: AppTheme.primaryColor,
  //                         ),
  //                       )
  //                     : const SizedBox(),
  //               ),
  //             )
  //           ],
  //         ),
  //       )
  //   );
  // }

  Widget plans(Data data, int index1) {
    return Container(
      width: AddSize.screenWidth,
      // height: AddSize.screenHeight,
      decoration: BoxDecoration(
          boxShadow: blurBoxShadow,
          color: AppTheme.whiteColor,
          border: Border.all(color: AppTheme.primaryColor),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(AddSize.size20),
      margin: EdgeInsets.only(bottom: AddSize.size10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddText(
                    text: data.title.toString(),
                    color: AppTheme.darkBlueText,
                    fontWeight: FontWeight.w500,
                    fontSize: AddSize.font18,
                  ),
                  SizedBox(height: AddSize.size15),
                  AddText(
                    text:
                    '${data.amount.toString()}/${data.validity.toString()}',
                    color: AppTheme.darkBlueText.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                    fontSize: AddSize.font18,
                  ),
                  SizedBox(height: AddSize.size15),
                ],
              ),
              children: <Widget>[
                ListTile(
                  title:
                  learnPlan(controller.Model.value.data![index1].services!),
                ),
                SizedBox(height: AddSize.size15),
                //if (controller.selectedIndex.value == index1)
                Padding(
                  padding: EdgeInsets.only(
                    top: AddSize.size10,
                  ),
                  child: CustomOutlineButton(
                    title: 'Choose Plan', backgroundColor: AppTheme.primaryColor,
                    textColor: AppTheme.whiteColor,
                    onPressed: (){
                      Get.toNamed(MyRouter.stripePaymentScreen,arguments: [data]);
                      showToast('Plan selected successfully');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  learnPlan(List<Services> services) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AddSize.size10,
        ),
        ListView.builder(
            itemCount: services.length,
            shrinkWrap: true,
            // itemBuilder: (BuildContext context, int index) {},
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: AddSize.size14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: AddSize.size20,
                        height: AddSize.size20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryColor,
                          // color: controller.Model.value.data![index].services![index].value == true
                          //     ? AppTheme.userActive
                          //     : AppTheme.subText,
                        ),
                        padding: EdgeInsets.all(AddSize.size10 * .10),
                        child: const Icon(
                          Icons.check,
                          color: AppTheme.whiteColor,
                          size: 16,
                        )),
                    SizedBox(
                      width: AddSize.size10,
                    ),
                    Expanded(
                      child:
                      buildAddText(services[index].description.toString().capitalizeFirst),
                    )
                  ],
                ),
              );
            })
      ],
    );
  }

  AddText buildAddText(text) {
    return AddText(
      text: text,
      color: AppTheme.subText,
      fontSize: AddSize.font16,
      fontWeight: FontWeight.w400,
    );
  }
}
