import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../resources/app_theme.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_textfield.dart';

class AddMilestoneScreen extends StatefulWidget {
  const AddMilestoneScreen({Key? key}) : super(key: key);

  @override
  State<AddMilestoneScreen> createState() => _AddMilestoneScreenState();
}

class _AddMilestoneScreenState extends State<AddMilestoneScreen> {

  final TextEditingController _milestoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  int dateInput = 0;
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Add Milestone",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16,horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Name of MileStone 8",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppTheme.textColor),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: _milestoneController,
                  obSecure: false.obs,
                  keyboardType: TextInputType.text,
                  hintText: "".obs,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Description is required'),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Due date",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff180D31)),
                          ),
                          CustomTextField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100));
                              if (pickedDate != null) {
                                print(pickedDate);
                                // String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                _dateController.text = dateFormat.format(pickedDate);
                                print(pickedDate.millisecondsSinceEpoch);setState(() {dateInput = pickedDate.millisecondsSinceEpoch;
                                });
                              } else {
                                return null;
                              }
                            },
                            suffixIcon: Icon(Icons.calendar_month_outlined,size: 20,color: AppTheme.primaryColor,),
                            readOnly: true,
                            controller: _dateController,
                            obSecure: false.obs,
                            keyboardType: TextInputType.datetime,
                            hintText: "".obs,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Due date is required'),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amount",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff180D31)),
                          ),
                          CustomTextField(
                            controller: _amountController,
                            prefix: Icon(
                              Icons.attach_money,
                              size: 20,
                            ),
                            obSecure: false.obs,
                            keyboardType: TextInputType.number,
                            hintText: "".obs,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Amount is required'),
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  "Description (Optional)",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff180D31)),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  isMulti: true,
                  controller: _descriptionController,
                  obSecure: false.obs,
                  keyboardType: TextInputType.text,
                  hintText: "".obs,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Description is required'),
                  ]),
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
