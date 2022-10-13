import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/app_theme.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class HoursPerWeekScreen extends StatefulWidget {
  const HoursPerWeekScreen({Key? key}) : super(key: key);

  @override
  State<HoursPerWeekScreen> createState() => _HoursPerWeekScreenState();
}

class _HoursPerWeekScreenState extends State<HoursPerWeekScreen> {
  var time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppbar(
            isLikeButton: false,
            isProfileImage: false,
            titleText: "Freelance Profile",
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Hours per week",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppTheme.textColor),
                ),
              ),
              Divider(
                color: AppTheme.pinkText.withOpacity(.29),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Knowing how much can you work helps freelancer find the right jobs for you",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: AppTheme.textColor),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RadioListTile(
                      title: Text(
                        "More than 30 hrs/week",
                        style: TextStyle(
                            fontSize: 14, color: AppTheme.settingsTextColor),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      value: "More than 30 hrs/week",
                      groupValue: time,
                      onChanged: (value) {
                        setState(() {
                          time = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        "Less than 30 hrs/week",
                        style: TextStyle(
                            fontSize: 14, color: AppTheme.settingsTextColor),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      value: "Less than 30 hrs/week",
                      groupValue: time,
                      onChanged: (value) {
                        setState(() {
                          time = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        "As needed - open to offer",
                        style: TextStyle(
                            fontSize: 14, color: AppTheme.settingsTextColor),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      value: "As needed - open to offer",
                      groupValue: time,
                      onChanged: (value) {
                        setState(() {
                          time = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        "None",
                        style: TextStyle(
                            fontSize: 14, color: AppTheme.settingsTextColor),
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                      value: "None",
                      groupValue: time,
                      onChanged: (value) {
                        setState(() {
                          time = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Row(children: [
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
        ])
    );
  }
}
