import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';

import '../controller/profie_screen_controller.dart';

class RadioButtonsProfileScreen extends StatefulWidget {
  const RadioButtonsProfileScreen({Key? key}) : super(key: key);

  @override
  State<RadioButtonsProfileScreen> createState() =>
      _RadioButtonsProfileScreenState();
}

class _RadioButtonsProfileScreenState extends State<RadioButtonsProfileScreen> {
  final controller = Get.put(ProfileScreenController());
  String? time;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.clear,
                  color: AppTheme.blackColor,
                  size: 20,
                ),
              ),
            )
          ],
        ),
        RadioListTile(
          title: Text(
            "Newest first",
            style: TextStyle(
                fontSize: 14,
                color: AppTheme.darkBlueText,
                fontWeight: FontWeight.w500),
          ),
          contentPadding: const EdgeInsets.all(0),
          dense: true,
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          value: "Newest first",
          groupValue: time,
          onChanged: (value) {
            setState(() {
              time = value.toString();
              controller.timeValue.value = value.toString();
            });
          },
        ),
        RadioListTile(
          title: Text(
            "Highest rated",
            style: TextStyle(
                fontSize: 14,
                color: AppTheme.darkBlueText,
                fontWeight: FontWeight.w500),
          ),
          contentPadding: const EdgeInsets.all(0),
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          value: "Highest rated",
          groupValue: time,
          onChanged: (value) {
            setState(() {
              time = value.toString();
              controller.timeValue.value = value.toString();
            });
          },
        ),
        RadioListTile(
          title: Text(
            "Lowest rated",
            style: TextStyle(
                fontSize: 14,
                color: AppTheme.darkBlueText,
                fontWeight: FontWeight.w500),
          ),
          contentPadding: const EdgeInsets.all(0),
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          value: "3 to 6 month",
          groupValue: time,
          onChanged: (value) {
            setState(() {
              time = value.toString();
              controller.timeValue.value = value.toString();
            });
          },
        ),
        RadioListTile(
          title: Text(
            "Lowest rated",
            style: TextStyle(
                fontSize: 14,
                color: AppTheme.darkBlueText,
                fontWeight: FontWeight.w500),
          ),
          contentPadding: const EdgeInsets.all(0),
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          value: "Largest projects",
          groupValue: time,
          onChanged: (value) {
            setState(() {
              time = value.toString();
              controller.timeValue.value = value.toString();
            });
          },
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
