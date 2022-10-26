import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/app_theme.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';

class ChangeHourlyRateScreen extends StatefulWidget {
  const ChangeHourlyRateScreen({Key? key}) : super(key: key);

  @override
  State<ChangeHourlyRateScreen> createState() => _ChangeHourlyRateScreenState();
}

class _ChangeHourlyRateScreenState extends State<ChangeHourlyRateScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Change hourly rate",
          // onPressedForLeading:,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please note that your new hourly rate will only apply to new contracts.",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w500),
                ),SizedBox(
                  height: 10,
                ),
                Text(
                  "The Freelancer Services Fee is 20% when you begin a contract with a new client.",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w500),
                ),SizedBox(
                  height: 10,
                ),

                Text(
                  "Once you bill over \$500 with your client, the fee will be 10% .",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w500),),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Your profile rate:  ',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.w400),
                    children: const <TextSpan>[
                      TextSpan(
                        text: '\$15.00',
                        style: TextStyle(
                            fontSize: 12,
                            color:
                            AppTheme.textColor,
                            fontWeight:
                            FontWeight.w600),
                      ),
                      TextSpan(
                        text: "/hr",
                        style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textColor,
                            fontWeight:
                            FontWeight.w400),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height:20,
                ),

                Text(
                  "Hourly Rate",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w600),),

                SizedBox(
                  height:5,
                ),

                Text(
                  "Total Amount client will see",
                  style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w500),),

                SizedBox(
                  height:10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppTheme.whiteColor,
                          labelStyle: const TextStyle(color: Colors.black),
                          prefixIcon:  Icon(Icons.attach_money,size: 20,),
                          hintStyle: const TextStyle(
                            color: Color(0xff596681),
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.only(left: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                              borderRadius: BorderRadius.circular(8.0)),
                        ),

                      ),
                    ),
                    Text(
                      "/hr",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w500),),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: AppTheme.pinkText.withOpacity(.45),
                ),
                SizedBox(
                  height:5,
                ),
                Text(
                  "20% Freelancer Service Fee",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w600),),

                SizedBox(
                  height:5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withOpacity(.11),
                          labelStyle: const TextStyle(color: Colors.black),
                          prefixIcon:  Icon(Icons.attach_money,size: 20,),
                          hintStyle: const TextStyle(
                            color: Color(0xff596681),
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.only(left: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                              borderRadius: BorderRadius.circular(8.0)),
                        ),

                      ),
                    ),
                    Text(
                      "/hr",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w500),),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: AppTheme.pinkText.withOpacity(.45),
                ),
                SizedBox(
                  height:5,
                ),
                Text(
                  "You'll Receive",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w600),),

                SizedBox(
                  height:5,
                ),

                Text(
                  "The estimated amount you'll receive after services fees",
                  style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.w500),),
                SizedBox(
                  height:10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppTheme.whiteColor,
                          labelStyle: const TextStyle(color: Colors.black),
                          prefixIcon:  Icon(Icons.attach_money,size: 20,),
                          hintStyle: const TextStyle(
                            color: Color(0xff596681),
                            fontSize: 15,
                          ),
                          contentPadding: const EdgeInsets.only(left: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.primaryColor.withOpacity(.15), width: 1.0),
                              borderRadius: BorderRadius.circular(8.0)),
                        ),

                      ),
                    ),
                    Text(
                      "/hr",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w500),),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOutlineButton(
                title: 'cancel',
                backgroundColor: AppTheme.whiteColor,
                onPressed: () => Get.back(),
                textColor: AppTheme.primaryColor,
                expandedValue: false,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomOutlineButton(
                title: 'Save',
                backgroundColor: AppTheme.primaryColor,
                onPressed: () {},
                textColor: AppTheme.whiteColor,
                expandedValue: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
