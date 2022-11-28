import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../controller/profie_screen_controller.dart';
import '../../repository/edit_hours_per_week_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../utils/api_contant.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_textfield.dart';

class HourlyChargeQuestion extends StatefulWidget {
  HourlyChargeQuestion({Key? key}) : super(key: key);

  @override
  State<HourlyChargeQuestion> createState() => _HourlyChargeQuestionState();
}

class _HourlyChargeQuestionState extends State<HourlyChargeQuestion> {
  final _unifyFeeController = TextEditingController();
  final _rateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ProfileScreenController());

  @override
  void initState() {
    super.initState();
    price = double.parse(controller.priceController.text);
    _unifyFeeController.text = ((price! * 10) / 100).toString();
    _rateController.text = (price! - double.parse(_unifyFeeController.text)).toString();
  }

  double? price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
                  "Now, Let's set your hourly rate.",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font20),
                ),
                SizedBox(
                  height: AddSize.size15,
                ),
                Text(
                  "Clients will se this rate on your profile and in search result once you publish your profile. You can adjust your rate every time you submit a proposal",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font12),
                ),
                SizedBox(
                  height: AddSize.size30,
                ),
                Text(
                  "Hourly Rate",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font16),
                ),
                Text(
                  "Total amount the client will see",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font12),
                ),
                SizedBox(
                  height: AddSize.size5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        onFieldSubmitted: (value) {
                          setState(() {
                            print(value);
                            price = double.parse(value);
                            _unifyFeeController.text = ((price! * 10) / 100).toString();
                            _rateController.text = (price! - double.parse(_unifyFeeController.text)).toString();

                          });
                        },
                        onChanged: (value){
                          setState(() {
                            print(value);
                            price = double.parse(value);
                            _unifyFeeController.text = ((price! * 10) / 100).toString();
                            _rateController.text = (price! - double.parse(_unifyFeeController.text)).toString();

                          });
                        },
                        inputFormatters1: [FilteringTextInputFormatter.digitsOnly],
                        controller: controller.priceController,
                        obSecure: false.obs,
                        hintText: "".obs,
                        prefix: Icon(Icons.attach_money),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Please your hourly price'),
                        ]),
                      ),
                    ),
                    Text(
                      "/hour",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textColor.withOpacity(.49),
                          fontSize: AddSize.font16),
                    ),
                  ],
                ),
                SizedBox(
                  height: AddSize.size30,
                ),
                Text(
                  "Unify Service Fee",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font16),
                ),
                Text(
                  "The unify Service fee is 20% when you begin a contract with a new client. Once you bill over \$500 with your client, the fee will be 10%",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font12),
                ),
                SizedBox(
                  height: AddSize.size5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _unifyFeeController,
                        readOnly: true,
                        obSecure: false.obs,
                        hintText: "".obs,
                        prefix: Icon(Icons.attach_money),

                      ),
                    ),
                    Text(
                      "/hour",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textColor.withOpacity(.49),
                          fontSize: AddSize.font16),
                    ),
                  ],
                ),
                SizedBox(
                  height: AddSize.size30,
                ),
                Text(
                  "Hourly Rate",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkBlueText,
                      fontSize: AddSize.font16),
                ),
                Text(
                  "The estimate amount you'll receive after service fees",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textColor,
                      fontSize: AddSize.font12),
                ),
                SizedBox(
                  height: AddSize.size5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _rateController,
                        readOnly: true,
                        obSecure: false.obs,
                        hintText: "".obs,
                        prefix: Icon(Icons.attach_money),
                      ),
                    ),
                    Text(
                      "/hour",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textColor.withOpacity(.49),
                          fontSize: AddSize.font16),
                    ),
                  ],
                ),
                SizedBox(
                  height: AddSize.size30,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomOutlineButton(
                          title: 'Back',
                          backgroundColor: AppTheme.whiteColor,
                          onPressed: () {
                           controller.previousPage();
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
                          title: 'Next',
                          backgroundColor: AppTheme.primaryColor,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              editHoursPerWeekRepo(
                                      hours_id: 1,
                                      hours_price: controller.priceController.text.trim(),
                                      context: context)
                                  .then((value) {
                                if (value.status == true) {
                                  controller.nextPage();
                                }
                              //  showToast(value.message.toString());
                              });
                            }
                          },
                          textColor: AppTheme.whiteColor,
                          expandedValue: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
