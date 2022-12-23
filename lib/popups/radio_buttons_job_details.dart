import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/jobs_detail_controller.dart';
import '../resources/app_theme.dart';

class RadioButtonsJobDetails extends StatefulWidget {
  const RadioButtonsJobDetails({Key? key}) : super(key: key);

  @override
  State<RadioButtonsJobDetails> createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtonsJobDetails> {
  final controller = Get.put(JobsDetailController());
  String? time;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 13),
                    child: Text(
                      "Select a duration",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -16,
                  right: -16,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.clear,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            RadioListTile(
              title: Text(
                "More than 6 Month",
                style:
                    TextStyle(fontSize: 14, color: AppTheme.settingsTextColor),
              ),
              contentPadding: const EdgeInsets.all(0),
              dense: true,
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              value: "More than 6 Month",
              groupValue: time,
              onChanged: (value) {
                setState(() {
                  time = value.toString();
                  controller.duration.value = value.toString();
                  controller.durationController.text = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text(
                "3 to 6 months",
                style:
                    TextStyle(fontSize: 14, color: AppTheme.settingsTextColor),
              ),
              contentPadding: const EdgeInsets.all(0),
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              value: "3 to 6 months",
              groupValue: time,
              onChanged: (value) {
                setState(() {
                  time = value.toString();
                  controller.duration.value = value.toString();
                  controller.durationController.text = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text(
                "1 to 3 months",
                style:
                    TextStyle(fontSize: 14, color: AppTheme.settingsTextColor),
              ),
              contentPadding: const EdgeInsets.all(0),
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              value: "1 to 3 months",
              groupValue: time,
              onChanged: (value) {
                setState(() {
                  time = value.toString();
                  controller.duration.value = value.toString();
                  controller.durationController.text = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text(
                "Less than 1 month",
                style:
                    TextStyle(fontSize: 14, color: AppTheme.settingsTextColor),
              ),
              contentPadding: const EdgeInsets.all(0),
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              value: "less than 1 month",
              groupValue: time,
              onChanged: (value) {
                setState(() {
                  time = value.toString();
                  controller.duration.value = value.toString();
                  controller.durationController.text = value.toString();
                });
              },
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ));
  }
}
