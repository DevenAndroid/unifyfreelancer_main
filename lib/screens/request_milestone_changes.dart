import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../resources/app_theme.dart';
import '../widgets/common_outline_button.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_textfield.dart';

class RequestMilestoneChangesScreen extends StatefulWidget {
  const RequestMilestoneChangesScreen({Key? key}) : super(key: key);

  @override
  State<RequestMilestoneChangesScreen> createState() =>
      _RequestMilestoneChangesScreenState();
}

class _RequestMilestoneChangesScreenState
    extends State<RequestMilestoneChangesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          isLikeButton: false,
          isProfileImage: false,
          titleText: "Request milestone changes",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0,right: 20),
                      child: Text(
                        "7",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff180D31)),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "6 User Management",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff180D31)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              FilterChip(
                                  padding: EdgeInsets.zero,
                                  shape: StadiumBorder(
                                      side: BorderSide(
                                          color: AppTheme.primaryColor)),
                                  backgroundColor: AppTheme.whiteColor,
                                  label: Text(
                                    "Active",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff180D31)),
                                  ),
                                  onSelected: (value) {})
                            ],
                          ),
                          Text(
                            "\$600.00",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textColor),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.whiteColor,
                              border: Border.all(color: Color(0xff707070))),
                          child: Icon(
                            Icons.edit,
                            color: AppTheme.primaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: AppTheme.primaryColor.withOpacity(.49),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomOutlineButton(
                  title: 'Propose a new milestone',
                  backgroundColor: AppTheme.whiteColor,
                  onPressed: () {},
                  textColor: AppTheme.primaryColor,
                  expandedValue: true,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Message to Client (Optional)",
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
                  //  controller: _descriptionController,
                  obSecure: false.obs,
                  keyboardType: TextInputType.text,
                  hintText: "".obs,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Description is required'),
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Client will need to approve these updates. We'll notify them and let you know if these changes are approved",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff180D31)),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: AppTheme.primaryColor.withOpacity(.49),
                ),
                Row(
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
                Divider(
                  color: AppTheme.primaryColor.withOpacity(.49),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
