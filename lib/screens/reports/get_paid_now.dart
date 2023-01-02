import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';

import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class GetPaidNow extends StatefulWidget {
  const GetPaidNow({Key? key}) : super(key: key);

  @override
  State<GetPaidNow> createState() => _GetPaidNowState();
}

class _GetPaidNowState extends State<GetPaidNow> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Get Paid Now",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Get Paid Now",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              const Text(
                "Available Balance",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText),
              ),
              const Text(
                "\$400.00",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              const Text(
                "Payment Method",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.darkBlueText),
              ),
              const SizedBox(
                height: 5,
              ),
              CustomTextField(
                suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                obSecure: false.obs,
                keyboardType: TextInputType.text,
                hintText: "Please select".obs,
              ),
            ],
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
                title: 'Cancel',
                backgroundColor: AppTheme.whiteColor,
                onPressed: () {
                  Get.back();
                },
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
