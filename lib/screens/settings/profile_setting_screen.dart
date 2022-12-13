import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/controller/profie_screen_controller.dart';
import 'package:unifyfreelancer/routers/my_router.dart';

import '../../repository/add_category_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  var visibility = [
    "Public",
    "Only Freelancer users",
    "Private",
  ];
  var items = [
    "Both short term and long term projects",
    "Long-term projects (3+ months)",
    "Short term projects (less than 3 months)"
  ];

  String? expValue;

  final controller = Get.put(ProfileScreenController());

  void services() {
    return showFilterButtonSheet(
        context: context,
        titleText: "Select a service",
        widgets: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: AppTheme.pinkText.withOpacity(.49),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.modelOfService.value.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        addCategoryRepo(
                                category_id: controller
                                    .modelOfService.value.data![index].id
                                    .toString(),
                                context: context)
                            .then((value) {
                          if (value.status == true) {
                            controller.getData();
                          }
                          //  showToast(value.message.toString());
                        });
                      },
                      child: Text(
                        controller.modelOfService.value.data![index].name
                            .toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkBlueText,
                            fontSize: AddSize.font16),
                      ),
                    ),
                  );
                })
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Profile Setting",
            // onPressedForLeading:,
          ),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "My Profile",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),

                        /* Text(
                        "View as others see it",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor),
                      ),*/
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppTheme.whiteColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Visibility",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textColor),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            DropdownButtonFormField<dynamic>(
                              isExpanded: true,
                              value: null,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select type';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Visibility",
                                hintStyle: TextStyle(
                                    fontSize: 13, color: Color(0xff596681)),
                                counterText: "",
                                filled: true,
                                fillColor:
                                    AppTheme.primaryColor.withOpacity(.05),
                                focusColor:
                                    AppTheme.primaryColor.withOpacity(.05),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        AppTheme.primaryColor.withOpacity(.15),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.primaryColor
                                          .withOpacity(.15),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor
                                            .withOpacity(.15),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  color: AppTheme.primaryColor),
                              items: List.generate(
                                  visibility.length,
                                  (index) => DropdownMenuItem(
                                        value: visibility[index],
                                        child: Text(
                                          visibility[index].toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xff596681)),
                                        ),
                                      )),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {},
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Project preference",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textColor),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Icon(
                                  Icons.help,
                                  color: Color(0xffB9BDC1),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            DropdownButtonFormField<dynamic>(
                              isExpanded: true,
                              value: null,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select type';
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Project preference",
                                hintStyle: TextStyle(
                                    fontSize: 13, color: Color(0xff596681)),
                                counterText: "",
                                filled: true,
                                fillColor:
                                    AppTheme.primaryColor.withOpacity(.05),
                                focusColor:
                                    AppTheme.primaryColor.withOpacity(.05),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        AppTheme.primaryColor.withOpacity(.15),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.primaryColor
                                          .withOpacity(.15),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor
                                            .withOpacity(.15),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  color: AppTheme.primaryColor),
                              items: List.generate(
                                  items.length,
                                  (index) => DropdownMenuItem(
                                        value: items[index],
                                        child: Text(
                                          items[index].toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xff596681)),
                                        ),
                                      )),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (newValue) {},
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Earnings  privacy",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textColor),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Icon(
                                  Icons.help,
                                  color: Color(0xffB9BDC1),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "Want to keep your earnings private?",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppTheme.textColor.withOpacity(.63)),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "Upgrade to a Freelancer plus membership to enable this setting.",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppTheme.textColor.withOpacity(.63)),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Experience level",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textColor),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioListTile(
                            title: Text(
                              "Entry",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.settingsTextColor),
                            ),
                            subtitle: Text(
                              "I am relatively new to this field",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff828282)),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            value: "entry",
                            groupValue: expValue,
                            onChanged: (value) {
                              setState(() {
                                expValue = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text(
                              "Intermediate",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.settingsTextColor),
                            ),
                            subtitle: Text(
                              "I have substantial experience in this field",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff828282)),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            value: "intermediate",
                            groupValue: expValue,
                            onChanged: (value) {
                              setState(() {
                                expValue = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text(
                              "Expert",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.settingsTextColor),
                            ),
                            subtitle: Text(
                              "I have comprehensive and deep expertise in this field",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff828282)),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            value: "Expert",
                            groupValue: expValue,
                            onChanged: (value) {
                              setState(() {
                                expValue = value.toString();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Categories",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textColor),
                              ),
                              InkWell(
                                onTap: () => services(),
                                child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.whiteColor,
                                      border:
                                          Border.all(color: Color(0xff707070))),
                                  child: Icon(
                                    Icons.edit,
                                    color: AppTheme.primaryColor,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            controller.model.value.data!.basicInfo!.category
                                .toString(),
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.settingsTextColor),
                          ),
                          /* SizedBox(
                          height: 10.h,
                        ),
                        CustomOutlineButton(
                          title: 'Web & Mobile Design',
                          backgroundColor: AppTheme.whiteColor,
                          expandedValue: false,
                          textColor: AppTheme.primaryColor,
                          onPressed: () {},
                        )*/
                        ],
                      ),
                    ),
                    /* Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppTheme.whiteColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(
                              0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Specialized Profiles",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor),
                        ),

                        Text(
                          "0 out of 2 published",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xff828282)),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                    RichText(
                      text: TextSpan(
                        text: "Create up to two different versions of your profile to more effectively highlight your individual specialties.",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xff828282)),
                        children: const <TextSpan>[
                          TextSpan(text: 'Learn More', style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor),),
                        ],
                      ),),


                        SizedBox(
                          height: 15.h,
                        ),
                        CustomOutlineButton(
                          title: 'Add Specialized Profile',
                          backgroundColor: AppTheme.whiteColor,
                          expandedValue: false,
                          textColor: AppTheme.primaryColor,
                          onPressed: () {},
                        )
                      ],
                    ),
                  )*/
                  ],
                )),
          );
        }));
  }
}
