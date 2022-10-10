import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../models/model_freelancer_profile.dart';
import '../repository/profile_screen_repository.dart';

class ProfileScreenController extends GetxController {
  RxString timeValue = "".obs;

  Rx<ModelFreelancerProfile> model = ModelFreelancerProfile().obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }
  getData() {
    print("object");
    freelancerProfileRepo().then((value) {
      log(jsonEncode(value));
      if (value.status == true) {
        model.value = value;
        loading.value = true;
      }
    });
  }
}
