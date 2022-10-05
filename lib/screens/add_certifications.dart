import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/widgets/custom_textfield.dart';

import '../resources/app_theme.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';

class AddCertificationsScreen extends StatefulWidget {
  const AddCertificationsScreen({Key? key}) : super(key: key);

  @override
  State<AddCertificationsScreen> createState() =>
      _AddCertificationsScreenState();
}

class _AddCertificationsScreenState extends State<AddCertificationsScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _certifications = TextEditingController();
  TextEditingController _issueDate = TextEditingController();
  TextEditingController _expirationDate = TextEditingController();
  TextEditingController _certificationId = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                    controller: _certifications,
                    obSecure: false.obs,
                    keyboardType: TextInputType.text,
                    hintText: "Certification name".obs),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: _issueDate,
                    obSecure: false.obs,
                    keyboardType: TextInputType.datetime,
                    hintText: "Issue Date".obs),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: _expirationDate,
                    obSecure: false.obs,
                    keyboardType: TextInputType.datetime,
                    hintText: "Expiration Date".obs),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    controller: _certificationId,
                    obSecure: false.obs,
                    keyboardType: TextInputType.number,
                    hintText: "Certification ID".obs),
                SizedBox(
                  height: 10,
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
                onPressed: ()=>Get.back(),
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
