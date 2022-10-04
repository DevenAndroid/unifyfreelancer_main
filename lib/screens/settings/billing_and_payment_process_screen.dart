import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_textfield.dart';

class BillingAndPaymentProcessScreen extends StatefulWidget {
  const BillingAndPaymentProcessScreen({Key? key}) : super(key: key);

  @override
  State<BillingAndPaymentProcessScreen> createState() =>
      _BillingAndPaymentProcessScreenState();
}

class _BillingAndPaymentProcessScreenState
    extends State<BillingAndPaymentProcessScreen> {
  TextEditingController _cardController = TextEditingController();
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _monthController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _securityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Billing & Payment",
          // onPressedForLeading:,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add a Billing Method",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textColor),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Card Number",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textColor),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.credit_card,
                          size: 20,
                        ),
                        Icon(
                          Icons.credit_card,
                          size: 20,
                        ),
                        Icon(
                          Icons.credit_card,
                          size: 20,
                        ),
                        Icon(
                          Icons.credit_card,
                          size: 20,
                        ),
                        Icon(
                          Icons.credit_card,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: _cardController,
                  obSecure: false.obs,
                  keyboardType: TextInputType.number,
                  hintText: "".obs,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "First Name",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textColor),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: _cardController,
                  obSecure: false.obs,
                  keyboardType: TextInputType.text,
                  hintText: "First Name".obs,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Last Name",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textColor),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: _cardController,
                  obSecure: false.obs,
                  keyboardType: TextInputType.text,
                  hintText: "Last Name".obs,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Expires on",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textColor),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _cardController,
                        obSecure: false.obs,
                        keyboardType: TextInputType.number,
                        hintText: "MM".obs,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: _cardController,
                        obSecure: false.obs,
                        keyboardType: TextInputType.number,
                        hintText: "YY".obs,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Security Code",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textColor),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: _cardController,
                  obSecure: true.obs,
                  keyboardType: TextInputType.number,
                  hintText: "Security Code".obs,
                ),
              ],
            )),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
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
