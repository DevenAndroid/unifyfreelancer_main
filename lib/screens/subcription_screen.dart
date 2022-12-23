import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unifyfreelancer/widgets/common_outline_button.dart';
import 'package:unifyfreelancer/widgets/error_widget.dart';
import 'package:unifyfreelancer/widgets/progress_indicator.dart';
import '../../../resources/app_theme.dart';
import '../../../routers/my_router.dart';
import '../../../widgets/add_text.dart';
import '../controller/profie_screen_controller.dart';
import '../controller/subscription_controller.dart';
import '../models/model_subscription.dart';
import '../resources/size.dart';
import '../utils/api_contant.dart';



class SubscriptionScreen extends StatefulWidget {
 const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final controller = Get.put(SubscriptionPlanController());

  // final controller = Get.put(SubscriptionPlans());
  final profileController = Get.put(ProfileScreenController());
  final drawerKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    profileController.getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      backgroundColor: Colors.white,
      /*appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          titleText: 'Subscription Plan',
          isLikeButton: false,
          isProfileImage: false,
        ),
      ),*/
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppTheme.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: AppTheme.whiteColor,
        leading: InkWell(
          onTap: () {
           drawerKey.currentState!.openDrawer();
           /* Scaffold.of(context).openDrawer();*/
          },
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.all(7),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: Obx(() {
              return Container(
                margin: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  // color: AppTheme.greyTextColor.withOpacity(.2),
                  shape: BoxShape.circle,
                  /*image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80"),
                          fit: BoxFit.cover)*/),
                height: 25.h,
                width: 25.w,
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(1000),
                  child: profileController.status.value.isSuccess ? profileController.model.value.data!.basicInfo!.profileImage.toString() != ""?
                  CachedNetworkImage(
                    imageUrl: profileController
                        .model
                        .value
                        .data!
                        .basicInfo!
                        .profileImage.toString(),
                    errorWidget: (_, __, ___) => SvgPicture.asset("assets/images/user.svg",),
                    placeholder: (_, __) => SvgPicture.asset("assets/images/user.svg",),
                    fit: BoxFit.cover,
                  ) : SvgPicture.asset("assets/images/user.svg",)
                      : SizedBox(),
                ),
              );
            }),
          ),
        ),
        title: Text(
          "Subscription Plan",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textColor,
              fontSize: AddSize.font20
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(AddSize.size10),
          ),
        ),
      ),
      drawer: Drawer(
        child: Obx(() {
          return profileController.status.value.isSuccess ? ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 120,
                child: DrawerHeader(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Card(
                              elevation: 2,
                              margin: const EdgeInsets.all(7),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  //color: AppTheme.blackColor,
                                  shape: BoxShape.circle,
                                  /* image: DecorationImage(
                                    image: NetworkImage(
                                        controller.model.value.data!.basicInfo!.profileImage ?? ""),
                                    fit: BoxFit.cover)*/
                                ),
                                height: 35.h,
                                width: 35.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: profileController.status.value.isSuccess
                                      ?  profileController.model.value.data!
                                      .basicInfo!.profileImage.toString() != "" ?
                                  CachedNetworkImage(
                                    imageUrl: profileController.model.value.data!
                                        .basicInfo!.profileImage ??
                                        "",
                                    errorWidget: (_, __, ___) => SvgPicture.asset("assets/images/user.svg",),
                                    placeholder: (_, __) => SvgPicture.asset("assets/images/user.svg",),
                                    fit: BoxFit.cover,
                                  ) : SvgPicture.asset("assets/images/user.svg",)
                                      : SizedBox(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profileController.status.value.isSuccess
                                        ? profileController.model.value.data!.basicInfo!
                                        .firstName
                                        .toString() +
                                        " " +
                                        profileController.model.value.data!
                                            .basicInfo!.lastName
                                            .toString()
                                        : "",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.whiteColor),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    "Freelancer",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.whiteColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            drawerKey.currentState!.closeDrawer();
                       //     Scaffold.of(context).closeDrawer();
                          },
                          icon: Icon(
                            Icons.clear,
                            color: AppTheme.whiteColor,
                          ))
                    ],
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xfff2bde2),
                        Color(0xffa39ef5),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height:AddSize.screenHeight*.75,
                  ),
                  ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primaryColor.withOpacity(.15)),
                        child: Icon(
                          Icons.power_settings_new,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textColor),
                      ),
                      onTap: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        await pref.clear();
                        Get.offAllNamed(MyRouter.loginScreen);
                        pref.setBool("shownIntro", true);
                      }),

                ],
              )

            ],
          ) :  profileController.status.value.isError ?
          CommonErrorWidget(errorText: profileController.model.value.message.toString(), onTap: (){
          profileController.getData();
          }) : CommonProgressIndicator() ;
        }),
      ),
      body: Obx(() {
        return profileController.status.value.isSuccess ? SingleChildScrollView(
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
            )) : profileController.status.value.isError ?
        CommonErrorWidget(errorText: profileController.model.value.message.toString(), onTap: (){
          profileController.getData();
        }) : CommonProgressIndicator();
      })
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
