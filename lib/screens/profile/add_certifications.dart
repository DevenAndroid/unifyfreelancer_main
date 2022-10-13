import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';
import 'package:unifyfreelancer/widgets/custom_textfield.dart';

import '../../repository/edit_certificate_info_repository.dart';
import '../../resources/app_theme.dart';
import '../../routers/my_router.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class AddCertificationsScreen extends StatefulWidget {
  const AddCertificationsScreen({Key? key}) : super(key: key);

  @override
  State<AddCertificationsScreen> createState() =>
      _AddCertificationsScreenState();
}

class _AddCertificationsScreenState extends State<AddCertificationsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _issueDate = TextEditingController();
  TextEditingController _expirationDate = TextEditingController();

  var items = [
    "Adobe XD",
    "PhotoShop",
    "Figma",
    "Development",

  ];
  var item ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Add Certifications",
          // onPressedForLeading:,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<dynamic>(
                  isExpanded: true,
                  value: null,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select type';
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppTheme.whiteColor,
                    hintText: "Add Certified Expert",
                    labelStyle: const TextStyle(color: Colors.black),
                    hintStyle: const TextStyle(
                      color: Color(0xff596681),
                      fontSize: 13,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.primaryColor.withOpacity(.15),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.primaryColor.withOpacity(.15),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppTheme.primaryColor.withOpacity(.15),
                            width: 1.0),
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: AppTheme.primaryColor),
                  items: List.generate(
                      items.length,
                      (index) => DropdownMenuItem(
                            value: items[index],
                            child: Text(items[index].toString(),
                              style: TextStyle(
                                  fontSize: 13, color: Color(0xff596681)),
                            ),
                          )),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (newValue) {
                    setState(() {
                      item= newValue.toString();
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Adobe Certified Expert",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.settingsTextColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "If you have earned an official certification from Adobe, paste the verification code displayed on your certificate into the box below. We will confirm your certification and it will appear on your profile within 5 days of submission.",
                  style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textColor.withOpacity(.63)),
                ),
                SizedBox(
                  height: 20,
                ),

                CustomTextField(
                    controller: _issueDate,
                    obSecure: false.obs,
                    keyboardType: TextInputType.datetime,
                    hintText: "Issue Date".obs,
                validator: (value){
                      if(value == ""){
                        return "please enter a date";
                      }

                },),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: _expirationDate,
                    obSecure: false.obs,
                    keyboardType: TextInputType.datetime,
                    hintText: "Expiration Date".obs),
                
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
                title: 'Add certifications',
                backgroundColor: AppTheme.primaryColor,
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                    editCertificateInfoRepo(item,_issueDate.text.trim(),_expirationDate.text.trim(),357,context).then((value) {
                      if(value.status==true){
                        Get.back();
                      }
                      showToast(value.message.toString());
                    });
                  };
                },
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
