import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/app_theme.dart';
import '../../widgets/custom_appbar.dart';

class MyTeamsScreen extends StatefulWidget {
  const MyTeamsScreen({Key? key}) : super(key: key);

  @override
  State<MyTeamsScreen> createState() => _MyTeamsScreenState();
}

class _MyTeamsScreenState extends State<MyTeamsScreen> {

  var items = [
    'All Debits All Credits',
    'Hourly',
    'Fixed-Price',
    'Bonus',
    'Adjustments',
    'Withdrawals',
    'Expense',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "My Teams",
            // onPressedForLeading:,
          ),
        ),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Default Team",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.settingsTextColor),
                    ),

                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "This team will be used for offers sent by clients directly",
                      style:
                          TextStyle(fontSize: 13.sp, color: Color(0xff6B6B6B)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    DropdownButtonFormField<
                        dynamic>(
                      isExpanded: true,
                      value: null,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select type';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Epoxy's IT Solution LLP",
                        hintStyle: TextStyle(
                            fontSize: 13,
                            color: Color(0xff596681)),
                        counterText: "",
                        filled: true,
                        fillColor: AppTheme.primaryColor.withOpacity(.05),
                        focusColor: AppTheme.primaryColor.withOpacity(.05),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8,
                            ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:  BorderSide(
                            color: AppTheme.primaryColor.withOpacity(.15),
                          ),
                          borderRadius: BorderRadius.circular(10.0),),
                              enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(.15),),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              border: OutlineInputBorder(
                              borderSide:  BorderSide(color: AppTheme.primaryColor.withOpacity(.15), width: 2.0),
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      // Down Arrow Icon
                      icon: const Icon(
                          Icons
                              .keyboard_arrow_down,
                          color: AppTheme
                              .primaryColor),
                      items: List.generate(
                          items.length,
                              (index) =>
                              DropdownMenuItem(
                                value: items[
                                index],
                                child: Text(
                                    items[index]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xff596681)),),
                              )),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged:
                          (newValue) {},
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(
                      color: AppTheme.primaryColor.withOpacity(.49),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "My Team",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.settingsTextColor),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Teams are used to group contract by department or manager",
                      style:
                          TextStyle(fontSize: 13.sp, color: Color(0xff6B6B6B)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Team Name",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.settingsTextColor),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "John Doe",
                                style: TextStyle(
                                    fontSize: 14.sp, color: Color(0xff6B6B6B)),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Financial Account:",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.settingsTextColor),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "John Doe (57659600)",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Color(0xff6B6B6B)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                color: AppTheme.primaryColor.withOpacity(.49),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
