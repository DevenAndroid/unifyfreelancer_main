import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/contact_info_controller.dart';
import '../repository/close_account_repository.dart';
import '../resources/app_theme.dart';
import '../routers/my_router.dart';
import '../utils/api_contant.dart';
import '../widgets/common_outline_button.dart';

class RadioButtonsContactInfo extends StatefulWidget {
  const RadioButtonsContactInfo({Key? key}) : super(key: key);

  @override
  State<RadioButtonsContactInfo> createState() => _RadioButtonsContactInfoState();
}

class _RadioButtonsContactInfoState extends State<RadioButtonsContactInfo> {

  var reason = "";
  final controller  = Get.put(ContactInfoController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: 20),
      contentPadding:
      EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Align(
                alignment:
                Alignment.topRight,
                child: SizedBox(
                  height: 15,
                  width: 20,
                ),
              ),
              Positioned(
                  top: -15,
                  right: -15,
                  child: IconButton(
                    onPressed: () =>
                        Navigator.pop(
                            context),
                    icon: Icon(
                      Icons.clear,
                      size: 20,
                    ),
                  ))
            ],
          ),
          Text(
            "Close Account",
            style: TextStyle(
                fontSize: 16,
                fontWeight:
                FontWeight.w600,
                color:
                AppTheme.textColor),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: AppTheme.pinkText
                .withOpacity(.29),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 150,
            width: MediaQuery.of(context)
                .size
                .width,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.reasons.data!.length,
              itemBuilder:
                  (BuildContext context,
                  int index) {
                return RadioListTile(
                    title: Text(
                      controller.reasons.data![index].title.toString(),
                      style: TextStyle(fontSize: 14,
                          color: AppTheme.darkBlueText,
                          fontWeight: FontWeight.w500),
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    dense: true,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    value:  controller.reasons.data![index].id.toString(),
                    groupValue: reason,
                    onChanged: (value) {
                      setState(() {
                        reason = value.toString();
                        print(reason);
                      });
                    });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CustomOutlineButton(
                  onPressed: (){
                    Get.back();
                  },
                  title: "Cancel",
                  backgroundColor: AppTheme.whiteColor,
                  textColor: AppTheme.primaryColor,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Expanded(
                child: CustomOutlineButton(

                  onPressed: (){
                    if(reason == ""){
                      showToast("Please select a reason");
                    }
                    else {
                      closeAccountRepo(reason_id: reason,context: context).then((value){
                        if(value.status == true){
                          Get.offAllNamed(MyRouter.loginScreen);
                        }
                        showToast(value.message.toString());
                      });
                    }

                  },
                  title: "Close account",
                  backgroundColor: AppTheme.primaryColor,
                  textColor: AppTheme.whiteColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
