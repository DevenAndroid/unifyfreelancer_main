import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/repository/hours_per_week_repository.dart';
import 'package:unifyfreelancer/utils/api_contant.dart';

import '../../controller/profie_screen_controller.dart';
import '../../models/model_hours_per_week.dart';
import '../../repository/edit_hours_per_week_repository.dart';
import '../../resources/app_theme.dart';
import '../../resources/size.dart';
import '../../widgets/common_outline_button.dart';
import '../../widgets/custom_appbar.dart';

class HoursPerWeekScreen extends StatefulWidget {
  const HoursPerWeekScreen({Key? key}) : super(key: key);

  @override
  State<HoursPerWeekScreen> createState() => _HoursPerWeekScreenState();
}

class _HoursPerWeekScreenState extends State<HoursPerWeekScreen> {
  var time;

  Rx<RxStatus> status = RxStatus.empty().obs;
  ModelHoursPerWeek timeList = ModelHoursPerWeek();

  final controller = Get.put(ProfileScreenController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    print("object");
    hoursPerWeekRepo(context).then((value) {
      timeList = value;
      if (value.status == true) {
        status.value = RxStatus.success();
      } else {
        status.value = RxStatus.error();
      }
    });
  }

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
        body: Obx(() {
          return status.value.isSuccess
              ? SingleChildScrollView(
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
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: timeList.data!.length,
                                itemBuilder: (context, index) {
                                  return RadioListTile(
                                    title: Text(
                                      timeList.data![index].title.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppTheme.settingsTextColor),
                                    ),
                                    contentPadding: const EdgeInsets.all(0),
                                    dense: true,
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    value: timeList.data![index].id.toString(),
                                    groupValue: time,
                                    onChanged: (value) {
                                      setState(() {
                                        time = value.toString();
                                        print(time);
                                      });
                                    },
                                  );
                                }),
                            /* RadioListTile(
                              title: Text(
                                "More than 30 hrs/week",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.settingsTextColor),
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
                                    fontSize: 14,
                                    color: AppTheme.settingsTextColor),
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
                                    fontSize: 14,
                                    color: AppTheme.settingsTextColor),
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
                                    fontSize: 14,
                                    color: AppTheme.settingsTextColor),
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
                            ),*/
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : status.value.isError
                  ? SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            timeList.message.toString(),
                            // fontSize: AddSize.font16,
                          ),
                          IconButton(
                              onPressed: () {
                                getData();
                              },
                              icon: Icon(
                                Icons.change_circle_outlined,
                                size: AddSize.size30,
                              ))
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator());
        }),
        bottomNavigationBar: Obx(() {
          return status.value.isSuccess
              ? Row(children: [
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
                        onPressed: () {
                          editHoursPerWeekRepo(time, context).then((value) {
                            if (value.status == true) {
                              Get.back();
                              controller.getData();
                            }
                            showToast(value.message.toString());
                          });
                        },
                        textColor: AppTheme.whiteColor,
                        expandedValue: false,
                      ),
                    ),
                  ),
                ])
              : SizedBox();
        }));
  }
}
