import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../models/model_freelancer_profile.dart';
import '../models/model_language_list.dart';
import '../repository/languages_list_repository.dart';
import '../repository/profile_screen_repository.dart';

class ProfileScreenController extends GetxController {
  RxString timeValue = "".obs;

  Rx<ModelFreelancerProfile> model = ModelFreelancerProfile().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;

  ModelLanguageList languages = ModelLanguageList();






  @override
  void onInit() {
    super.onInit();
    getData();
    getLanguageData();
  }
  getData() {
    print("object");
    freelancerProfileRepo().then((value) {
      log(jsonEncode(value));
      model.value = value;
      if (value.status == true) {
        status.value = RxStatus.success();
      }
      else{
        status.value = RxStatus.error();
      }
    });
  }

  getLanguageData() {
    languagesListRepo().then((value) {
      languages = value;
      if (value.status == true) {
        print(languages);
      }
    });
  }
}
