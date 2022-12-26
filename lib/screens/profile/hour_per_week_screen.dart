import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../widgets/custom_textfield.dart';

class HoursPerWeekScreen extends StatefulWidget {
  const HoursPerWeekScreen({Key? key}) : super(key: key);

  @override
  State<HoursPerWeekScreen> createState() => _HoursPerWeekScreenState();
}

class _HoursPerWeekScreenState extends State<HoursPerWeekScreen> {
  RxString time = "".obs;

  Rx<RxStatus> status = RxStatus
      .empty()
      .obs;
  ModelHoursPerWeek timeList = ModelHoursPerWeek();

  final controller = Get.put(ProfileScreenController());

  @override
  void initState() {
    super.initState();
    getData();
    _priceController.text = controller.model.value.data!.basicInfo!.amount.toString();

  }

  getData() {
    print("object");
    hoursPerWeekRepo(context).then((value) {
      timeList = value;
      if (value.status == true) {
        status.value = RxStatus.success();
        for (var item in timeList.data!) {
          if(item.title!.toLowerCase() == controller.model.value.data!.hoursPerWeek!.toLowerCase()){
            time.value = item.id.toString();
            break;
          }
        }
      } else {
        status.value = RxStatus.error();
      }
    });
  }

  final TextEditingController _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              ? Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Hours per week",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: AppTheme.textColor),
                    ),
                  ),
                  Divider(
                    color: AppTheme.pinkText.withOpacity(.29),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      /// for pushing
                      children: [
                        const Text(
                          "Knowing how much can you work helps freelancer find the right jobs for you.",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppTheme.textColor),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "I can currently work",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: AppTheme.textColor),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: timeList.data!.length,
                            itemBuilder: (context, index) {
                              return Obx(() {
                                return RadioListTile(
                                  title: Text(
                                    timeList.data![index].title.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.settingsTextColor),
                                  ),
                                  contentPadding: const EdgeInsets.all(0),
                                  dense: true,
                                  visualDensity: const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  value:
                                  timeList.data![index].id.toString(),
                                  groupValue: time.value,
                                  onChanged: (value) {
                                      time.value = value.toString();
                                      if (kDebugMode) {
                                        print(time.value);
                                      }
                                  },
                                );
                              });
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Hourly price",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppTheme.textColor),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                inputFormatters1: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                prefix: const Icon(Icons.attach_money),
                                controller: _priceController,
                                obSecure: false.obs,
                                keyboardType: TextInputType.number,
                                hintText: "5.00".obs,
                                validator: (value){
                                  if(value!.isEmpty && value.toString().trim() != ""){
                                    return "Please enter your hourly price";
                                  }
                                  else if(double.parse(value.isEmpty ? "0" : value) < 3){
                                    return "Minimum hourly price must be 3 \$";
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                /*validator: MultiValidator([
                                  RequiredValidator(
                                      errorText:
                                      'Please enter your hourly price'),
                                ]),*/
                              ),
                            ),
                            const Text(
                              " / hour",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppTheme.textColor),
                            ),
                            const SizedBox(
                              width: 30,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
              : const Center(child: CircularProgressIndicator());
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
                    if (_formKey.currentState!.validate()) {
                      editHoursPerWeekRepo(
                          hours_id: time.value,
                          hours_price: _priceController.text.trim(),
                          context: context)
                          .then((value) {
                        if (value.status == true) {
                          Get.back();
                          controller.getData();
                        }
                        showToast(value.message.toString());
                      });
                    }
                  },
                  textColor: AppTheme.whiteColor,
                  expandedValue: false,
                ),
              ),
            ),
          ])
              : const SizedBox();
        }));
  }
}
